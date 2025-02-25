package xyz.oahoushs.vote.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.dao.UserActivityDAO;
import xyz.oahoushs.vote.pojo.UserActivity;

import java.util.List;

/**
 * @ClassName: UserActivityService
 * @Description:
 * @Author H
 * @Date 2025/2/25
 * @Version 1.0
 */
public interface UserActivityService {

    int deleteActivityByState(String id);

    UserActivity findOneById(String id);

    Page<UserActivity> findAll(Pageable pageable);


    List<UserActivity> findByState(Pageable pageable);

    Page<UserActivity> findAllByActivityId(String activityId ,Pageable pageable);

    Page<UserActivity> findAllByUserId(String userId ,Pageable pageable);

}
