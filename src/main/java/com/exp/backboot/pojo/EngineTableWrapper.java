package com.exp.backboot.pojo;

import java.util.*;

public class EngineTableWrapper {

    private EngineTable table;
    private int primaryKeyCount = 0;
    private List<EngineTableColumn> primaryKeys;
    private List<EngineTableColumn> newColumns;

    public EngineTableWrapper() {
    }

    public EngineTableWrapper(EngineTable table) {
        primaryKeys = new ArrayList<>();
        this.table = table;
        List<EngineTableColumn> columns = table.getColumns();
        for (EngineTableColumn column : columns) {
            if (column.getPrimaryKey() != null && column.getPrimaryKey()) {
                primaryKeys.add(column);
                primaryKeyCount++;
            }
        }
    }

    public List<EngineTableColumn> getNewColumns() {
        return newColumns;
    }

    public void setNewColumns(List<EngineTableColumn> newColumns) {
        this.newColumns = newColumns;
    }

    public List<EngineTableColumn> getPrimaryKeys() {
        return primaryKeys;
    }

    public void setPrimaryKeys(List<EngineTableColumn> primaryKeys) {
        this.primaryKeys = primaryKeys;
    }

    public EngineTable getTable() {
        return table;
    }

    public void setTable(EngineTable table) {
        this.table = table;
    }

    public int getPrimaryKeyCount() {
        return primaryKeyCount;
    }

    public void setPrimaryKeyCount(int primaryKeyCount) {
        this.primaryKeyCount = primaryKeyCount;
    }
}
