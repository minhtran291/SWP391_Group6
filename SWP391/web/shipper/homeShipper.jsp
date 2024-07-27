<%-- 
    Document   : homeShipper
    Created on : Jun 18, 2024, 9:42:22 PM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ</title>
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
                        <a class="nav-link" href="#">
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
                                                               style="width: 300px">-->
                            <!--                            <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
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


        <div class="flex-grow-1 ">
            <h1 class="text-center mb-3">Danh sách giao hàng</h1>
            <table class="table text-center">
                <tr style="vertical-align: middle">
                    <th>Mã đơn hàng</th>
                    <th>Tên khách hàng</th>
                    <th>Số điện thoại</th>
                    <th>Tổng tiền</th>
                    <!--                    <th>Trạng thái giao hàng</th>-->
                    <!--<th>Hình thức thanh toán</th>-->
                    <!--<th>Trạng thái thanh toán</th>-->
                    <th>Địa điểm giao hàng</th>
                    <th>Chi tiết</th>
                    <th>Thao tác</th>
                </tr>
                <c:forEach var="d" items="${deliveryShipperOnCurrentPage}">
                    <tr style="vertical-align: middle">
                        <td>${d.id}</td>
                        <td>${d.users.username}</td>
                        <td>${d.users.phone}</td>
                        <td><fmt:formatNumber type="currency" 
                                          currencyCode="VND"
                                          maxFractionDigits="0"
                                          value="${d.total}"/></td>
                        <!--<td>${d.status}</td>-->
<!--                        <td>${d.statusName}</td>-->
                        <!--<c:if test="${d.payment.paymentType == null}">
                            <td>Chưa chọn hình thức</td>
                        </c:if>
                        <c:if test="${d.payment.paymentType != null}">
                            <td>${d.payment.paymentType}</td>
                        </c:if>
                        <td>${d.statusPaymentName}</td>-->
                        <td>${d.address}</td>
                        <td><a href="actionshipper?action=deliveryDetail&orderId=${d.id}">Xem chi tiết</a></td>
                        <td>
                            <c:if test="${d.status == 5}">
                                <a class="btn btn-danger disabled">Đã hủy</a>
                            </c:if>
                            <c:if test="${d.status == 4}">
                                <a class="btn btn-success disabled">Đã giao</a>
                            </c:if>
                            <c:if test="${d.status != 5 && d.status != 4}">
                                <div class="dropdown">
                                    <button type="button" class="btn btn-primary text-white dropdown-toggle" 
                                            data-bs-toggle="dropdown">
                                        Cập nhật trạng thái
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <a class="dropdown-item" 
                                               href="actionshipper?action=updateStatus&status=done&orderId=${d.id}">
                                                Đã giao
                                            </a>
                                        </li>
                                        <li>
                                            <button class="border-0 btn dropdown-item" data-bs-toggle="modal" data-bs-target="#demo${d.id}">
                                                Đã hủy
                                            </button>

                                        </li>
                                    </ul>
                                </div>

                                <div class="modal fade text-start" id="demo${d.id}">
                                    <div class="modal-dialog modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Nhập lí do</h4>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="actionshipper" method="get">
                                                    <input type="hidden" name="action" value="updateStatus">
                                                    <input type="hidden" name="status" value="break">
                                                    <input type="hidden" name="orderId" value="${d.id}">
                                                    <input class="form-control" type="text" required="" name="shipperNotes" placeholder="Nhập lí do">
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-success">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if> 
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <c:set var="n" value="${currentPage}"/>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="actionshipper?action=homeShipper&&page=${p}">${p}</a>
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
