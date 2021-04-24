package com.exp.backboot.pojo;

import java.util.Date;
import java.util.List;

public class EngineTable {

    /**
     * 主键id
     */
    private Long id;
    /**
     * 表明
     */
    private String tableName;
    /**
     * 状态
     */
    private Integer status;
    /**
     * 创建人id
     */
    private Long creator;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 删除时间
     */
    private Date deleteTime;
    /**
     * 从表
     */
    private List<EngineTable> subTables;
    /**
     * 表字段
     */
    private List<EngineTableColumn> columns;

    public List<EngineTable> getSubTables() {
        return subTables;
    }

    public void setSubTables(List<EngineTable> subTables) {
        this.subTables = subTables;
    }

    public List<EngineTableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<EngineTableColumn> columns) {
        this.columns = columns;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Date deleteTime) {
        this.deleteTime = deleteTime;
    }


    @Override
    public String toString() {
        return "EngineTable{" +
                "id=" + id +
                ", tableName='" + tableName + '\'' +
                ", status=" + status +
                ", creator=" + creator +
                ", createTime=" + createTime +
                ", deleteTime=" + deleteTime +
                ", subTables=" + subTables +
                ", columns=" + columns +
                '}';
    }
}
