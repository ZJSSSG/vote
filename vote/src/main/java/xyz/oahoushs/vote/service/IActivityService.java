package xyz.oahoushs.vote.service;

import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.result.Result;

public interface IActivityService {
    Result deleteActivity(String activityId);

    Result listActivity(int page, int size);

    Result getActivity(String activityId);

    Result addActivity(Activity activity);

    Result updateActivity(String activityId,Activity activity);

    Result listActivityByUser(String userName, int page, int size);

    Result listActivityByCase(int page, int size);
}
