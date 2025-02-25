<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@ include file="../include/header.jsp" %>
    <title>管理-控制面板</title>
    <link rel="stylesheet" href="static/ztree/zTreeStyle.css">
</head>

<body>

    <%@ include file="../include/nav.jsp" %>
    <div class="container-fluid">
        <div class="row">
            <%@ include file="../include/sidebar.jsp" %>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-inline" role="form" style="float:left;">
                            <div class="form-group has-feedback">
                                <div class="input-group">
                                    <div class="input-group-addon">查询条件</div>
                                    <input id="keywordInput" class="form-control has-success"
                                           type="text" placeholder="请输入查询条件">
                                </div>
                            </div>
                            <button id="searchBtn" type="button" class="btn btn-warning">
                                <i class="glyphicon glyphicon-search"></i> 查询
                            </button>
                        </form>
                        <button type="button" id="batchRemoveBtn" class="btn btn-danger" style="float:right;margin-left:10px;">
                            <i class=" glyphicon glyphicon-remove"></i> 删除
                        </button>
                        <button type="button" id="showAddModalBtn" class="btn btn-primary" style="float:right;">
                            <i class="glyphicon glyphicon-plus"></i> 新增
                        </button>
                        <br>
                        <hr style="clear:both;">
                        <div class="table-responsive">
                            <table class="table  table-bordered">
                                <thead>
                                <tr>
                                    <th width="30">#</th>
                                    <th width="30"><input id="summaryBox" type="checkbox"></th>
                                    <th>名称</th>
                                    <th width="100">操作</th>
                                </tr>
                                </thead>
                                <tbody id="rolePageBody">
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="6" align="center">
                                        <div id="Pagination" class="pagination"></div>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../modal/modal-role-add.jsp" %>
    <%@ include file="../modal/modal-role-edit.jsp" %>
    <%@ include file="../modal/modal-role-confirm.jsp" %>
    <%@ include file="../modal/modal-role-assign-auth.jsp" %>
    <%@ include file="../include/tail.jsp" %>
    <script type="text/javascript" src="static/jquery/jquery.pagination.js"></script>
    <script type="text/javascript" src="static/ztree/jquery.ztree.all-3.5.min.js"></script>
    <script type="text/javascript" src="static/js/my-roles.js"></script>
    <script type="text/javascript" >

        $(function () {
            // 为分页操作初始化数据
            window.pageNum = 1;
            window.pageSize = 5;
            window.keyword = "";

            // 调用执行分页的函数，显示分页效果
            generatePage();

            // 给查询按钮绑定单击响应函数
            $("#searchBtn").click(function () {
               // 获取关键词数据赋值给全局变量
                window.keyword = $("#keywordInput").val();

                // 调用分页的函数，刷新页面
                generatePage();
            });

            // 点击新增按钮打开模态框
            $("#showAddModalBtn").click(function () {

                $("#addModal").modal("show");
            });

            // 给模态框的保存按钮绑定响应函数
            $("#saveRoleBtn").click(function () {

                // 选择变量
                let addModalRoleName = $("#addModal [name=roleName]");

                // 获取用户在文本框中输入的角色名称
                var roleName = $.trim(addModalRoleName.val());

                $.ajax({
                    url: "role/save",
                    type: "post",
                    data: {
                        name: roleName
                    },
                    dataType: "json",
                    success: function (response) {
                        var result = response.result;

                        if (result === "SUCCESS") {
                            layer.msg("操作成功！");

                            // 页码定义最后一页
                            window.pageNum = 9999999;
                            // 重新加载分页
                            generatePage();
                        }

                        if (result === "FAILED") {
                            layer.msg("操作失败" + response.message);
                        }
                    },
                    error: function (response) {

                        layer.msg(response.status + " " + response.statusText);
                    }
                });
                // 关闭模态框
                $("#addModal").modal("hide");

                // 清理上次留下的数据
                addModalRoleName.val("");

            });

            var rolePageBody = $("#rolePageBody");

            // 找到动态生成元素附着的静态元素
            rolePageBody.on("click", ".pencilBtn", function () {
                // on() 1、事件类型；2、找到真正要绑定事件的元素的选择器；3、事件的响应函数

                // 打开模态框
                $("#editModal").modal("show");

                // 获取表格中当前行中的角色名称
                var roleName = $(this).parent().prev().text();

                // 获取当前角色的id,为了让执行更新的按钮获取到id,设为全局
                window.roleId = this.id;

                // 使用roleName的值设置模态框中的文本框
                $("#editModal [name=roleName]").val(roleName);
            });

            // 给更新模态框中更新按钮绑定单击响应函数
            $("#updateRoleBtn").click(function () {

                // 从文本框中获取新的角色名称
                var roleName = $("#editModal [name=roleName]").val();

                // 发送ajax请求执行更新
                $.ajax({
                    url: "role/update",
                    type: "post",
                    data: {
                        id: window.roleId,
                        name: roleName
                    },
                    dataType: "json",
                    success: function (response) {
                        var result = response.result;

                        if (result === "SUCCESS") {
                            layer.msg("操作成功！");

                            // 重新加载分页
                            generatePage();
                        }

                        if (result === "FAILED") {
                            layer.msg("操作失败" + response.message);
                        }
                    },
                    error: function (response) {

                        layer.msg(response.status + " " + response.statusText);

                    }
                });

                // 关闭模态框
                $("#editModal").modal("hide");
            });

            // 点击确认模态框中的确认删除执行删除
            $("#removeRoleBtn").click(function () {

                var requestBody = JSON.stringify(window.roleIdArray);

                $.ajax({
                    url: "role/remove",
                    type: "post",
                    data: requestBody,
                    contentType: "application/json;charset=UTF-8",
                    dataType: "json",
                    success: function (response) {
                        var result = response.result;

                        if (result === "SUCCESS") {
                            layer.msg("操作成功！");

                            // 重新加载分页
                            generatePage();
                            // 删除成功之后将全选框取消
                            $("#summaryBox").prop("checked", false);
                        }

                        if (result === "FAILED") {
                            layer.msg("操作失败" + response.message);
                        }
                    },
                    error: function (response) {

                        layer.msg(response.status + " " + response.statusText);

                    }
                });

                // 关闭模态框
                $("#confirmModal").modal("hide");
            });

            // 给单条删除绑定单击事件
            rolePageBody.on("click", ".removeBtn", function () {

                var roleName = $(this).parent().prev().text();
                // 创建一个role对象放入数组
                var roleArray = [{
                   roleId: this.id,
                    name: roleName
                }];

                // 调用打开模态框
                showConfirmModal(roleArray)
            });

            // 给总的checkbox绑定单击响应函数
            $("#summaryBox").click(function () {
                // 获取当前多选框自身的状态
                var currentStatus = this.checked;

                // 用当前多选框的状态设置其他的多选框
                $(".itemBox").prop("checked", currentStatus);
            });

            // 全选和全部选的反向操作
            rolePageBody.on("click", ".itemBox", function () {

                // 获取当前已经选中的.itemBox的数量
                var checkedBoxCount = $(".itemBox:checked").length;

                // 获取全部的.itemBox的数量
                var totalBoxCount = $(".itemBox").length;

                // 使用二者的比较结果设置总的checkedBox
                $("#summaryBox").prop("checked", checkedBoxCount === totalBoxCount);

            });

            // 给批量删除的按钮绑定单击函数
            $("#batchRemoveBtn").click(function () {
                // 创建一个对象数组来获取后面的角色对象
                var roleArray = [];
                // 历遍当前选中的多选框
                $(".itemBox:checked").each(function() {

                    // 使用this引用获取当前的多选框
                    var roleId = this.id;

                    // 通过DOM获取当前的角色名
                    var roleName = $(this).parent().next().text();
                    // 添加进数组中
                    roleArray.push({
                        roleId: roleId,
                        name: roleName
                    });
                });

                // 检查roleArray的长度是否为0
                if (roleArray.length === 0) {
                    layer.msg("请至少选择一个角色删除！");
                    return ;
                }

                // 调用专门的模态框函数执行删除
                showConfirmModal(roleArray);

            });

            // 给分配权限按钮绑定单击响应函数
            rolePageBody.on("click", ".checkBtn", function () {

                // 将当前角色id存入全局变量
                window.roleId = this.id;

                // 打开模态框
                $("#assignModal").modal("show");

                // 在模态框中装载书Auth的树形结构
                fillAuthTree();
            });

            // 给分配权限的模态框中的分配按钮绑定单击响应函数
            $("#assignBtn").click(function () {

                // 收集树形结构的各个节点中被勾选的节点
                // 声明一个用来专门存放id的数组
                let authIdArray = [];

                // 获取zTreeObj这个对象
                let zTreeObj = $.fn.zTree.getZTreeObj("authTreeDemo");

                // 获取全部被勾选的节点
                let checkedNodes = zTreeObj.getCheckedNodes();

                // 遍历数组
                for (let i = 0; i < checkedNodes.length; i++) {
                    let checkedNode = checkedNodes[i];

                    let authId = checkedNode.id;

                    authIdArray.push(authId);
                }

                // 发送请求执行分配
                let requestBody = {
                    "authIdArray": authIdArray,
                    "roleId": [window.roleId]
                }

                requestBody = JSON.stringify(requestBody);

                $.ajax({
                    url: "assign/role/assign/auth",
                    type: "post",
                    data: requestBody,
                    contentType: "application/json;charset=UTF-8",
                    dataType: "json",
                    success: function (response) {
                        let result = response.result;

                        if (result === "SUCCESS") {
                            layer.msg("操作成功！");
                        }

                        if (result === "FAILED") {
                            layer.msg("操作失败！" + response.message);
                        }
                    },
                    error: function (response) {
                        layer.msg(response.status + + response.statusText);
                    }
                });

                // 关闭模态框
                $("#assignModal").modal("hide");
            });

        });

    </script>
</body>
</html>