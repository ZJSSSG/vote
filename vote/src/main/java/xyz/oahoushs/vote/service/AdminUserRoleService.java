package xyz.oahoushs.vote.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import xyz.oahoushs.vote.dao.AdminUserRoleDAO;
import xyz.oahoushs.vote.pojo.AdminRole;
import xyz.oahoushs.vote.pojo.AdminUserRole;

import java.util.List;

/**
 * @author Evan
 * @date 2019/11
 */
@Service
public class AdminUserRoleService {
    @Autowired
    AdminUserRoleDAO adminUserRoleDAO;

    public List<AdminUserRole> listAllByUid(int uid) {
        return adminUserRoleDAO.findAllByUid(uid);
    }

    //    @Modifying
    @Transactional
    public void saveRoleChanges(int uid, List<AdminRole> roles) {
        adminUserRoleDAO.deleteAllByUid(uid);
        for (AdminRole role : roles) {
            AdminUserRole ur = new AdminUserRole();
            ur.setUid(uid);
            ur.setRid(role.getId());
            adminUserRoleDAO.save(ur);
        }
    }

    public void addUserRole(AdminUserRole adminUserRole){
        try{
            adminUserRoleDAO.save(adminUserRole);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
