package xyz.oahoushs.vote.service;

import com.alibaba.fastjson.JSONObject;
import xyz.oahoushs.vote.pojo.VoteRecord;
import xyz.oahoushs.vote.result.Result;

public interface IVoteRecordService {
    Result singleVote(String captcha,String captchaKey,VoteRecord voteRecord);

    Result multipleVote(String captcha,String captchaKey,JSONObject voteData);
}
