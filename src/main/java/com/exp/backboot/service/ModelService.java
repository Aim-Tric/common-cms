package com.exp.backboot.service;

import com.exp.backboot.mapper.ModelMapper;
import com.exp.backboot.pojo.EngineTable;
import com.exp.backboot.pojo.EngineTableColumn;
import com.exp.backboot.pojo.EngineTableWrapper;
import org.mybatis.spring.SqlSessionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

@Service
public class ModelService {

    private static final Logger logger = LoggerFactory.getLogger("service");

    @Resource
    private ModelMapper modelMapper;

    @Transactional(rollbackFor = Exception.class)
    public void delete(Long id) {
        EngineTable table = modelMapper.selectById(id);
        // 删除字段信息
        modelMapper.deleteColumnsByMainId(id);
        // 删除表信息
        modelMapper.deleteById(id);
        // 删除表结构
        modelMapper.dropTable(table.getTableName());
    }

    public List<EngineTable> selectAll() {
        return modelMapper.selectAll();
    }

    public EngineTable selectById(Long id) {
        return modelMapper.selectById(id);
    }

    public void insert(EngineTable table) {
        modelMapper.insert(table);
    }

    public void update(EngineTable table) {
        modelMapper.update(table);
    }

    // 下面是字段相关操作

    @Transactional(rollbackFor = Exception.class)
    public void create(EngineTable table) {
        EngineTableWrapper wrapper = new EngineTableWrapper(table);
        modelMapper.insertColumns(table);
        modelMapper.create(wrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    public void updateColumns(EngineTableWrapper tableWrapper) {
        logger.info("开始更新表数据！");
        EngineTable table = tableWrapper.getTable();
        List<EngineTableColumn> newColumns = tableWrapper.getNewColumns();
        List<EngineTableColumn> origin = table.getColumns();
        Map<String, EngineTableColumn> dict = new HashMap<>();
        String tableName = table.getTableName();
        logger.info("开始预处理字段数据....");
        for (EngineTableColumn column : origin) {
            dict.put(column.getColumnIdentifier(), column);
        }
        List<EngineTableColumn> insert = new ArrayList<>();
        Iterator<EngineTableColumn> iterator = newColumns.iterator();
        while (iterator.hasNext()) {
            EngineTableColumn column = iterator.next();
            String identifier = column.getColumnIdentifier();
            if (!dict.containsKey(identifier)) {
                insert.add(column);
            } else {
                dict.remove(identifier);
                iterator.remove();
            }
        }
        logger.info("新增{}个字段，开始插入新增字段...", insert.size());
        if (insert.size() > 0) {
            modelMapper.insertTableColumns(tableName, insert);
            EngineTable tableDo = new EngineTable();
            tableDo.setId(table.getId());
            tableDo.setTableName(tableName);
            tableDo.setColumns(insert);
            modelMapper.insertColumns(tableDo);
        }
        if (dict.size() > 0) {
            logger.info("删除{}个字段，开始删除字段...", dict.size());
            Collection<EngineTableColumn> values = dict.values();
            modelMapper.deleteTableColumns(tableName, values);
            // 执行成功，则将删除的数据从表中删除
            modelMapper.deleteColumnsByBeanBatch(values);
            // 尝试将删除的字段从表结构中移除
        }
        if (newColumns.size() > 0) {
            logger.info("剩余{}个字段，更新剩余字段...", newColumns.size());
            // 执行更新剩余数据
            modelMapper.updateTableColumns(tableName, newColumns);
            table.setColumns(newColumns);
            modelMapper.updateColumns(table.getId(), newColumns);
        }
        logger.info("更新表数据成功！");
    }


}
