package com.exp.backboot.service;

import com.exp.backboot.common.ICrudService;
import com.exp.backboot.mapper.MenuMapper;
import com.exp.backboot.pojo.EngineMenu;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MenuService implements ICrudService<EngineMenu, Integer> {

    @Resource
    private MenuMapper menuMapper;

    @Override
    public List<EngineMenu> findAll() {
        return menuMapper.selectAll();
    }

    @Override
    public EngineMenu findById(Integer id) {
        return menuMapper.selectById(id);
    }

    @Override
    public void update(EngineMenu engineMenu) {
        menuMapper.update(engineMenu);
    }

    @Override
    public void delete(Integer id) {
        menuMapper.deleteById(id);
    }

    @Override
    public void insert(EngineMenu engineMenu) {
        menuMapper.insert(engineMenu);
    }

    public void deleteBatch(List<Integer> ids) {
        menuMapper.deleteBatch(ids);
    }
}
