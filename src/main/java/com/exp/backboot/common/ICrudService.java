package com.exp.backboot.common;

import java.util.List;

public interface ICrudService<T, ID> {

    List<T> findAll();

    T findById(ID id);

    void update(T t);

    void delete(ID id);

    void insert(T t);
}
