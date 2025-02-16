package xyz.oahoushs.vote.dao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.VoteRecord;

import java.util.List;

public interface VoteRecordDAO extends JpaRepository<VoteRecord,String>, JpaSpecificationExecutor<VoteRecord> {
    int countByAidAndUid(String aid,int uid); //总投票

    int countByAidAndCidAndUid(String aid,String cid,int uid); //为同一选手投票

    //今天总记录
    @Query(value = " select * from tb_vote_record v where v.vote_time  > current_date() and v.aid = ?1 and v.uid = ?2",nativeQuery = true)
    List<VoteRecord> listToday(String aid,int uid);

    //今天为同一选手的记录
    @Query(value = " select * from tb_vote_record v where  v.vote_time  > current_date() and v.aid = ?1 and v.cid = ?2 and v.uid = ?3 ",nativeQuery = true)
    List<VoteRecord> listTodayCid(String aid,String cid,int uid);

}
