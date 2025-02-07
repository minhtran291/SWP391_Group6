<%-- 
    Document   : DeliveryDetail
    Created on : Jun 24, 2024, 2:46:10 PM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
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
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
            <!--            <div style="margin-left: 20px;">
                            <button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                                <i class="fa-solid fa-bars"></i>
                            </button>
                        </div>-->

            <div class="container-fluid" style="padding-left: 40px;">
                <ul class="navbar-nav">
                    <!--                    có sự khác nhau trong narbar-nav tự css và sử dụng các class
                                        được định nghĩa sẵn trong bootstrap 5 như d-flex và flex-row-->
                    <li class="nav-item">
                        <a class="nav-link" href="actionshop?action=homeFood">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1></a>
                    </li>
                </ul>

                <div style="margin-right: 20px">
                    <!-- da dang nhap -->
                    <c:if test="${acc!=null}">
                        <form class="d-flex" action="" method="get">
                            <input type="hidden" name="action" value="">
                            <!--                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                                               style="width: 300px">
                                                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                                            <i class="fa fa-search text-body"></i>
                                                        </button>-->
                            <!--                            <a class="btn btn-square bg-white rounded-circle me-2" href="">
                                                            <i class="fa fa-user text-body"></i>
                                                        </a>-->


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

                    </c:if>

                </div>
            </div>
        </nav>

        <div class="flex-grow-1 container">
            <h1 class="text-center mb-3">Chi tiết đơn hàng</h1>
            <p class="text-center">Mã đơn hàng: ${order.id}</p>
            <p class="text-center">Ngày đặt hàng:  <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"></fmt:formatDate></p>
            <p class="text-center">Thời gian đặt hàng: ${order.orderTime}</p>
            <p class="text-center">Hình thức thanh toán: ${order.payment.paymentType}</p>
            <p class="text-center">Trạng thái thanh toán: ${order.statusPaymentName}</p>
            <table class="table text-center border border-3">
                <tr style="vertical-align: middle">
                    <th>Số thứ tự</th>
                    <th>Tên món ăn</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>
                </tr>
                <c:set var="s" value="${0}"/>
                <c:forEach var="d" items="${deliveryDetailOnCurrentPage}">
                    <c:set var="s" value="${s + 1}"/>
                    <tr style="vertical-align: middle">
                        <td>${s}</td>
                        <td>${d.food.foodName}</td>
                        <td><fmt:formatNumber type="currency" 
                                          currencyCode="VND"
                                          maxFractionDigits="0"
                                          value="${d.price}"/></td>
                        <td>${d.quantity}</td>
                        <td><img width="113px" height="113px" src="${d.food.image}" alt="${d.food.foodName}"></td>
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
                      href="actionshop?action=dashBoard">
                        Bảng diều khiển</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=manageFood">
                        Quản lí sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="CategoryServlet?action=manageCategory">
                        Quản lí thể loại sản phẩm</a></p>
                <p><a class="btn text-white btn-primary">Quản lí đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="employee?action=manageEmp">Quản lí nhân viên</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=orderDivision">Phân đơn hàng</a></p>
            </div>
        </div>

        <c:set var="order" value="${order}"/>
        <c:set var="n" value="${currentPage}"/>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="actionshipper?action=deliveryDetail&&page=${p}&orderId=${order.id}">${p}</a>
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
    </body>
</html>
