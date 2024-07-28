<%-- 
    Document   : manageWard
    Created on : Jul 22, 2024, 9:59:49 PM
    Author     : Dell
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí xã phường</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
            .navbar-nav {
                display: flex;
                flex-direction: row;
            }

            .fa-pen-to-square{
                color: #76b852;
            }
            .fa-trash-can{
                color: coral;
            }
            .dropdown-toggle::after {
                display: none;
            }
            .dropdown-menu {
                width: auto; /* Tự động điều chỉnh độ rộng theo nội dung */
                min-width: unset; /* Bỏ giá trị min-width mặc định */
            }

            .dropdown-item {
                white-space: nowrap; /* Đảm bảo nội dung không bị cắt xuống dòng */
            }
        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh;">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">

            <div style="margin-left: 20px;">
                <button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    <i class="fa-solid fa-bars"></i>
                </button>
            </div>


            <div class="container-fluid" style="padding-left: 40px;">
                <ul class="navbar-nav">

                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1></a>
                    </li>
                </ul>

                <div style="margin-right: 20px">
                    <form class="d-flex" action="actionshop" method="get">


                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="actionadmin?action=profile">
                                        Hồ sơ
                                    </a>
                                </li>
                                <!--                                <li>
                                                                    <a class="dropdown-item" href="actioncustomer?action=history">
                                                                        Đơn hàng
                                                                    </a>
                                                                </li>-->
                                
                                <li>
                                    <a class="dropdown-item" href="logout">
                                        Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <!--                        <a class="btn btn-square bg-white rounded-circle" href="">
                                                    <i class="fa fa-shopping-bag text-body"></i>
                                                </a>-->
                    </form>
                </div>
            </div>
        </nav>

        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">
            <h1 class="text-center m-3">Quản lý xã phường</h1>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addWard"
                    style="margin-left: 20px">
                Thêm xã phường
            </button>

            <div class="modal fade" id="addWard">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Thêm xã phường mới</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                            <form action="actionadmin" method="post">
                                <input type="hidden" name="action" value="addWard">
                                <input type="hidden" name="page" value="${n}">
                                <div class="modal-body">
                                    <b>Tên xã phường:</b>
                                    <input type="text"
                                           class="form-control mb-3"
                                           required=""
                                           name="wardName"
                                           >
                                    <h5 class="text-danger">${requestScope.errorWardName}</h5>
                                    <b>Quận huyện:</b>
                                    <div>
                                        <select class="form-select" name="district">
                                            <c:forEach var="d" items="${sessionScope.listDistrict}">
                                                <option value="${d.districtId}">
                                                    ${d.districtName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <table class="table text-center">
                <tr>
                    <th>Mã xã phường</th>
                    <th>Tên xã phường</th>
                    <th>Tên quận huyện</th>
                    <th>Tùy chọn</th>
                </tr>
                <c:forEach items="${wardOnCurrentPage}" var="w">
                    <tr style="vertical-align: middle">
                        <td>${w.wardId}</td>
                        <td>${w.wardName}</td>
                        <td>${w.district.districtName}</td>
                        <td>
                            <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateWard${w.wardId}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>
                            <div class="modal fade text-start" id="updateWard${w.wardId}">
                                <div class="modal-dialog modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Cập nhật xã phường</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="actionadmin" method="post">
                                                <input type="hidden" name="action" value="updateWard">
                                                <input type="hidden" name="page" value="${n}">
                                                <b>Mã xã phường:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       readonly=""
                                                       value="${w.wardId}"
                                                       name="wardId"
                                                       >
                                                <b>Tên xã phường:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       value="${w.wardName}"
                                                       required=""
                                                       name="wardNameUpdate"
                                                       >
                                                <h5 class="text-danger">${requestScope.errorWardNameUpdate}</h5>
                                                <b>Quận huyện:</b>
                                                <div>
                                                    <select class="form-select" name="districtUpdate">
                                                        <c:forEach var="d" items="${sessionScope.listDistrict}">
                                                            <option value="${d.districtId}" ${w.districtId == d.districtId?"selected":""}>
                                                                ${d.districtName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${w.isDeleted == 1}">
                                <a class="btn btn-lg btn-danger" 
                                   href="actionadmin?action=deleteWard&&deleteId=${w.wardId}&&page=${n}"
                                   onclick="return confirm('Bạn có chắc chắn muốn ẩn không ${w.wardId} ?')">
                                    Ẩn
                                </a>
                            </c:if>
                            <c:if test="${w.isDeleted == 0}">
                                <a class="btn btn-lg btn-danger" 
                                   href="actionadmin?action=unDeleteWard&&deleteId=${w.wardId}&&page=${n}"
                                   onclick="return confirm('Bạn có chắc chắn muốn hiện không ${w.wardId} ?')">
                                    Hiện
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="offcanvas offcanvas-start text-bg-dark" id="demo">
            <div class="offcanvas-header">
                <h1 class="offcanvas-title">Quản lí cửa hàng</h1>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <p><a class="btn text-white btn-primary" 
                      href="actionadmin?action=dashboard">Bảng điều khiển</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionadmin?action=manageAcc">Quản lí tài khoản</a></p>
                <!--                <p><a class="btn text-white btn-primary" 
                                      href="">Quản lí địa điểm giao nhận hàng</a></p>-->
                <div class="dropdown">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
                        Quản lí địa điểm giao nhận hàng
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="actionadmin?action=districtManagement">Quản lí quận, huyện</a></li>
                        <li><a class="dropdown-item" href="actionadmin?action=wardManagement">Quản lí xã, phường</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p == n?"active":""}"  
                       href="actionadmin?action=wardManagement&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>

<!--        <footer>
            <div class="bg-dark p-3">
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
        </footer>-->

        <script>
            var errorWardName = "${requestScope.errorWardName}";
            if (errorWardName.trim() !== "") {
                $(document).ready(function () {
                    $('#addWard').modal('show');
                });
            }
            var errorWardNameUpdate = "${requestScope.errorWardNameUpdate}";
            if (errorWardNameUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateWard${wardId}').modal('show');
                });
            }
        </script>
    </body>
</html>
