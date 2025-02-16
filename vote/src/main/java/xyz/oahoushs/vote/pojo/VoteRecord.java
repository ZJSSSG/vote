package xyz.oahoushs.vote.pojo;


import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Entity
@Table(name = "tb_vote_record")
public class VoteRecord {

    @Id
    @Column(name = "id")
    private String id;
    @Column(name = "aid")
    private String aid;
    @Column(name = "uid")
    private int uid;
    @Column(name = "cid")
    private String cid;
    @Column(name = "vote_time")
    private Date voteTime;
}
