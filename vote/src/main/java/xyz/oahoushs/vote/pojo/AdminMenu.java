package xyz.oahoushs.vote.pojo;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "admin_menu")
@JsonIgnoreProperties({"handler", "hibernateLazyInitializer"})
public class AdminMenu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "path")
    private String path;
    @Column(name = "name")
    private String name;
    @Column(name = "name_zh")
    private String nameZh;
    @Column(name = "icon_cls")
    private String iconCls;
    @Column(name = "component")
    private String component;
    @Column(name = "parent_id")
    private int parentId;

    @Transient
    private List<AdminMenu> children;
}