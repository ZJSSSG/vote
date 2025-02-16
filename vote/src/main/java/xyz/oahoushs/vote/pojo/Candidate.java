package xyz.oahoushs.vote.pojo;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Entity
@Table(name = "tb_candidate")
public class Candidate {

    @Id
    @Column(name = "id")
    @ExcelProperty("选项ID")
    private String id;
    @Column(name = "aid")
    @ExcelProperty("活动ID")
    private String aid;
    @ExcelProperty("标题")
    @Column(name = "title")
    private String title;
    @ExcelProperty("编号")
    @Column(name = "num")
    private int num;
    @Column(name = "item_desc")
    @ExcelProperty("描述")
    private String itemDesc;
    @Column(name = "cover_url")
    @ExcelProperty("封面链接")
    private String coverUrl;
    @Column(name = "video_url")
    @ExcelProperty("视频链接")
    private String videoUrl;
    @Column(name = "vote_count")
    @ExcelProperty("得票数")
    private int voteCount;
    @Column(name = "state")
    @ExcelProperty("选项状态")
    private boolean state;
    @Column(name = "create_time")
    @ExcelProperty("创建时间")
    private Date createTime;
    @Column(name = "update_time")
    @ExcelProperty("更新时间")
    private Date updateTime;

}
