package xyz.oahoushs.vote.pojo;

import lombok.Data;

import javax.persistence.*;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;
    @Column(name = "activity_id")
    private String activityId;

    @Column(name = "user_name")
    private String userName;

}
