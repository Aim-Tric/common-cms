package com.exp.backboot.mapper;

import com.exp.backboot.pojo.EngineMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MenuMapper {

    List<EngineMenu> selectAll();

    EngineMenu selectById(@Param("id") Integer id);

    void deleteById(@Param("id") Integer id);

    void update(@Param("menu") EngineMenu menu);

    void insert(@Param("menu") EngineMenu menu);

    void deleteBatch(@Param("ids") List<Integer> ids);
}
