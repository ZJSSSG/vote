package xyz.oahoushs.vote.service;

import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.result.Result;

public interface ICandidateService {


    Result deleteCandidate(String candidateId);

    Result getCandidate(String candidateId);

    Result listCandidate(String activityId, int page, int size);

    Result listNormalCandidate(String activityId, int page, int size);

    Result listAllNormalCandidate(String activityId);

    Result addCandidate(Candidate candidate);

    Result updateCandidate(String candidateId, Candidate candidate);

    Result updateState(String candidateId, boolean state);


    Result listRankCandidate(String activityId);
}
