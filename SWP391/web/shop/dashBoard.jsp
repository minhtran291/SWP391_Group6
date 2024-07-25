<%-- 
    Document   : dashBoard
    Created on : Jun 6, 2024, 7:56:29 PM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <title>Bảng điều khiển</title>
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
            .fa-solid fa-check{
                color: #76b852;
            }
            .fa-solid fa-xmark{
                color: coral;
            }
        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh;">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
            <div style="margin-left: 20px;">
                <button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    <i class="fa-solid fa-bars"></i>
                </button>
            </div>

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
                        <form class="d-flex" action="actionshop" method="get">
                            <input type="hidden" name="action" value="getFoodBySearch">
<!--                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
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
                                        <a class="dropdown-item" href="actionshop?action=profile">
                                            Hồ sơ
                                        </a>
                                    </li>
<!--                                    <li>
                                        <a class="dropdown-item" href="actioncustomer?action=history">
                                            Đơn hàng
                                        </a>
                                    </li>-->
<!--                                    <li>
                                        <a class="dropdown-item" href="managecomment?action=viewcomment">
                                            Xem lại bình luận
                                        </a>
                                    </li>-->
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

        <div class="flex-grow-1 mb-5">
            <div class="container">
                <h1 class="mb-3">Tổng quan</h1>
                <div class="row justify-content-around mb-5">
                    <div class="col-md-2 shadow bg-white p-3">Số lượng sản phẩm: ${numberFood}</div>
                    <div class="col-md-2 shadow bg-white p-3">Số lượng đơn hàng đang xử lý: ${numberOrder}</div>
                    <div class="col-md-2 shadow bg-white p-3">Số lượng khách hàng: ${numberUser}</div>
                    <div class="col-md-2 shadow bg-white p-3">Tổng doanh thu: <fmt:formatNumber type="currency" 
                                      currencyCode="VND"
                                      maxFractionDigits="0"
                                      value="${profit}"/></div>
                </div>

                <div class="border border-3 rounded p-3 mb-5">
                    <h4>Xác nhận đơn hàng</h4>
                    <c:if test="${listOrderConfirm == null}">
                        Chưa có đơn hàng cần xác nhận
                    </c:if>
                    <c:if test="${listOrderConfirm != null}">
                        <table class="table text-center table-striped">
                            <tr style="vertical-align: middle">
                                <td>Mã đơn hàng</td>
                                <td>Tên khách hàng</td>
                                <td>Số điện thoại</td>
                                <td>Tổng tiền</td>
                                <td>Địa chỉ giao hàng</td>
                                <td>Chi tiết</td>
                                <td>Thao tác</td>
                            </tr>
                            <c:forEach var="l" items="${listOrderConfirm}">
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
                <div class="row">
                    <div class="col-md-6">
                        <h3>Các món ăn sắp hết hàng</h3>
                        <c:if test="${foodOutOfStock == null}">
                            Chưa có món nào sắp hết hàng
                        </c:if>
                        <c:if test="${foodOutOfStock != null}">
                            <c:set var="s" value="${0}"/>
                            <table class="table text-center table-striped">
                                <tr>
                                    <th>Số thứ tự</th>
                                    <th>Tên món ăn</th>
                                    <th>Số lượng tồn kho</th>
                                </tr>
                                <c:forEach var="f" items="${foodOutOfStock}">
                                    <c:set var="s" value="${s + 1}" />
                                    <tr style="vertical-align: middle">
                                        <td>${s}</td>
                                        <td>${f.foodName}</td>
                                        <td>${f.stock}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>
                    <div class="col-md-6">
                        <div class="border border-3 rounded p-3 mb-3">
                            <h4 class="mb-3">Biểu đồ doanh thu theo tháng</h4>
                            <canvas id="sale-revenue"></canvas>
                        </div>
                    </div>
                </div>

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

<!--        <footer>
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
        </footer>-->

        <script type="text/javascript">
            var chart = document.getElementById("sale-revenue").getContext("2d");
            var myChart = new Chart(chart, {
                type: "bar",
                data: {
                    labels: ["Tháng 1", "Tháng 6"],
                    datasets: [{
                            label: "Doanh thu",
                            data: [${requestScope.month6}],
                            backgroundColor: "rgba(0, 156, 255, .5)",
                            backgroundColor: "rgba(0, 156, 255, .5)"
                        }
                    ]
                },
                options: {
                    responsive: true
                }
            });
        </script>
    </body>
</html>
