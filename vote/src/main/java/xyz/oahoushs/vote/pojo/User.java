package xyz.oahoushs.vote.pojo;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name ="tb_user")
public class User {

    @Id
    @Column(name = "id")
    private int id;
    @Column(name = "user_name")
    private String userName;
    @Column(name = "password")
    private String password;
    @Column(name = "avatar")
    private String avatar;
    @Column(name = "email")
    private String email;
    @Column(name = "state")
    private boolean state = true;
    @Column(name = "reg_ip")
    private String regIp;
    @Column(name = "login_ip")
    private String loginIp;
    @Column(name = "create_time")
    private Date createTime;
    @Column(name = "update_time")
    private Date updateTime;
    @Column(name = "salt")
    private String salt;

    @Transient
    private List<AdminRole> roles;

    public User(){

    }


    // 用于配合自定义查询的构造函数
    public User(int id,String username, String avatar, String email, boolean state,Date createTime, Date updateTime) {
        this.id = id;
        this.userName= username;
        this.email = email;
        this.avatar = avatar;
        this.state = state;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }
}