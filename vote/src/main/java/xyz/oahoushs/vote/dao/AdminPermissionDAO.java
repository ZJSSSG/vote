package xyz.oahoushs.vote.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import xyz.oahoushs.vote.pojo.AdminPermission;

public interface AdminPermissionDAO extends JpaRepository<AdminPermission, Integer> {
    AdminPermission findById(int id);
}
