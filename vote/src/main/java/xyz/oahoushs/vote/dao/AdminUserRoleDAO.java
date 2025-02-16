package xyz.oahoushs.vote.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import xyz.oahoushs.vote.pojo.AdminUserRole;

import java.util.List;

public interface AdminUserRoleDAO extends JpaRepository<AdminUserRole,Integer> {
    List<AdminUserRole> findAllByUid(int uid);
    void deleteAllByUid(int uid);
}
