package xyz.oahoushs.vote.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import xyz.oahoushs.vote.pojo.AdminRole;

public interface AdminRoleDAO extends JpaRepository<AdminRole, Integer> {
    AdminRole findById(int id);
}
