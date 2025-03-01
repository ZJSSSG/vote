package xyz.oahoushs.vote.dao;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.pojo.User;

import java.util.List;

public interface UserDAO extends JpaRepository<User,String>, JpaSpecificationExecutor<User> {

    User findOneByUserName(String userName);

    User findOneByEmail(String email);

    User findOneById(int UserId);

    /**
     * 通过修改用户的状态来删除用户
     *
     * @param userId
     * @return
     */
    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_user` SET `state` = '0' WHERE `id` = ?")
    int deleteUserByState(int userId);


    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_user` SET `password` = ? ,`salt` = ? WHERE `email` = ? ")
    int updatePasswordByEmail(String encodedPassword,String salt, String email);

    @Modifying
    @Query(nativeQuery = true, value = "UPDATE `tb_user` SET `email` = ? WHERE `id` = ? ")
    int updateEmailById(String email,int userId);

    @Query(value = "select new User(u.id,u.userName,u.avatar,u.email,u.state,u.createTime,u.updateTime) from User as u")
    Page<User> listAllUser(Pageable pageable);


    @Query(value = " select * from tb_user a left join tb_user_activity b on a.user_name=b.user_name  where  a.state = '1' and (`activity_id`!= ? or `activity_id` is null) and a.user_name!=? ",nativeQuery = true)
    Page<User> findAllCanVote(String activityId,String userName, Pageable pageable);

}
