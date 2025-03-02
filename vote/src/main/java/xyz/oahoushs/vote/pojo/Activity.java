package xyz.oahoushs.vote.pojo;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Entity
@Table(name = "tb_activity")
public class Activity {
    @Id
    @Column(name = "id")
    private String id;
    @Column(name = "author")
    private String author;
    @Column(name = "title")
    private String title;
    @Column(name = "content")
    private String content;
    @Column(name = "state")
    private String state;
    @Column(name = "type")
    private String type;
    @Column(name = "sign_in")
    private String signIn;
    @Column(name = "verify_code")
    private Boolean verifyCode;
    @Column(name = "start_time")
    private Date startTime;
    @Column(name = "end_time")
    private Date endTime;
    @Column(name = "create_time")
    private Date createTime;
    @Column(name = "update_time")
    private Date updateTime;

}
