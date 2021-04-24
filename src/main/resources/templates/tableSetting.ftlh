<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./plugin/layui/css/layui.css">
    <title>表单设置</title>
    <style>
    </style>
</head>

<body>
<div class="layui-tab-item layui-show" style="padding: 5px; background-color: #eeeeee;">
    <div class="layui-card">
        <div class="layui-tab layui-tab-card" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">表单属性</li>
                <li>字段定义</li>
                <li>权限配置</li>
            </ul>
            <div class="layui-tab-content" style="padding: 5px;">
                <div class="layui-tab-item layui-show">
                    <form class="layui-form" id="tableFormAttribute">

                    </form>
                </div>
                <div class="layui-tab-item">
                    <div class="layui-btn-group">
                        <button type="button" class="layui-btn layui-btn-sm" id="saveBtn">保存</button>
                        <button type="button" class="layui-btn layui-btn-sm" id="addBtn">增加</button>
                        <button type="button" class="layui-btn layui-btn-sm" id="delBtn">删除</button>
                    </div>
                    <form class="layui-form" id="tableFormDefinition">
                        <table class="layui-table">
                            <colgroup>
                                <col width="50">
                                <col width="60">
                                <col width="150">
                                <col>
                                <col>
                                <col>
                                <col>
                            </colgroup>
                            <thead class="my-thead">
                            <tr>
                                <th><input type="checkbox" lay-filter="checkAll" name="checkAll" lay-skin="primary">
                                </th>
                                <th>编号</th>
                                <th>字段名称</th>
                                <th>字段标识</th>
                                <th>字段类型</th>
                                <th>字段长度</th>
                                <th>字段备注</th>
                                <th>主键</th>
                                <th>非空</th>
                            </tr>
                            </thead>
                            <tbody id="tableBody">

                            </tbody>
                        </table>
                    </form>
                </div>
                <div class="layui-tab-item">权限配置</div>
            </div>
        </div>
    </div>
</div>
</div>

<script type="text/html" id="editTableRow">
    {{# layui.each(d, function(index, item){ }}
    <tr>
        <th>
            <input type="checkbox" lay-filter="check" name="check" lay-skin="primary">
        </th>
        <th>
            <label style="text-align: center;">{{= (index + 1) }}</label>
        </th>
        <th>
            <input type="text" name="columnName" placeholder="字段名称" value="{{ item.columnName ? item.columnName : '' }}"
                   autocomplete="off" class="layui-input">
        </th>
        <th>
            <input type="text" name="columnIdentifier" placeholder="字段标识"
                   value="{{ item.columnIdentifier ? item.columnIdentifier : '' }}" autocomplete="off"
                   class="layui-input">
        </th>
        <th>
            <input type="text" name="columnType" placeholder="字段类型" value="{{ item.columnType ? item.columnType : '' }}"
                   autocomplete="off" class="layui-input">
        </th>
        <th>
            <input type="text" name="columnLength" placeholder="字段长度"
                   value="{{ item.columnLength ? item.columnLength : '' }}" autocomplete="off" class="layui-input">
        </th>
        <th>
            <input type="text" name="remark" placeholder="字段备注" value="{{ item.remark ? item.remark : '' }}"
                   autocomplete="off" class="layui-input">
        </th>
        <th>
            <input type="checkbox" lay-filter="check" name="primaryKey" lay-skin="primary"
                   {{ item.primaryKey ? 'checked' : '' }}>
        </th>
        <th>
            <input type="checkbox" lay-filter="check" name="notNull" lay-skin="primary"
                   {{ item.notNull ? 'checked' : '' }}>
        </th>
    </tr>
    {{# }) }}
</script>

<script src="./plugin/layui/layui.js"></script>
<script>
    layui.use(['element', 'layer', 'form', 'laytpl', 'jquery'], function () {
        var element = layui.element;
        var form = layui.form;
        var layer = layui.layer;
        var laytpl = layui.laytpl;
        var $ = layui.jquery;

        var tableBody = document.querySelector("#tableBody");
        var rowTemplate = editTableRow.innerHTML;
        var addBtn = document.querySelector("#addBtn");
        var delBtn = document.querySelector("#delBtn");
        var saveBtn = document.querySelector("#saveBtn");
        var checkAll = document.querySelector("input[name=checkAll]");

        var params = {}
        var table
        const load = () => {
            var sub = window.location.search.substring(1);
            var arr = sub.split("&");
            for (var a of arr) {
                if (a) {
                    var s = a.split("=");
                    params[s[0]] = s[1];
                }
            }
            if (params.id) {
                $.get('/api/engine/table/' + params.id, function (resp) {
                    table = resp.data;
                    if (table.columns && table.columns.length > 0) {
                        laytpl(rowTemplate).render(table.columns, function (html) {
                            tableBody.innerHTML = html;
                        });
                        form.render();
                    }
                })
            }
        }

        load();

        addBtn.addEventListener('click', function () {
            var rows = tableBody.querySelectorAll("tr");
            var datas = [];
            for (var row of rows) {
                var columns = row.querySelectorAll("input");
                var o = {};
                for (var i = 1; i < columns.length; i++) {
                    var column = columns[i];
                    if (column.type === "checkbox") {
                        o[column.name] = column.checked;
                    } else {
                        o[column.name] = column.value;
                    }
                }
                datas.push(o);
            }
            datas.push({});
            laytpl(rowTemplate).render(datas, function (html) {
                tableBody.innerHTML = html;
            });
            form.render();
        });
        delBtn.addEventListener('click', function () {
            var rows = tableBody.querySelectorAll("tr input[type=checkbox]:checked");
            for (var row of rows) {
                var tr = row.parentNode.parentNode;
                tableBody.removeChild(tr);
            }
            var trs = tableBody.querySelectorAll("tr");
            for (var i = 0; i < trs.length; i++) {
                var label = trs[i].querySelector("label");
                label.innerText = i + 1;
            }
            checkAll.checked = false;
            form.render();
        });
        saveBtn.addEventListener('click', function () {
            var rows = tableBody.querySelectorAll("tr");
            var datas = [];
            for (var row of rows) {
                var columns = row.querySelectorAll("input");
                var o = {};
                for (var i = 1; i < columns.length; i++) {
                    var column = columns[i];
                    if (column.type === "checkbox") {
                        o[column.name] = column.checked;
                    } else {
                        o[column.name] = column.value;
                    }
                }
                if (!o.columnName || !o.columnIdentifier || !o.columnType) {
                    break;
                }
                datas.push(o);
            }

            if (table.columns && table.columns.length > 0) {
                var wrapper = {
                    table: table,
                    newColumns: datas
                }
                $.ajax({
                    url: '/api/engine/table/columns',
                    contentType: "application/json; charset=utf-8",
                    method: 'put',
                    data: JSON.stringify(wrapper),
                    success: resp => {
                        console.log(resp);
                        load();
                    }
                });
            } else {
                table.columns = datas;
                $.ajax({
                    url: '/api/engine/table/create',
                    contentType: "application/json; charset=utf-8",
                    method: 'post',
                    data: JSON.stringify(table),
                    success: resp => {
                        console.log(resp);
                        load();
                    }
                });
            }
        })
        form.on('checkbox(checkAll)', function (data) {
            var checkboxs = tableBody.querySelectorAll("tr input[type=checkbox]");
            for (var checkbox of checkboxs) {
                checkbox.checked = data.elem.checked;
            }
            form.render();
        })
    });
</script>

</body>

</html>