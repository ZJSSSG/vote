package xyz.oahoushs.vote.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import xyz.oahoushs.vote.dao.ActivityDAO;
import xyz.oahoushs.vote.dao.AdminRoleDAO;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.AdminRole;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.AdminRoleService;
import xyz.oahoushs.vote.service.IActivityService;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.TextUtils;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@Transactional
public class ActivityServiceImpl extends BaseService implements IActivityService {


    @Autowired
    IdWorker idWorker;

    @Autowired
    ActivityDAO activityDAO;
    @Autowired
    AdminRoleService adminRoleService;

    @Override
    public Result deleteActivity(String activityId) {
        int result = activityDAO.deleteActivityByState(activityId);
        if (result == 0) {
            return ResultFactory.buildFailResult("删除失败.");
        }
        return ResultFactory.buildSuccessResult("删除成功.");
    }

    /**
     * 需要管理员权限
     * @param page
     * @param size
     * @return
     */
    @Override
    public Result listActivity(int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);

        //根据创建日期降序
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page - 1, size,sort);

        Page<Activity> all = activityDAO.findAll(pageable);
        return ResultFactory.buildSuccessResult(all);
    }

    @Override
    public Result listActivityByUser(String userName,int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        //根据创建日期降序
        Pageable pageable = PageRequest.of(page - 1, size);

        Page<Activity> all = activityDAO.findAllByAuthor(userName,pageable);
        return ResultFactory.buildSuccessResult(all);
    }
    @Override
    public Result listActivityCanVote(String userName,int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        Pageable pageable = PageRequest.of(page - 1, size);

        Page<Activity> all = activityDAO.findAllCanVote(userName,pageable);
        return ResultFactory.buildSuccessResult(all);
    }

    @Override
    public Result listActivityByCase(int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        //根据创建日期降序
        Pageable pageable = PageRequest.of(page - 1, size);
        List<Activity> all = activityDAO.findByState(pageable);
        return ResultFactory.buildSuccessResult(all);
    }


    /**
     *
     * @param activityId
     * @return
     */
    @Override
    public Result getActivity(String activityId) {

        Activity activity = activityDAO.findOneById(activityId);
        if(activity == null){
            return ResultFactory.buildFailResult("活动不存在");
        }
        return ResultFactory.buildSuccessResult(activity);
    }

    @Override
    public Result addActivity(Activity activity) {

        log.info("current activity === >"+activity);
        //判断数据
        String checkInfo =  checkInfo(activity);
        if (!"1".equals(checkInfo)){
            return ResultFactory.buildFailResult(checkInfo);
        }
        log.info("type === > ",activity.getType());
        //补全数据
        if(activity.getType() == null){
            activity.setType( "{\"voteType\":\"single\",\"cycleType\":\"false\",\"oneVotes\":\"1\",\"totalVotes\":\"3\"}");
        }
        activity.setId(idWorker.nextId() + "");
        activity.setState("1");
        activity.setCreateTime(new Date());
        activity.setUpdateTime(new Date());
        Subject subject = SecurityUtils.getSubject();
        String username = subject.getPrincipal().toString();
        List<AdminRole> adminRoles = adminRoleService.listRolesByUser(username);
        for(AdminRole adminRole:adminRoles){
            if(adminRole.getId()==3){
                activity.setState("2");
            }
        }
        //保存到数据库
        activityDAO.save(activity);
        return ResultFactory.buildSuccessResult(activity);
    }

    @Override
    public Result updateActivity(String activityId,Activity activity) {
        Activity activityFromDb = activityDAO.findOneById(activityId);
        //判断数据
        String checkInfo =  checkInfo(activity);
        if (!"1".equals(checkInfo)){
            return ResultFactory.buildFailResult(checkInfo);
        }
        log.info("update activity === >"+activity.toString());
        if (activity.getTitle() != null) {
            activityFromDb.setTitle(activity.getTitle());
        }
        if (activity.getContent() != null) {
            activityFromDb.setContent(activity.getContent());
        }
        if (activity.getType() != null) {
            activityFromDb.setType(activity.getType());
        }
        if (activity.getSignIn() != null) {
            activityFromDb.setSignIn(activity.getSignIn());
        }
        if (activity.getVerifyCode() != null) { // 注意：如果是基本数据类型 boolean，这里需要调整为包装类 Boolean
            activityFromDb.setVerifyCode(activity.getVerifyCode());
        }
        if (activity.getState() != null) {
            activityFromDb.setState(activity.getState());
        }
        if (activity.getStartTime() != null) {
            activityFromDb.setStartTime(activity.getStartTime());
        }
        if (activity.getEndTime() != null) {
            activityFromDb.setEndTime(activity.getEndTime());
        }
        activityFromDb.setUpdateTime(new Date());
        //保存到数据库
        activityDAO.save(activityFromDb);
        return ResultFactory.buildSuccessResult(activityFromDb);
    }



    public String checkInfo(Activity activity){


        if(TextUtils.isEmpty(activity.getSignIn())){
            activity.setSignIn("1");
        }

        String message = "1";

        if(TextUtils.isEmpty(activity.getTitle())){
            message = "活动标题不能为空";
            return message;
        }

        if(TextUtils.isEmpty(activity.getContent())){
            message = "活动内容不能为空";
            return message;
        }
        if(activity.getStartTime() == null){
            message = "开始时间不能为空";
            return message;
        }
        if (activity.getEndTime() == null){
            message = "结束时间不能为空";
            return message;
        }
        return message;
    }



}
