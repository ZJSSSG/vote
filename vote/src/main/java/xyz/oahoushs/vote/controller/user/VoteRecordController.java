package xyz.oahoushs.vote.controller.user;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import xyz.oahoushs.vote.dao.CandidateDAO;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.pojo.CandidateForResult;
import xyz.oahoushs.vote.pojo.VoteRecord;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.service.IVoteRecordService;
import xyz.oahoushs.vote.utils.DownExcel;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api")
public class VoteRecordController {

    @Autowired
    CandidateDAO candidateDAO;

    @Autowired
    IVoteRecordService voteRecordService;


    @PostMapping(value = {"/vote/single/{captcha}/{captcha_key}","/vote/single/{captcha_key}"})
    public Result singleVote(@PathVariable(value = "captcha",required = false) String captcha,
                             @PathVariable(value = "captcha_key",required = false) String captchaKey,
                             @RequestBody VoteRecord voteRecord){
        return voteRecordService.singleVote(captcha,captchaKey,voteRecord);
    }

    @PostMapping(value = {"/vote/multiple/{captcha}/{captcha_key}","/vote/multiple/{captcha_key}"})
    public Result multipleVote(@PathVariable(value = "captcha",required = false) String captcha,
                               @PathVariable(value = "captcha_key",required = false) String captchaKey,
                               @RequestBody JSONObject voteData){
        log.info("voteData === > ",voteData);
        return voteRecordService.multipleVote(captcha,captchaKey,voteData);
    }

    //导出为Excel
    @RequestMapping("/download-result/{activityId}")
    public void getExcel(@PathVariable("activityId")String activityId, HttpServletResponse response) throws IllegalAccessException, IOException,
            InstantiationException {
        List<Candidate> candidates = candidateDAO.listRankCandidate(activityId);
        List<CandidateForResult> listResult = new ArrayList<>();
        int rank = 1;
        for(Candidate c : candidates){
            CandidateForResult candidateForResult = new CandidateForResult();
            candidateForResult.setRank(rank++);
            candidateForResult.setId(c.getId());
            candidateForResult.setNum(c.getNum());
            candidateForResult.setTitle(c.getTitle());
            candidateForResult.setVoteCount(c.getVoteCount());
            candidateForResult.setAid(c.getAid());
            candidateForResult.setCoverUrl(c.getCoverUrl());
            candidateForResult.setItemDesc(c.getItemDesc());
            candidateForResult.setCreateTime(c.getCreateTime());
            candidateForResult.setUpdateTime(c.getUpdateTime());
            listResult.add(candidateForResult);
        }
        DownExcel.download(response, CandidateForResult.class,listResult);
    }
}
