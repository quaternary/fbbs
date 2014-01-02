<tpl id="ui.topbar.tpl">
var menuList = f.config.menuList;
var userInfo = f.config.userInfo;
var pageInfo = f.config.pageInfo;
<nav class="top-bar" data-topbar>
    <ul class="title-area">
        <li class="name">
            if (menuList.title) {
                <h1><a class="menu-nav" href="#{menuList.title.url}">#{menuList.title.label}</a></h1>
            }
        </li>
        <li class="toggle-topbar menu-icon"><a href="javascript:void(0);"><span></span></a></li>
    </ul>
    <section class="top-bar-section">
        <ul class="left">
            f.each(menuList.menus, function (menu) {
                <li class="nav" data-menu-nav-id="#{menu.id}"><a class="menu-nav" href="#{menu.url}">#{menu.label}</a></li>
            });
        </ul>
        <ul class="right">
            <li class="divider"></li>
            if ('object' === typeof userInfo && !f.isEmpty(userInfo)) {
                <li class="has-dropdown">
                    <a href="#">Right Button with Dropdown</a>
                    <ul class="dropdown">
                        <li><a href="#">First link in dropdown</a></li>
                    </ul>
                </li>
            }
            else {
                <li class="has-form has-button">
                    <a href="javascript:void(0);" class="button login menu-nav menu-nav-new">登陆</a>
                </li>
            }
        </ul>
    </section>
</nav>
</tpl>