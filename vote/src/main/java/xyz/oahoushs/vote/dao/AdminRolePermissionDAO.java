package xyz.oahoushs.vote.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import xyz.oahoushs.vote.pojo.AdminRolePermission;

import java.util.List;

public interface AdminRolePermissionDAO extends JpaRepository<AdminRolePermission, Integer> {
    List<AdminRolePermission> findAllByRid(int rid);
    void deleteAllByRid(int rid);
}
