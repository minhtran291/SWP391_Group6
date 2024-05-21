<%-- 
    Document   : Home
    Created on : May 20, 2024, 7:23:39 PM
    Author     : Dell
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <title>Trang chủ</title>
        <style>
            .navbar-nav {
                display: flex;
                flex-direction: row;
            }
        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh">

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <div class="container">
                <ul class="navbar-nav">
                    <!--                    có sự khác nhau trong narbar-nav tự css và sử dụng các class
                                        được định nghĩa sẵn trong bootstrap 5 như d-flex và flex-row-->
                    <li class="nav-item">
                        <a class="nav-link" href="">Logo</a>
                    </li>
                </ul>

                <div>
                    <!-- da dang nhap -->
                    <c:if test="${account!=null}">
                        <form class="d-flex" action="" method="">
                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="input">
                            <button class="btn btn-primary me-2 text-nowrap" type="submit">Tìm kiếm</button>
                        </form>
                        <span class="btn btn text-white me-2 d-inline-block text-nowrap">
                            <a class="nav-link" href="">Hello ${account.username}</a>
                        </span>
                        <a class="btn btn-primary text-white" href="">Đăng xuất</a>
                    </c:if>
                    <!-- chua dang nhap -->    
                    <c:if test="${account==null}">
                        <form class="d-flex" action="" method="">
                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="input">
                            <button class="btn btn-primary me-2 text-nowrap" type="submit">Tìm kiếm</button>
                            <a class="btn btn-primary text-white text-nowrap" href="">Đăng nhập</a>
                        </form>
                    </c:if>
                </div>
            </div>
        </nav>

        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">
            <div class="d-flex bg-light mb-5">
                <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="">Trang chủ</a>
                        </li>
                        <li class="nav-item dropdown">
                            <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                Thể loại</button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" 
                                       href="action?action=updateCategory&&id=${c.id}">Sửa</a></li>
                                <li><a class="dropdown-item" 
                                       href="action?action=deleteCategory&&id=${c.id}" 
                                       onclick="return confirm('DO you want to delete')">Xóa</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="container">
                <ul class="list-unstyled d-flex flex-wrap">
                    <c:forEach var="f" items="${foodOnCurrentPage}">
                        <li class="w-25 m-3 border rounded-1 border-dark text-center">
                            <a class="text-decoration-none" href="">
                                <img src="${f.image}" class="img-fluid" 
                                     style="width: 225px; height: 225px" alt="${f.foodNname}"/>
                                <p class="text-muted fw-bold fs-3">${f.foodNname}</p>
                                <p>Giá: <span class="text-danger fw-bold">${f.price}</span></p>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>                           
        </div>

        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="">${p}</a>
                </li>
            </c:forEach>
        </ul>

        <footer>
            <div class="bg-dark">
                <div class="container text-white">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>Liên hệ</h4>
                            <p>Địa chỉ: Thạch Hòa, Thạch Thất, Hà Nội</p>
                            <p>Email: minh291@gmail.com</p>
                            <p>Số điện thoại: 0123456789</p>
                        </div>
                        <div class="col-md-6">
                            <h4>Liên kết</h4>
                            <ul class="list-unstyled">
                                <li><a href="#">Trang chủ</a></li>
                                <li><a href="#">Giới thiệu</a></li>
                                <li><a href="#">Sản phẩm</a></li>
                                <li><a href="#">Liên hệ</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
