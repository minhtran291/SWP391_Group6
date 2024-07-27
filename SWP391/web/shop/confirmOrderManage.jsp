<%-- 
    Document   : confirmOrderManage
    Created on : Jul 26, 2024, 9:05:56 PM
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
        <title>Xác nhận đơn hàng</title>
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
                        <input type="hidden" name="action" value="manageGetFoodBySearch">
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
                                <li >
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

        <div class="flex-grow-1 mt-5">

            <div class="border border-3 rounded p-3 mb-5 container">
                <h4>Xác nhận đơn hàng</h4>
                <c:if test="${orderConfirmOnCurrentPage == null}">
                    Chưa có đơn hàng cần xác nhận
                </c:if>
                <c:if test="${orderConfirmOnCurrentPage != null}">
                    <table class="table text-center table-striped">
                        <tr style="vertical-align: middle">
                            <th>Mã đơn hàng</th>
                            <th>Tên khách hàng</th>
                            <th>Số điện thoại</th>
                            <th>Tổng tiền</th>
                            <th>Địa chỉ giao hàng</th>
                            <th>Chi tiết</th>
                            <th>Thao tác</th>
                        </tr>
                        <c:forEach var="l" items="${orderConfirmOnCurrentPage}">
                            <tr style="vertical-align: middle">

                                <td>${l.id}</td>
                                <td>${l.users.username}</td>
                                <td>${l.users.phone}</td>
                                <!--<td>${l.id}</td>-->
                                <td><fmt:formatNumber type="currency" 
                                                  currencyCode="VND"
                                                  maxFractionDigits="0"
                                                  value="${l.total}"/></td>
                                <td>${l.address}</td>
                                <td><a href="actionshop?action=od&orderId=${l.id}">Xem chi tiết đơn hàng</a></td>
                                <td>
                                    <a class="btn btn-primary" 
                                       href="actionshop?action=updateStatusConfirm&status=confirm&orderId=${l.id}">
                                        <i class="fa-solid fa-check"></i>
                                    </a>
                                    <button class="border-0 btn btn-danger" data-bs-toggle="modal" data-bs-target="#demo${l.id}">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                    <div class="modal fade text-start" id="demo${l.id}">
                                        <div class="modal-dialog modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title">Nhập lí do</h4>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="actionshop" method="get">
                                                        <input type="hidden" name="action" value="updateStatusConfirm">
                                                        <input type="hidden" name="status" value="cancel">
                                                        <input type="hidden" name="orderId" value="${l.id}">
                                                        <input class="form-control" type="text" required="" name="shopNotes" placeholder="Nhập lí do">
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                            <button type="submit" class="btn btn-success">Lưu</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </div>

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
                      href="actionshop?action=confirmOrder">Xác nhận đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=all-order">Quản lí đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="employee?action=manageEmp">Quản lí nhân viên</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="discount?action=list">Quản lí giảm giá</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="manageblog">Quản lí Blog</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=orderDivision">Phân đơn hàng</a></p>
            </div>
        </div>

        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="actionshop?action=confirmOrder&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>
    </body>
</html>
