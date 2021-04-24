package com.exp.backboot.pojo;

public class EngineTableColumn {

    /**
     * 主键id
     */
    private Long id;
    /**
     * 表id
     */
    private Long mainId;
    /**
     * 字段名称
     */
    private String columnName;
    /**
     * 字段标识符
     */
    private String columnIdentifier;
    /**
     * 字段类型
     */
    private String columnType;
    /**
     * 字段长度
     */
    private Integer columnLength;
    /**
     * 字段备注
     */
    private String remark;
    /**
     * 主键
     */
    private Boolean primaryKey;
    /**
     * 非空
     */
    private Boolean notNull;
    /**
     * 自增长
     */
    private Boolean autoIncrement;

    public Boolean getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(Boolean primaryKey) {
        this.primaryKey = primaryKey;
    }

    public Boolean getNotNull() {
        return notNull;
    }

    public void setNotNull(Boolean notNull) {
        this.notNull = notNull;
    }

    public Boolean getAutoIncrement() {
        return autoIncrement;
    }

    public void setAutoIncrement(Boolean autoIncrement) {
        this.autoIncrement = autoIncrement;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMainId() {
        return mainId;
    }

    public void setMainId(Long mainId) {
        this.mainId = mainId;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnIdentifier() {
        return columnIdentifier;
    }

    public void setColumnIdentifier(String columnIdentifier) {
        this.columnIdentifier = columnIdentifier;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public Integer getColumnLength() {
        return columnLength;
    }

    public void setColumnLength(Integer columnLength) {
        this.columnLength = columnLength;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
