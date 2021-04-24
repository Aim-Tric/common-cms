package com.exp.backboot.common;

public class ResponseWrapper<T> {

    private Integer code;
    private String message;
    private T data;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public static <T> ResponseWrapper<T> success() {
        return success(null);
    }

    public static <T> ResponseWrapper<T> success(T data) {
        ResponseWrapper<T> response = new ResponseWrapper<>();
        response.setCode(200);
        response.setMessage("成功");
        response.setData(data);
        return response;
    }
}
