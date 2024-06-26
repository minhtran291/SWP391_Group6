<%-- 
    Document   : orderDivision
    Created on : Jun 14, 2024, 7:57:07 AM
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
        <title>Phân đơn hàng</title>
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
            .table-row:hover {
                cursor: pointer;
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
                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                   style="width: 300px">
                            <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                <i class="fa fa-search text-body"></i>
                            </button>
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
                                        <a class="dropdown-item" href="actionshop?action=profile">
                                            Hồ sơ
                                        </a>
                                    </li>
<!--                                    <li>
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
                        </form>

                    </c:if>

                </div>
            </div>
        </nav>

        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">

            <h1 class="text-center m-3">Phân đơn hàng</h1>

            <table class="table text-center">
                <tr>
                    <!--                    <th>Mã giao hàng</th>-->
                    <th>Mã đơn hàng</th>
                    <th>Người giao hàng</th>
                    <th>Địa chỉ giao hàng</th>
                    <!--                    <th>Ngày giao hàng</th>-->
                    <!--                    <th>Thời gian giao hàng</th>-->
                    <th>Chi tiết</th>
                    <th>Tùy chọn</th>
                </tr>
                <c:forEach var="d" items="${deliveryOnCurrentPage}">
                    <tr style="vertical-align: middle">
<!--                        <td>${d.id}</td>-->
                        <td>${d.orderID.id}</td>
                        <c:if test="${d.userName == null}">
                            <td>Chưa có</td>
                        </c:if>
                        <c:if test="${d.userName != null}">
                            <td>${d.userName.username}</td>
                        </c:if>
                        <td>${d.deliveryLocation}</td>
<!--                        <td><fmt:formatDate value="${d.deliveryDate}" pattern="dd-MM-yyyy"/></td>
                        <td><fmt:formatDate value="${d.deliveryTime}" pattern="HH:mm"/></td>-->
                        <td><a href="actionshop?action=od&orderId=${d.orderID.id}">Xem chi tiết</a></td>
                        <td>
                            <c:if test="${d.status == 2 || d.status == 3}">
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chooseEmployee${d.id}"
                                        style="margin-left: 20px;">
                                    Chọn người giao hàng
                                </button>
                                <div class="modal fade text-start" id="chooseEmployee${d.id}">
                                    <div class="modal-dialog modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Danh sách người giao hàng</h4>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="actionshop" method="post">
                                                    <input type="hidden" name="action" value="chooseEmployee"/>
                                                    <input type="hidden" name="orderId" value="${d.orderID.id}"/>
                                                    <input type="hidden" name="deliveryID" value="${d.id}"/>
                                                    <table class="table text-center">
                                                        <tr>
                                                            <td>Tên người giao hàng</td>
                                                            <td>Số lượng đơn hàng</td>
                                                            <td>Lựa chọn</td>
                                                        </tr>
                                                        <c:forEach var="e" items="${listEmployee}">
                                                            <tr>
                                                                <td>${e.username}</td>
                                                                <td>${e.orderNumber}</td>
                                                                <td><input type="radio" name="employee" value="${e.username}" 
                                                                           style="cursor: pointer"
                                                                           ${d.userName.username == e.username?'checked data-waschecked="true"':""}/></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-success" id="submitButton${d.id}">Chọn</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${d.status == 4}">
                                <span class="btn btn-success disabled">Đã giao</span>
                            </c:if>
                            <c:if test="${d.status == 5}">
                                <span class="btn btn-danger disabled">Đã hủy</span>
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
                      href="actionshop?action=orderDivision">Phân đơn hàng</a></p>
            </div>
        </div>

        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="actionshop?action=orderDivision&&page=${p}">${p}</a>
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const modals = document.querySelectorAll('.modal');

                modals.forEach(modal => {
                    const radios = modal.querySelectorAll('input[type="radio"]');
                    const submitButton = modal.querySelector('.btn-success'); // Assuming .btn-success is the submit button inside modal

                    radios.forEach(radio => {
                        radio.addEventListener('click', function () {
                            if (this.checked && this.hasAttribute('data-waschecked')) {
                                this.checked = false;
                                this.removeAttribute('data-waschecked');
                            } else {
                                radios.forEach(r => r.removeAttribute('data-waschecked'));
                                this.setAttribute('data-waschecked', 'true');
                            }
                            checkSelected(radios, submitButton);
                        });
                    });

                    function checkSelected(radios, submitButton) {
                        const anyChecked = Array.from(radios).some(radio => radio.checked);
                        submitButton.disabled = !anyChecked;
                    }

                    checkSelected(radios, submitButton);
                });
            });
        </script>
    </body>
</html>
