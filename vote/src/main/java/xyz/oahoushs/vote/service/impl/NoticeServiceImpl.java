package xyz.oahoushs.vote.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import xyz.oahoushs.vote.dao.NoticeDAO;
import xyz.oahoushs.vote.pojo.Notice;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.INoticeService;
import xyz.oahoushs.vote.utils.Constants;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.TextUtils;

import javax.transaction.Transactional;
import java.util.Date;

@Slf4j
@Service
@Transactional
public class NoticeServiceImpl extends BaseService implements INoticeService {


    @Autowired
    IdWorker idWorker;
    @Autowired
    NoticeDAO noticeDAO;


    @Override
    public Result addNotice(Notice notice) {
        //判断数据
        if (TextUtils.isEmpty(notice.getTitle())) {
            return ResultFactory.buildFailResult("标题不能为空.");
        }
        if (TextUtils.isEmpty(notice.getContent())) {
            return ResultFactory.buildFailResult("内容不能为空.");
        }
        //补全数据
        notice.setId(idWorker.nextId() + "");
        notice.setState("1");
        notice.setCreateTime(new Date());
        notice.setUpdateTime(new Date());
        //保存到数据库
        noticeDAO.save(notice);
        return ResultFactory.buildSuccessResult(notice);
    }

    @Override
    public Result updateNotice(String noticeId, Notice notice) {
        Notice noticeFromDb = noticeDAO.findOneById(noticeId);
        //判断数据
        if (TextUtils.isEmpty(notice.getTitle())) {
            return ResultFactory.buildFailResult("标题不能为空.");
        }
        if (TextUtils.isEmpty(notice.getContent())) {
            return ResultFactory.buildFailResult("内容不能为空.");
        }

        //补全数据
        noticeFromDb.setTitle(notice.getTitle());
        noticeFromDb.setContent(notice.getContent());
        noticeFromDb.setUpdateTime(new Date());
        //保存到数据库
        noticeDAO.save(noticeFromDb);
        return ResultFactory.buildSuccessResult(noticeFromDb);

    }

    @Override
    public Result listNotice(int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        //根据创建日期降序
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page - 1, size,sort);

        Page<Notice> all = noticeDAO.findAll(pageable);
        return ResultFactory.buildSuccessResult(all);
    }

    @Override
    public Result deleteNotice(String noticeId) {
       try{
           noticeDAO.deleteById(noticeId);
           return ResultFactory.buildSuccessResult("删除成功.");
       }catch (Exception e){
           return ResultFactory.buildFailResult("删除失败.");
       }
    }

    @Override
    public Result getNotice(String noticeId) {

        Notice notice = noticeDAO.findOneById(noticeId);
        if(notice == null){
            return ResultFactory.buildFailResult("活动不存在");
        }
        return ResultFactory.buildSuccessResult(notice);
    }
}
