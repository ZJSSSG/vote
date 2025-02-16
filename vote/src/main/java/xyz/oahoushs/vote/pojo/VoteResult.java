package xyz.oahoushs.vote.pojo;

import com.alibaba.excel.annotation.ExcelProperty;

public class VoteResult {
    @ExcelProperty("商品编号")
    private Integer gid;
    @ExcelProperty("商品名称")
    private String gname;
    @ExcelProperty("商品价格")
    private Float gprice;
    @ExcelProperty("商品购买数量")
    private Integer buynum;
    @ExcelProperty("商品库存")
    private Integer gnum;
    //导出图片格式如下（照片路径一定是要真实路径，不然会报错）
    //@ExcelProperty(value = {"商品图片"},converter = StringImageConverter.class)
    //忽略导入
    //@ExcelIgnore
    @ExcelProperty("商品图片")
    private String gpic;

}
