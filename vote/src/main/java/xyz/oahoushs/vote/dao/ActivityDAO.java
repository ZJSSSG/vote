package xyz.oahoushs.vote.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.Candidate;

import java.util.List;

public interface ActivityDAO extends JpaRepository<Activity,String>, JpaSpecificationExecutor<Activity> {

    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_acticity` SET `state` = '0' WHERE `id` = ?")
    int deleteActivityByState(String activityId);

    Activity findOneById(String activityId);

    Page<Activity> findAll(Pageable pageable);

    //分页列出案例
    @Query(value = " select * from tb_activity a where  a.state = '2'",nativeQuery = true)
    List<Activity> findByState(Pageable pageable);
    @Query(value = " select * from tb_activity a where  a.author = ? and a.state != '0'",nativeQuery = true)
    Page<Activity> findAllByAuthor(String author ,Pageable pageable);

    @Query(value = " select * from tb_activity a inner join tb_user_activity b on a.id=b.activity_id  where  a.state = '1' and `user_Name`=? ",nativeQuery = true)
    Page<Activity> findAllCanVote(String userName, Pageable pageable);
}
