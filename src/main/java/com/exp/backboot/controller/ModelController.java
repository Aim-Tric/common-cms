package com.exp.backboot.controller;

import com.exp.backboot.common.ResponseWrapper;
import com.exp.backboot.pojo.EngineTable;
import com.exp.backboot.pojo.EngineTableWrapper;
import com.exp.backboot.service.ModelService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api/engine/table")
public class ModelController {

    @Resource
    private ModelService modelService;

    @PostMapping("/create")
    public ResponseWrapper<Void> createTable(@RequestBody EngineTable table) {
        modelService.create(table);
        return ResponseWrapper.success();
    }

    @PutMapping("/columns")
    public ResponseWrapper<Void> updateTableColumns(@RequestBody EngineTableWrapper tableWrapper) {
        modelService.updateColumns(tableWrapper);
        return ResponseWrapper.success();
    }

    @DeleteMapping
    public ResponseWrapper<Void> deleteTable(Long id) {
        modelService.delete(id);
        return ResponseWrapper.success();
    }

    @PostMapping
    public ResponseWrapper<Void> insertTable(EngineTable table) {
        modelService.insert(table);
        return ResponseWrapper.success();
    }

    @GetMapping("/all")
    public ResponseWrapper<List<EngineTable>> selectTables() {
        List<EngineTable> engineTables = modelService.selectAll();
        return ResponseWrapper.success(engineTables);
    }

    @GetMapping("/{id}")
    public ResponseWrapper<EngineTable> selectTable(@PathVariable Long id) {
        EngineTable engineTable = modelService.selectById(id);
        return ResponseWrapper.success(engineTable);
    }

}
