<%-- 
    Document   : profile
    Created on : May 27, 2024, 11:15:12 AM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông tin người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <style>
            .navbar-nav {
                display: flex;
                flex-direction: row;
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
            <div class="container">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1></a>
                    </li>
                </ul>

                <div>
                    <form class="d-flex" action="actionshop" method="get">
                        <input type="hidden" name="action" value="getFoodBySearch">
                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                               style="width: 300px">
                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                            <i class="fa fa-search text-body"></i>
                        </button>

                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="actionshop?action=profile">
                                        Hồ sơ
                                    </a>
                                </li>
                                <!--                                <li>
                                                                    <a class="dropdown-item" href="actioncustomer?action=history">
                                                                        Đơn hàng
                                                                    </a>
                                                                </li>-->
                                <li>
                                    <a class="dropdown-item" href="managecomment?action=viewcomment">
                                        Xem lại bình luận
                                    </a>
                                </li>
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

        <div class="flex-grow-1 mb-5">
            <div class="container">
                <h1 class="text-center mt-3">Thông tin người dùng</h1>
                <form class="mt-5">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="d-flex justify-content-center mb-3">
                                <img src="${sessionScope.acc.avatar}" 
                                     alt="Hình ảnh đại diện" class="avatar img-circle img-thumbnail" style="width: 200px; height: 200px;">
                            </div>
                            <p class="text-center">Avatar</p>
                        </div>
                        <div class="col-md-9">
                            <div class="row mb-5 align-items-center">
                                <div class="col-md-2">
                                    <label class="form-label float-end">Tên đăng nhập:</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" readonly="" value="${sessionScope.acc.username}">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label float-end">Giới tính:</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" readonly=""
                                           value="${sessionScope.acc.gender == 1 ? "Nam" : "Nữ"}">
                                </div>
                            </div>
                            <div class="row mb-5 align-items-center">
                                <div class="col-md-2">
                                    <label class="form-label float-end">Email:</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" type="email" 
                                           value="${sessionScope.acc.email}"
                                           required=""
                                           name="email">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label float-end">Số điện thoại:</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" type="tel" 
                                           value="${sessionScope.acc.phone}"
                                           required=""
                                           name="gender">
                                </div>
                            </div>
                            <div class="row mb-5 align-items-center">
                                <div class="col-md-2">
                                    <label class="form-label float-end">Vai trò:</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" readonly=""
                                           value="${sessionScope.acc.getRoleidString()}">
                                </div>
                                <div class="col-md-6 d-flex justify-content-center">
                                    <a class="btn btn-success" href="actionshop?action=changepass">Thay đổi mặt khẩu</a>
                                </div>
                            </div>
                            <div class="row d-flex justify-content-center">
                                <!--<button class="btn btn-primary w-25">Cập nhật</button>-->
                                <a class="btn btn-primary w-25" href="UpdateProfile.jsp">Cập Nhật</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!--            <div class="container mt-5">
                            <form action="UploadServlet" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <input type="file" class="form-control w-25" id="file" name="file" accept="image/*" required
                                           value="">
                                </div>
                                <button type="submit" class="btn btn-primary">Tải lên</button>
                            </form>
                        </div>-->

        </div>

        <div class="offcanvas offcanvas-start text-bg-dark" id="demo">
            <div class="offcanvas-header">
                <h1 class="offcanvas-title">Quản lí cửa hàng</h1>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=dashBoard">Bảng diều khiển</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=manageFood">Quản lí sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="CategoryServlet?action=manageCategory">Quản lí thể loại sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=all-order">Quản lí đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="employee?action=manageEmp">Quản lí nhân viên</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="discount?action=list">Quản lí giảm giá</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=orderDivision">Phân đơn hàng</a></p>
            </div>
        </div>

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
    </body>
</html>
