package xyz.oahoushs.vote.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.Notice;


public interface NoticeDAO extends JpaRepository<Notice,String>, JpaSpecificationExecutor<Notice> {
    Notice findOneById(String noticeId);

    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_notice` SET `state` = '0' WHERE `id` = ?")
    int deleteNoticeByState(String noticeId);
}
