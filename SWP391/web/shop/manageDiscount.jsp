<%-- 
    Document   : manageDiscount
    Created on : [Your Creation Date]
    Author     : [Your Name]
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <title>Quản lý giảm giá</title>
        <style>
            .navbar-nav {
                display: flex;
                flex-direction: row;
            }
            .fa-pen-to-square {
                color: #76b852;
            }
            .fa-trash-can {
                color: coral;
            }
            .dropdown-toggle::after {
                display: none;
            }
            .dropdown-menu {
                width: auto;
                min-width: unset;
            }
            .dropdown-item {
                white-space: nowrap;
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
                        <a class="nav-link" href="../home.jsp">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1>
                        </a>
                    </li>
                </ul>
                <div style="margin-right: 20px">
                    <form class="d-flex" action="actionshop" method="get">
                        <input type="hidden" name="action" value="getDiscountBySearch">
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
                                    <a class="dropdown-item" href="actionshop?action=profile">Hồ sơ</a>
                                </li>

                                <li>
                                    <a class="dropdown-item" href="logout">Đăng xuất</a>
                                </li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </nav>

        <div class="flex-grow-1">
            <h1 class="text-center m-3">Quản lý giảm giá</h1>
            <div class="d-flex mb-3">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDiscount"
                        style="margin-left: 20px">
                    Thêm giảm giá
                </button>
                <div class="modal fade" id="addDiscount">
                    <div class="modal-dialog modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Thêm giảm giá mới</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="discount" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <b>Mã món ăn:</b>
                                    <input type="number" class="form-control" required="" name="foodId">
                                    <h5 class="text-danger">${requestScope.errorFoodId}</h5>

                                    <b>Tỷ lệ giảm giá (%):</b>
                                    <input type="number" class="form-control" required="" name="discountRate" min="1" max="100">

                                    <b>Ngày bắt đầu:</b>
                                    <input type="date" id="date" class="form-control" required="" name="startDate">
                                    <h5 class="text-danger">${requestScope.errorStartDate}</h5>
                                    <b>Ngày kết thúc:</b>
                                    <input type="date" class="form-control" required="" name="endDate" id="endDate">
                                    <h5 class="text-danger">${requestScope.errorEndDate}</h5>
                                    <h5 class="text-danger">${requestScope.errorDate}</h5>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-success">Thêm giảm giá</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${empty discountOnCurrentPage}">
                <h4 class="text-center mt-3">Chưa có giảm giá nào được áp dụng</h4>
            </c:if>
            <c:if test="${!empty discountOnCurrentPage}"> 
                <table class="table text-center">
                    <tr>
                        <th>Mã món ăn</th>
                        <th>Tỷ lệ giảm giá (%)</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Tùy chọn</th>
                    </tr>
                    <c:forEach var="discount" items="${discountOnCurrentPage}">
                        <tr style="vertical-align: middle">

                            <td>${discount.foodId}</td>
                            <td>${discount.discountRate}%</td>
                            <td><fmt:formatDate value="${discount.startDate}" pattern="dd-MM-yyyy"></fmt:formatDate></td>
                            <td><fmt:formatDate value="${discount.endDate}" pattern="dd-MM-yyyy"></fmt:formatDate></td>
                                <td>
                                    <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateDiscount${discount.discountId}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                                <div class="modal fade text-start" id="updateDiscount${discount.discountId}">
                                    <div class="modal-dialog modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Cập nhật giảm giá</h4>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="discount" method="post">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="discountId" value="${discount.discountId}">
                                                    <b>Mã món ăn:</b>
                                                    <input type="text" class="form-control" readonly value="${discount.foodId}" name="foodIdUpdate">
                                                    <h5 class="text-danger">${requestScope.errorFoodIdUpdate}</h5>
                                                    <b>Tỷ lệ giảm giá (%):</b>
                                                    <input type="number" class="form-control" required="" name="discountRateUpdate" value="${discount.discountRate}" min="0" max="100">
                                                    <b>Ngày bắt đầu:</b>
                                                    <input type="date" class="form-control" required="" name="startDateUpdate" value="${discount.startDate}">
                                                    <h5 class="text-danger">${requestScope.errorStartDateUpdate}</h5>
                                                    <b>Ngày kết thúc:</b>
                                                    <input type="date" class="form-control" required="" name="endDateUpdate" value="${discount.endDate}">
                                                    <h5 class="text-danger">${requestScope.errorEndDateUpdate}</h5>
                                                    <h5 class="text-danger">${requestScope.errorDateUpdate}</h5>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-success">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <form action="discount" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="discountId" value="${discount.discountId}">
                                    <button type="submit" class="btn btn-lg" onclick="return confirm('Bạn có chắc chắn muốn xóa giảm giá này?')">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
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

        <c:set var="n" value="${currentPage}"/>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p == n?"active":""}"  
                       href="discount?action=list&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>
        <script>
            var errorFoodId = "${requestScope.errorFoodId}";
            var errorStartDate = "${requestScope.errorStartDate}";
            var errorEndDate = "${requestScope.errorEndDate}";
            var errorDate = "${requestScope.errorDate}";
            if (errorFoodId.trim() !== "" || errorStartDate.trim() !== "" || errorEndDate.trim() !== "" || errorDate.trim() !== "") {
                $(document).ready(function () {
                    $('#addDiscount').modal('show');
                });
            }
            var errorFoodIdUpdate = "${requestScope.errorStartDateUpdate}";
            var errorStartDateUpdate = "${requestScope.errorStartDateUpdate}";
            var errorEndDateUpdate = "${requestScope.errorEndDateUpdate}";
            var errorDateUpdate = "${requestScope.errorDateUpdate}";
            if (errorFoodIdUpdate.trim() !== "" || errorStartDateUpdate.trim() !== "" || errorEndDateUpdate.trim() !== "" || errorDateUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateDiscount${discountId}').modal('show');
                });
            }
            
            // Lấy ngày hôm nay start date
            const today = new Date().toISOString().split('T')[0];

            // Đặt giá trị mặc định và giới hạn ngày tối thiểu
            const dateInput = document.getElementById('date');
            dateInput.value = today;
            dateInput.min = today;

            // Lấy ngày hôm nay end date
//            const today = new Date().toISOString().split('T')[0];

            // Đặt giá trị mặc định và giới hạn ngày tối thiểu
            const endDateInput = document.getElementById('endDate');
//            endDateInput.value = today;
            endDateInput.min = today;
        </script>
    </body>
</html>
