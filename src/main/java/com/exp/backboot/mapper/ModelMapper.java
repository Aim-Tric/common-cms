package com.exp.backboot.mapper;

import com.exp.backboot.pojo.EngineTable;
import com.exp.backboot.pojo.EngineTableColumn;
import com.exp.backboot.pojo.EngineTableWrapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

@Mapper
public interface ModelMapper {
    EngineTable selectById(@Param("id") Long id);

    List<EngineTable> selectAll();

    void insert(@Param("table") EngineTable table);

    void update(@Param("table") EngineTable table);

    void insertColumns(@Param("table") EngineTable table);

    void deleteById(@Param("id") Long id);

    void deleteColumnsByMainId(@Param("mainId") Long mainId);

    void deleteColumnsByBeanBatch(@Param("columns") Collection<EngineTableColumn> columns);

    void updateColumns(@Param("id") Long id, @Param("columns") List<EngineTableColumn> newColumns);

    // 修改表结构

    void create(@Param("wrapper") EngineTableWrapper wrapper);

    void deleteTableColumns(@Param("tableName") String tableName, @Param("columns") Collection<EngineTableColumn> columns);

    void dropTable(@Param("tableName") String tableName);

    void insertTableColumns(@Param("tableName") String tableName, @Param("columns") Collection<EngineTableColumn> columns);

    void updateTableColumns(@Param("tableName") String tableName, @Param("columns") Collection<EngineTableColumn> columns);

}
