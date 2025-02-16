package xyz.oahoushs.vote.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.pojo.User;

import java.util.List;

public interface CandidateDAO extends JpaRepository<Candidate,String>, JpaSpecificationExecutor<Candidate> {

    Candidate findOneById(String candidateId);


    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_candidate` SET `state` = '0' WHERE `id` = ?")
    int deleteCandidate(String candidateId);

    //分页列出全部，正常 + 非正常状态
    Page<Candidate> findAllByAid(String activityId, Pageable pageable);


    @Query(value = "select new User(u.id,u.userName,u.avatar,u.email,u.state,u.createTime,u.updateTime) from User as u")
    Page<User> listAllUser(Pageable pageable);

    //分页列出正常状态
    @Query(value = " select * from tb_candidate c where  c.state = '1' and c.aid = ? ",nativeQuery = true)
    List<Candidate> findNormal(String activityId, Pageable pageable);

    //不分页  --- 列出全部正常状态
    @Query(value = " select * from tb_candidate c where  c.state = '1' and c.aid = ? ",nativeQuery = true)
    List<Candidate> findAllNormal(String activityId);

    //排序列出
    @Query(value = " select * from tb_candidate c where  c.state = '1' and c.aid = ? order by vote_count desc",nativeQuery = true)
    List<Candidate> listRankCandidate(String activityId);
}
