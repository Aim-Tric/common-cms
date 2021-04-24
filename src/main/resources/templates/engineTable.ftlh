<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./plugin/layui/css/layui.css">
    <title>建模引擎</title>
</head>

<body style="min-height: 100vh;">
<div class="layui-row">
    <div class="layui-col-xs6 layui-col-md2">
        <div id="treeSide" style="background-color: white;min-height: 100vh;"></div>
    </div>
    <div class="layui-col-xs12 layui-col-md10">
        <iframe id="tableSetting" src="${springMacroRequestContext.contextPath}/tableSetting" frameborder="0"
                width="100%"
                style="min-height: calc(100vh - 3px);"></iframe>
    </div>
</div>


<script src="./plugin/layui/layui.js"></script>
<script type="text/html" id="statusTemplate">
    <input type="checkbox" value="{{d.status}}" lay-skin="switch">
</script>

<script>
    layui.use(['element', 'layer', 'tree', 'jquery'], function () {
        var element = layui.element;
        var layer = layui.layer;
        var tree = layui.tree;
        var $ = layui.jquery;

        var frame = document.querySelector("#tableSetting");

        const reload = (title) => {
            if (title) {
                layer.msg(`【${r'${title}'}】菜单项不可删除`);
            }
            openTree();
        }

        const load = () => {
            $.get('/api/engine/table/all', function (resp) {
                treeData[0].children.length = 0;
                for (var d of resp.data) {
                    treeData[0].children.push({
                        id: d.id,
                        title: d.tableName
                    });
                }
                config.data = treeData;
                tree.render(config);
                openTree();
            })
        }

        const openTree = () => {
            var iconDom = document.querySelector(".layui-tree-iconClick.layui-tree-icon>.layui-icon-addition");
            if (iconDom) {
                var parentNode = iconDom.parentNode;
                parentNode.click();
            }
        }

        load();
        var treeData = [{
            title: '模型列表',
            id: 0,
            children: []
        }]
        var config = {
            elem: '#treeSide',
            data: treeData,
            onlyIconControl: true,
            edit: ['add', 'del', 'update'],
            click: function (obj) {
                if (obj.data.id !== 0) {
                    frame.src = '${springMacroRequestContext.contextPath}/tableSetting?id=' + obj.data.id;
                }
            },
            operate: function (obj) {
                var type = obj.type;
                var data = obj.data;
                var elem = obj.elem[0];
                if (type === 'add') {
                    openTree();
                    var newData = {
                        id: -1,
                        title: "未命名",
                    }
                    treeData[0].children.push(newData);
                    var rootId = elem.getAttribute("data-id");
                    if (rootId !== 0) {
                        reload();
                    }
                    setTimeout(function () {
                        var set = document.querySelectorAll(".layui-tree-pack .layui-tree-set");
                        if (set.length > 0) {
                            var last = set[set.length - 1];
                            var editButton = last.querySelector(".layui-icon-edit");
                            editButton.click();
                        }
                    }, 400);
                    return newData.id;
                } else if (type === 'update') {
                    // ajax调用保存或更新
                    console.log(data);
                    if (data.id === -1) {
                        // 保存
                        $.ajax({
                            url: '/api/engine/table',
                            data: {tableName: data.title},
                            method: 'post',
                            success: resp => {
                                console.log(resp);
                            }
                        });
                    } else {
                        // 更新
                        console.log("更新")
                    }
                    reload();
                    load();
                } else if (type === 'del') {
                    if (data.id !== -1) {
                        // ajax调用删除数据接口

                    }
                    if (data.id === 0) {
                        setTimeout(function () {
                            reload(data.title)
                        }, 1);
                    }
                }
                ;
            }
        }

        const side = tree.render(config);
    });
</script>
</body>

</html>