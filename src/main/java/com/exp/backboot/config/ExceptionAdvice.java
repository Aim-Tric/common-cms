package com.exp.backboot.config;

import com.exp.backboot.common.ResponseWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.sql.SQLException;

@ControllerAdvice
public class ExceptionAdvice {

    private static final Logger logger = LoggerFactory.getLogger("exception");

    @ExceptionHandler(value = {SQLException.class})
    public ResponseWrapper<Void> dbException(Throwable throwable) {
        throwable.printStackTrace();
        return ResponseWrapper.success();
    }

}
