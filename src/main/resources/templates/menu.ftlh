<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./plugin/layui/css/layui.css">
    <title>菜单管理</title>
</head>
<body style="padding: 5px">
<div class="layui-btn-group">
    <button id="addBtn" type="button" class="layui-btn layui-btn-sm">增加</button>
    <button id="delBtn" type="button" class="layui-btn layui-btn-sm">删除</button>
</div>

<table id="menuTable" lay-filter="menuTable"></table>

<script type="text/html" id="formTemplate">
    <form class="layui-form" lay-filter="menuForm" style="padding-right: 80px;margin-top: 10px">
        <input type="text" hidden>
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" required lay-verify="required"
                       placeholder="请输入菜单名称" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">标签</label>
            <div class="layui-input-block">
                <input type="text" name="tag" required lay-verify="required"
                       placeholder="请输入菜单标签" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">路径</label>
            <div class="layui-input-block">
                <input type="text" name="path" required lay-verify="required"
                       placeholder="请输入菜单导航路径" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-block">
                <select name="permission" lay-verify="required">
                    <option value="0">无</option>
                    <option value="1">仅管理员</option>
                    <option value="2">用户</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script type="text/html" id="editTemplate">
    <button type="button" class="layui-btn layui-btn-sm edit-btn" lay-event="edit">编辑</button>
    <button type="button" class="layui-btn layui-btn-sm edit-btn" lay-event="del">删除</button>
</script>

<script src="./plugin/layui/layui.js"></script>
<script>
    layui.use(['element', 'table', 'layer', 'laytpl', 'form', 'jquery'], function () {
        let element = layui.element;
        let table = layui.table;
        let layer = layui.layer;
        let laytpl = layui.laytpl;
        let form = layui.form;
        let $ = layui.jquery;

        let addBtn = document.querySelector("#addBtn");
        let delBtn = document.querySelector("#delBtn");

        let formTemplate = document.querySelector("#formTemplate");

        let tableInstance = table.render({
            elem: '#menuTable',
            height: 500,
            url: '/api/engine/menu/all',
            cols: [[
                {field: 'checkbox', type: 'checkbox'},
                {field: 'id', title: '编号', width: 80, sort: true},
                {field: 'name', title: '菜单名称', width: 200},
                {field: 'path', title: '路径'},
                {field: 'permission', title: '权限'},
                {field: 'operation', title: '操作', width: 135, toolbar: '#editTemplate'}
            ]],
            parseData: function (res) {
                return {
                    "code": res.code,
                    "msg": res.message,
                    "count": res.data.length,
                    "data": res.data
                };
            },
            response: {
                statusCode: 200,
            }
        });

        function openLayer(title, content, btn, callback) {
            layer.open({
                type: 1,
                title: title,
                icon: 0,
                area: ['500px', '400px'],
                content: content,
                btn: [btn, '取消'],
                btn1: function (index, layero) {
                    callback(index, layero)
                },
                btn2: function (index, layero) {
                    layer.close(index);
                },
                btnAlign: 'c',
                resize: false,
            })
        }

        addBtn.addEventListener("click", function () {
            laytpl(formTemplate.innerHTML).render({}, function (html) {
                openLayer('添加菜单项', html, '添加', function (index, layero) {
                    let newData = form.val("menuForm");
                    $.ajax({
                        url: '/api/engine/menu',
                        contentType: "application/json; charset=utf-8",
                        method: 'post',
                        data: JSON.stringify(newData),
                        success: (resp) => {
                            if (resp.code === 200) {
                                layer.msg("添加成功", {icon: 1});
                                layer.close(index);
                                tableInstance.reload();
                            }
                        }
                    })
                })
                form.render();
            })
        });

        delBtn.addEventListener("click", function () {
            var checks = table.checkStatus('menuTable')
            var ids = []
            if (checks.data.length > 0) {
                for (let row of checks.data) {
                    ids.push(row.id);
                }
                $.ajax({
                    url: '/api/engine/menu/batch',
                    method: 'delete',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(ids),
                    success: (resp) => {
                        layer.msg("删除成功", {icon: 1});
                        tableInstance.reload();
                    }
                })
            }
        });

        table.on('tool(menuTable)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            if (layEvent === 'edit') {
                laytpl(formTemplate.innerHTML).render(data, function (html) {
                    openLayer('修改', html, '保存', function (index, layero) {
                        let newData = form.val("menuForm");
                        $.ajax({
                            url: '/api/engine/menu',
                            method: 'put',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(newData),
                            success: (resp) => {
                                layer.msg("修改成功", {icon: 1});
                                layer.close(index);
                                tableInstance.reload();
                            }
                        })
                    })
                    form.val("menuForm", data);
                    form.render();
                });
            } else if (layEvent === 'del') {
                $.ajax({
                    url: '/api/engine/menu?id=' + data.id,
                    method: 'delete',
                    success: (resp) => {
                        layer.msg("删除成功", {icon: 1});
                        tableInstance.reload();
                    }
                })
            }
        });

    })
</script>
</body>
</html>