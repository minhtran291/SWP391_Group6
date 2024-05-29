<%-- 
    Document   : login
    Created on : May 26, 2024, 10:02:53 PM
    Author     : Dell
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .login-form {
                width: 370px;
                margin: 100px auto;
                font-size: 15px;
            }
            .login-form form {
                margin-bottom: 15px;
                background: #f7f7f7;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
                padding: 30px;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="login-form">
            <c:set var="cookie" value="${pageContext.request.cookies}"/>
            <form action="login" method="post">
                <h2 class="text-center">Đăng nhập</h2>   
                <p class="text-danger">${mess}</p>  

                <div class="form-group">
                    <input name="username" type="text" value="${cookie.cuser.value}" 
                           class="form-control" placeholder="Tên đăng nhập" required="required">

                </div>  
                <div class="form-group">
                    <input name="password" type="password" value="${cookie.cpass.value}" 
                           class="form-control" placeholder="Mật khẩu" required="required"> 
                </div>
                <div class="mb-3">
                    <input type="checkbox" ${(cookie.cremem!=null?'checked':'')} name="remember" value="ON"/>Ghi nhớ đăng nhập
                    <a href="forget" class="text-end text-decoration-none float-end">Quên mật khẩu?</a>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>
                </div>

                <hr>
                <div class="text-center"><a href="register.jsp">Tạo tài khoản</a>
                </div>
            </form>
        </div>
    </body>
</html>
