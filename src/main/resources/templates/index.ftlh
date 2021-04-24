<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./plugin/layui/css/layui.css">
    <title>通用后台管理系统</title>
</head>

<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header layui-bg-cyan">
        <div class="layui-logo">通用后台管理系统</div>
        <ul class="layui-nav layui-layout-left">
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="" class="layui-nav-img">
                    用户名
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">个人信息</a></dd>
                    <dd><a href="">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-cyan">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree layui-bg-cyan" id="windowNav" lay-filter="windowNav">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">系统管理</a>
                    <dl class="layui-nav-child">
                        <dd><a data-id="navModel" href="javascript:;">建模管理</a></dd>
                        <dd><a data-id="navMenu" href="javascript:;">菜单管理</a></dd>
                        <dd><a data-id="navUser" href="javascript:;">用户管理</a></dd>
                        <dd><a data-id="navLog" href="javascript:;">访问日志</a></dd>
                        <dd><a data-id="navData" href="javascript:;">数据统计</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab" style="margin: 0;" lay-filter="windowTab" lay-allowClose="true">
            <ul class="layui-tab-title" id="tabList">
            </ul>
            <div id="tabWindow" class="layui-tab-content" style="padding: 0;">
            </div>
        </div>
    </div>

    <div class="layui-footer">
        底部固定区域
    </div>
</div>

<script src="./plugin/layui/layui.js"></script>

<script type="text/html" id="bodyTemplate">
    <iframe src="{{ d.id }}" frameborder="0" width="100%"
            style="min-height: calc(100vh - 145px); background-color: #eeeeee;"></iframe>
</script>

<script type="text/html" id="menuTemplate">
    {{# layui.each(d.list, function(index, item) { }}
    <li class="layui-nav-item">
        <a href="javascript:;" data-id="{{ item.tag }}">{{ item.name }}</a>
    </li>
    {{# }) }}
</script>

<script>
    layui.use(['element', 'laytpl', 'jquery'], function () {
        let element = layui.element;
        let laytpl = layui.laytpl;
        let $ = layui.jquery;

        let bodyTemplate = document.querySelector("#bodyTemplate").innerHTML;
        let menuTemplate = document.querySelector("#menuTemplate").innerHTML;
        let windowNav = document.querySelector("#windowNav");

        let map = {};
        let router = {
            navModel: './engineTable',
            navMenu: './menu',
            navUser: '',
            navLog: '',
            navData: '',
        }

        let hash = window.location.hash;
        let active = hash ? hash.substring(1) : 'navModel';

        let loadMenu = () => {
            $.get('/api/engine/menu/all', (resp) => {
                for (let menu of resp.data) {
                    if (!router.hasOwnProperty(menu.tag)) {
                        router[menu.tag] = menu.path;
                    }
                }
                laytpl(menuTemplate).render({list: resp.data}, function (html) {
                    windowNav.innerHTML += html;
                    element.init();
                });
            });
        }

        let loadTags = () => {
            let localStorage = window.localStorage;
            let tagsJson = localStorage.getItem("tags");
            let tags = JSON.parse(tagsJson);
            for (let key of Object.keys(tags)) {
                if (tags[key]) {
                    let dom = document.querySelector("[data-id=" + key + "]");
                    let title = dom.innerText;
                    laytpl(bodyTemplate).render({
                        id: router[key]
                    }, function (html) {
                        element.tabAdd('windowTab', {
                            title,
                            content: html,
                            id: key
                        });
                    });
                }
            }
            map = tags;
        }

        let updateTags = () => {
            let localStorage = window.localStorage;
            let tagsJson = JSON.stringify(map);
            if (localStorage.getItem("tags")) {
                localStorage.removeItem("tags");
            }
            localStorage.setItem("tags", tagsJson)
        }

        let activeClass = "layui-this";
        let changeActive = () => {
            if (active) {
                let aDom = document.querySelector("[data-id=" + active + "]");
                let navItem = aDom.parentNode;
                if (!navItem.classList.contains(activeClass)) {
                    let activeItem = document.querySelector("." + activeClass);
                    activeItem.classList.remove(activeClass);
                    navItem.classList.add(activeClass);
                }
            }
        }

        let init = () => {
            window.addEventListener("hashchange", function (e) {
                let newHash = e.target.location.hash;
                active = newHash.substring(1);

                changeActive();

                if (!map[active]) {
                    map[active] = true;
                    let dom = document.querySelector("[data-id=" + active + "]");
                    let title = dom.innerText;
                    laytpl(bodyTemplate).render({
                        id: router[active]
                    }, function (html) {
                        element.tabAdd('windowTab', {
                            title,
                            content: html,
                            id: active
                        });
                    });
                    updateTags();
                }
                element.tabChange('windowTab', active);
            })
            loadMenu();
            loadTags();

            map[active] = true;
            element.tabChange('windowTab', active);
            changeActive();
        }

        element.on('tab(windowTab)', function (data) {
            active = this.getAttribute("lay-id");
            window.location.hash = active;
        });
        element.on('tabDelete(windowTab)', function (data) {
            let el = data.elem.context.parentNode;
            let id = el.getAttribute("lay-id");
            map[id] = false;
            for (let key of Object.keys(map)) {
                if (map[key]) {
                    window.location.hash = key;
                    break;
                }
            }
            updateTags();
        });
        element.on('nav(windowNav)', function (elem) {
            let el = elem[0];
            active = el.getAttribute("data-id");
            if (active) {
                window.location.hash = active;
            }
        });

        init();

    });
</script>
</body>

</html>