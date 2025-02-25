package xyz.oahoushs.vote.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.pojo.UserActivity;

import java.util.List;

public interface UserActivityDAO extends JpaRepository<UserActivity,String>, JpaSpecificationExecutor<UserActivity> {

    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_user_activity` SET `state` = '0' WHERE `id` = ?")
    int deleteActivityByState(String id);

    UserActivity findOneById(String id);

    Page<UserActivity> findAll(Pageable pageable);

    //分页列出案例
    @Query(value = " select * from tb_user_activity a where  a.state = '2'",nativeQuery = true)
            List<UserActivity> findByState(Pageable pageable);

    Page<UserActivity> findAllByActivityId(String activityId ,Pageable pageable);

    Page<UserActivity> findAllByUserName (String userName ,Pageable pageable);


}
