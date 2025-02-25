package xyz.oahoushs.vote.pojo;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @ClassName: UserActivity
 * @Description:
 * @Author H
 * @Date 2025/2/25
 * @Version 1.0
 */
@Data
@Entity
@Table(name = "tb_user_activity")
public class UserActivity {
    @Id
    @Column(name = "id")
    private String id;
    @Column(name = "activity_id")
    private String activityId;

    @Column(name = "user_name")
    private Integer userName;

}
