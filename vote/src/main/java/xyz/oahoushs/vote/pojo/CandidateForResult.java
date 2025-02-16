package xyz.oahoushs.vote.pojo;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

import javax.persistence.Column;
import java.util.Date;

@Data
public class CandidateForResult {

    @ExcelProperty("排名")
    private int rank;

    @ExcelProperty("选项ID")
    private String id;

    @ExcelProperty("标题")
    private String title;

    @ExcelProperty("编号")
    @Column(name = "num")
    private int num;

    @ExcelProperty("描述")
    private String itemDesc;

    @ExcelProperty("封面链接")
    private String coverUrl;

    @ExcelProperty("得票数")
    private int voteCount;

    @ExcelProperty("活动ID")
    private String aid;

    @ExcelProperty("创建时间")
    private Date createTime;

    @ExcelProperty("更新时间")
    private Date updateTime;
}
