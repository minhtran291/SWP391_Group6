<%-- 
    Document   : profileShipper
    Created on : Jul 27, 2024, 3:14:06 PM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <title>Hồ sơ</title>
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
            <div class="container">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="home">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1></a>
                    </li>
                </ul>

                <div>
                    <form class="d-flex" action="actioncustomer" method="get">
                        <input type="hidden" name="action" value="getFoodBySearch">
<!--                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                               style="width: 300px">
                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                            <i class="fa fa-search text-body"></i>
                        </button>-->

                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="profile">
                                        Hồ sơ
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="actionshipper?action=homeShipper">
                                        Danh sách giao hàng
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="logout">
                                        Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                        
                    </form>
                </div>
            </div>
        </nav>

        <div class="flex-grow-1 mb-5">
            <div class="container">
                <h1 class="text-center mt-3">Thông tin người dùng</h1>
                <form class="mt-5" action="" method="">
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
                                    <a class="btn btn-success" href="changepass">Thay đổi mặt khẩu</a>
                                </div>
                            </div>
                            <div class="row d-flex justify-content-center">
                                <!--<button class="btn btn-primary w-25">Cập nhật</button>-->
                                <a class="btn btn-primary w-25" href="updateprofile">Cập Nhật</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
