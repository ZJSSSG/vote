package xyz.oahoushs.vote.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import xyz.oahoushs.vote.dao.CandidateDAO;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.pojo.User;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.ICandidateService;
import xyz.oahoushs.vote.utils.Constants;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.TextUtils;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@Transactional
public class CandidateServiceImpl  extends BaseService implements ICandidateService {



    @Autowired
    CandidateDAO candidateDAO;

    @Autowired
    IdWorker idWorker;

    @Override
    public Result deleteCandidate(String candidateId) {
        try{
            candidateDAO.deleteById(candidateId);
            return ResultFactory.buildSuccessResult("删除成功.");
        }catch (Exception e){
            return ResultFactory.buildFailResult("删除失败.");
        }
//        int result = candidateDAO.deleteCandidate(candidateId);
//        if (result == 0) {
//            return ResultFactory.buildFailResult("删除失败.");
//        }
//        return ResultFactory.buildSuccessResult("删除成功.");
    }

    @Override
    public Result getCandidate(String candidateId) {
        Candidate candidate = candidateDAO.findOneById(candidateId);
        if(candidate == null){
            return ResultFactory.buildFailResult("候选人不存在.");
        }
        return ResultFactory.buildSuccessResult(candidate);
    }

    /**
     * 根据活动列出所有
     * @param activityId
     * @param page
     * @param size
     * @return
     */
    @Override
    public Result listCandidate(String activityId, int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        //根据创建日期降序
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page - 1, size,sort);

        Page<Candidate> all = candidateDAO.findAllByAid(activityId,pageable);
        return ResultFactory.buildSuccessResult(all);
    }

    /**
     * 列出状态正常的
     * @param activityId
     * @param page
     * @param size
     * @return
     */

    @Override
    public Result listNormalCandidate(String activityId, int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        // 根据创建日期降序
//        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page - 1, size);

        List<Candidate> all = candidateDAO.findNormal(activityId,pageable);
        return ResultFactory.buildSuccessResult(all);
    }

    @Override
    public Result updateState(String candidateId, boolean state) {
        Candidate candidateInDb = candidateDAO.findOneById(candidateId);
        candidateInDb.setState(state);
        try {
            candidateDAO.save(candidateInDb);
        } catch (IllegalArgumentException e) {
            return ResultFactory.buildFailResult("状态更新失败");
        }
        return ResultFactory.buildSuccessResult("状态更新成功");
    }

    @Override
    public Result listRankCandidate(String activityId) {
        List<Candidate> all = candidateDAO.listRankCandidate(activityId);
        return ResultFactory.buildSuccessResult(all);
    }
    @Override
    public Result listAllNormalCandidate(String activityId) {
        List<Candidate> all = candidateDAO.findAllNormal(activityId);
        return ResultFactory.buildSuccessResult(all);
    }


    @Override
    public Result addCandidate(Candidate candidate) {

        candidate.setId(idWorker.nextId()+"");
        candidate.setState(true);
        candidate.setCreateTime(new Date());
        candidate.setUpdateTime(new Date());
        candidateDAO.save(candidate);
        return ResultFactory.buildSuccessResult(candidate);
    }

    @Override
    public Result updateCandidate(String candidateId, Candidate candidate) {
        Candidate candidateFromDb = candidateDAO.findOneById(candidateId);
        candidateFromDb.setTitle(candidate.getTitle());
        candidateFromDb.setNum(candidate.getNum());
        candidateFromDb.setVoteCount(candidate.getVoteCount());
        candidateFromDb.setCoverUrl(candidate.getCoverUrl());
        candidateFromDb.setVideoUrl(candidate.getVideoUrl());
        candidateFromDb.setItemDesc(candidate.getItemDesc());
//      candidateFromDb.setState(candidate.isState());
        candidateFromDb.setUpdateTime(new Date());
        candidateDAO.save(candidateFromDb);
        return ResultFactory.buildSuccessResult("更新成功.");
    }
}
