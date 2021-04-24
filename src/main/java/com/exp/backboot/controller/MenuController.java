package com.exp.backboot.controller;

import com.exp.backboot.common.ResponseWrapper;
import com.exp.backboot.pojo.EngineMenu;
import com.exp.backboot.service.MenuService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api/engine/menu")
public class MenuController {

    @Resource
    private MenuService menuService;

    @GetMapping("/all")
    public ResponseWrapper<List<EngineMenu>> findAll() {
        List<EngineMenu> all = menuService.findAll();
        return ResponseWrapper.success(all);
    }

    @PostMapping
    public ResponseWrapper<Void> create(@RequestBody EngineMenu menu) {
        menuService.insert(menu);
        return ResponseWrapper.success();
    }

    @PutMapping
    public ResponseWrapper<Void> update(@RequestBody EngineMenu menu) {
        menuService.update(menu);
        return ResponseWrapper.success();
    }

    @DeleteMapping("/batch")
    public ResponseWrapper<Void> delete(@RequestBody List<Integer> ids) {
        menuService.deleteBatch(ids);
        return ResponseWrapper.success();
    }

    @DeleteMapping
    public ResponseWrapper<Void> delete(Integer id) {
        menuService.delete(id);
        return ResponseWrapper.success();
    }


}
