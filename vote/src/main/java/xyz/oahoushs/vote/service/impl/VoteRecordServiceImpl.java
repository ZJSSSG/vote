package xyz.oahoushs.vote.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xyz.oahoushs.vote.dao.ActivityDAO;
import xyz.oahoushs.vote.dao.CandidateDAO;
import xyz.oahoushs.vote.dao.VoteRecordDAO;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.pojo.VoteRecord;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.IActivityService;
import xyz.oahoushs.vote.service.ICandidateService;
import xyz.oahoushs.vote.service.IVoteRecordService;
import xyz.oahoushs.vote.utils.Constants;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.TextUtils;
import xyz.oahoushs.vote.utils.RedisUtils;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class VoteRecordServiceImpl implements IVoteRecordService {



    @Autowired
    IdWorker idWorker;

    @Autowired
    VoteRecordDAO voteRecordDAO;

    @Autowired
    ICandidateService candidateService;

    @Autowired
    ActivityDAO activityDAO;

    @Autowired
    CandidateDAO candidateDAO;

    @Autowired
    RedisUtils redisUtils;

    /**
     * 单选
     * @param voteRecord
     * @return
     */
    @Override
    public Result singleVote(String captcha,String captchaKey,VoteRecord voteRecord) {
        //1.根据aid 获取活动 ===》 根据活动获取类型
        Activity activity = activityDAO.findOneById(voteRecord.getAid());//获取活动

        JSONObject typeJson = JSONObject.parseObject(activity.getType());//字符串转json
        Map typeMap =  JSONObject.parseObject(typeJson.toJSONString());//json转map

        //2.根据cid 获取选手 ===》 根据选手更新票数
        Candidate candidate = candidateDAO.findOneById(voteRecord.getCid());//投票选手

        int totalVotes = Integer.parseInt(typeMap.get("totalVotes").toString());
        int oneVotes = Integer.parseInt(typeMap.get("oneVotes").toString());

        //3.如果需要验证码，判断验证码是否正确
        if(activity.isVerifyCode()){
            String captchaVerifyCode = (String) redisUtils.get(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
            log.info("captchaVerifyCode === > " + captchaVerifyCode);
            if (TextUtils.isEmpty(captchaVerifyCode)) {
                return ResultFactory.buildFailResult("验证码已过期");
            }
            if (!captchaVerifyCode.equals(captcha)) {
                return ResultFactory.buildFailResult("验证码不正确");
            } else {
                redisUtils.del(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
            }
        }
        //4.如果是非周期性投票
        if(typeMap.get("cycleType").equals("false")){
            int userTotalVotes = voteRecordDAO.countByAidAndUid(activity.getId(),voteRecord.getUid());
            int userOneVotes = voteRecordDAO.countByAidAndCidAndUid(activity.getId(),candidate.getId(),voteRecord.getUid());
            //1.判断总投票数是否超过限制
            if(userTotalVotes >= totalVotes){
                return ResultFactory.buildFailResult("你已经投过票了");
            }
            //2.判断为同一人投票是否超过限制
            if(userOneVotes >= oneVotes){
                return ResultFactory.buildFailResult("为同一人投票超过限制");
            }
            //3.都未超过，增加记录，更新候选人票数
            voteRecord.setId(idWorker.nextId()+"");
            voteRecord.setVoteTime(new Date());
            voteRecordDAO.save(voteRecord);
            int voteCount = candidate.getVoteCount()+1;
            candidate.setVoteCount(voteCount);
            candidateService.updateCandidate(candidate.getId(),candidate);
            return ResultFactory.buildSuccessResult("投票成功");
        }else{ //4.如果是周期性投票
            List<VoteRecord> userTotalVotes = voteRecordDAO.listToday(voteRecord.getAid(),voteRecord.getUid());
            List<VoteRecord> userOneVotes = voteRecordDAO.listTodayCid(String.valueOf(voteRecord.getAid()),voteRecord.getCid(),voteRecord.getUid());
            //1.判断今天总投票数是否超过限制
            if(userTotalVotes.size() >= totalVotes){
                return ResultFactory.buildFailResult("今天投票已经超过限制了，明天再来吧");
            }
            //2.判断今天为同一人投票是否超过限制
            if(userOneVotes.size() >= oneVotes){
                return ResultFactory.buildFailResult("今天为同一人投票超过限制了，支持一下别的选手吧");
            }
            //3.满足条件，增加记录，更新候选人票数
            voteRecord.setId(idWorker.nextId()+"");
            voteRecord.setVoteTime(new Date());
            voteRecordDAO.save(voteRecord);
            int voteCount = candidate.getVoteCount()+1;
            candidate.setVoteCount(voteCount);
            candidateService.updateCandidate(candidate.getId(),candidate);
            return ResultFactory.buildSuccessResult("投票成功");
        }
    }

    @Override
    public Result multipleVote(String captcha,String captchaKey,JSONObject voteData) {
        log.info("voteData ==== > ",voteData);
        JSONObject jsonObject = voteData.getJSONObject("voteData");
        //根据活动id 获取活动
        String aid = jsonObject.getString("aid");
        Activity activity = activityDAO.findOneById(aid);//获取活动
        //获取用户id
        int uid = jsonObject.getInteger("uid");
        //获取活动类型
        JSONObject typeJson = JSONObject.parseObject(activity.getType());//字符串转json
        Map typeMap =  JSONObject.parseObject(typeJson.toJSONString());//json转map
        //选中的选手id
        jsonObject.getJSONArray("selectedIds");
        jsonObject.getJSONArray("selectedIds").toArray();
        JSONArray array = jsonObject.getJSONArray("selectedIds");
        List<String> selectedIds = JSONObject.parseArray(array.toJSONString(), String.class);

        //1.如果需要验证码，判断验证码是否正确
        if(activity.isVerifyCode()){
            String captchaVerifyCode = (String) redisUtils.get(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
            log.info("captchaVerifyCode === > " + captchaVerifyCode);
            if (TextUtils.isEmpty(captchaVerifyCode)) {
                return ResultFactory.buildFailResult("验证码已过期");
            }
            if (!captchaVerifyCode.equals(captcha)) {
                return ResultFactory.buildFailResult("验证码不正确");
            } else {
                redisUtils.del(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
            }
        }
        //判断是否是周期性投票
        //1.非周期性投票
        if(typeMap.get("cycleType").equals("false")){
            int userTotalVotes = voteRecordDAO.countByAidAndUid(activity.getId(),uid);
            if(userTotalVotes > 0){
                return ResultFactory.buildFailResult("你已经投过票");
            }else {
                for(String cid : selectedIds){
                    //增加记录
                    VoteRecord voteRecord = new VoteRecord();
                    voteRecord.setId(idWorker.nextId()+"");
                    voteRecord.setAid(aid);
                    voteRecord.setUid(uid);
                    voteRecord.setCid(cid);
                    voteRecord.setVoteTime(new Date());
                    voteRecordDAO.save(voteRecord);
                    //更新选手票数
                    Candidate candidate = candidateDAO.findOneById(cid);
                    int voteCount = candidate.getVoteCount()+1;
                    candidate.setVoteCount(voteCount);
                    candidateService.updateCandidate(candidate.getId(),candidate);
                }
                return ResultFactory.buildSuccessResult("投票成功");
            }
        }else {
            //周期性投票
            List<VoteRecord> vs = voteRecordDAO.listToday(aid,uid);
            if(vs.size() > 0){
                return ResultFactory.buildFailResult("今天已经投过票了，明天再来吧！");
            }else {
                for(String cid : selectedIds){
                    //增加记录
                    VoteRecord voteRecord = new VoteRecord();
                    voteRecord.setId(idWorker.nextId()+"");
                    voteRecord.setAid(aid);
                    voteRecord.setUid(uid);
                    voteRecord.setCid(cid);
                    voteRecord.setVoteTime(new Date());
                    voteRecordDAO.save(voteRecord);
                    //更新选手票数
                    Candidate candidate = candidateDAO.findOneById(cid);
                    int voteCount = candidate.getVoteCount()+1;
                    candidate.setVoteCount(voteCount);
                    candidateService.updateCandidate(candidate.getId(),candidate);
                }
                return ResultFactory.buildSuccessResult("投票成功");
            }
        }
    }

}
