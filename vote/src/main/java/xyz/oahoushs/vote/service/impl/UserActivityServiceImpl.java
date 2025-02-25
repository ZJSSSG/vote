package xyz.oahoushs.vote.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import xyz.oahoushs.vote.dao.UserActivityDAO;
import xyz.oahoushs.vote.pojo.UserActivity;
import xyz.oahoushs.vote.service.UserActivityService;

import java.util.List;

/**
 * @ClassName: UserActivityServiceImpl
 * @Description:
 * @Author H
 * @Date 2025/2/25
 * @Version 1.0
 */
public class UserActivityServiceImpl implements UserActivityService {
    @Autowired
    UserActivityDAO userActivityDAO;
    @Override
    public int deleteActivityByState(String id) {
        return userActivityDAO.deleteActivityByState(id);
    }

    @Override
    public UserActivity findOneById(String id) {
        return userActivityDAO.findOneById(id);
    }

    @Override
    public Page<UserActivity> findAll(Pageable pageable) {
        return userActivityDAO.findAll(pageable);
    }

    @Override
    public List<UserActivity> findByState(Pageable pageable) {
        return userActivityDAO.findByState(pageable);
    }

    @Override
    public Page<UserActivity> findAllByActivityId(String activityId, Pageable pageable) {
        return userActivityDAO.findAllByActivityId(activityId,pageable);
    }

    @Override
    public Page<UserActivity> findAllByUserId(String userId, Pageable pageable) {
        return userActivityDAO.findAllByUserName(userId,pageable);

    }
}
