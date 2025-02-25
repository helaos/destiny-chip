<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <%@ include file="../include/header.jsp" %>
    <title>管理-控制面板</title>
</head>

<body>

<%@ include file="../include/nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../include/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="admin/main">首页</a></li>
                <li><a href="admin/getPageInfo">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form action="admin/update" method="post" role="form">
                        <input type="hidden" name="id" value="${requestScope.admin.id }" />
                        <input type="hidden" name="pageNum" value="${param.pageNum }" />
                        <input type="hidden" name="keyword" value="${param.keyword }" />
                        <p>${requestScope.exception.message }</p>
                        <div class="form-group">
                            <label for="exampleInputPassword1">登陆账号</label>
                            <input type="text" name="loginAccount"  class="form-control" id="exampleInputPassword1" value="${requestScope.admin.loginAccount }">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">用户昵称</label>
                            <input type="text" name="username" class="form-control" id="exampleInputPassword1" value="${requestScope.admin.username }">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">邮箱地址</label>
                            <input type="email" name="email" class="form-control" id="exampleInputEmail1" value="${requestScope.admin.email }">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="glyphicon glyphicon-edit"></i> 修改
                        </button>
                        <button type="reset" class="btn btn-danger">
                            <i class="glyphicon glyphicon-refresh"></i> 重置
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../include/tail.jsp" %>
</body>
</html>
