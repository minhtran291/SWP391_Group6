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

        <title>Quản lí thể loại sản phẩm</title>
        <style>
            /* CSS styles here */
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
                    <form class="d-flex" action="actionshop?action=homeFood" method="get">
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
                                <li >
                                    <a class="dropdown-item" href="#">
                                        Hồ sơ
                                    </a>
                                </li>
                                <!--                                <li>
                                                                    <a class="dropdown-item" href="actioncustomer?action=history">
                                                                        Đơn hàng
                                                                    </a>
                                                                </li>-->
<!--                                <li>
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


                        <!--                        <a class="btn btn-square bg-white rounded-circle" href="">
                                                    <i class="fa fa-shopping-bag text-body"></i>
                                                </a>-->
                    </form>
                </div>
            </div>
        </nav>
        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">

<!--            <div class="d-flex bg-light mb-5">
                <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="actionshop?action=homeFood" style="font-size: 16px;">Trang chủ</a>
                        </li>
                        <li class="nav-item dropdown">
                            <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                Thể loại</button>
                            <ul class="dropdown-menu">
                                <c:forEach var="c" items="${categoryList}">
                                    <li><a class="dropdown-item" 
                                           href="actionshop?action=getFoodByCategory&&cid=${c.category_id}">${c.category_name}</a></li>
                                    </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>-->

            <div class="flex-grow-1">
                <h1 class="text-center m-3">Quản lý thể loại sản phẩm</h1>

                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategory" style="margin-left: 20px">
                    Thêm thể loại
                </button>

                <!-- Modal for adding category -->
                <div class="modal fade" id="addCategory">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Thêm thể loại</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form action="CategoryServlet" method="post">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên thể loại</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary" name="action" value="insert">Lưu</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <table class="table text-center">
                    <tr>
                        <th>Mã thể loại</th>
                        <th>Tên thể loại</th>
                        <th>Tùy chọn</th>

                    </tr>
                    <!-- Iterate through categories -->
                    <c:forEach var="c" items="${categoryList}">
                        <tr>
                            <td>${c.category_id}</td>
                            <td>${c.category_name}</td>
                            <td>
                                <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateCategory${c.category_id}">
                                    <i class="fa fa-pen-to-square"></i>
                                </button>

                                <!-- Modal for updating category -->
                                <div class="modal fade text-start" id="updateCategory${c.category_id}">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Cập nhật thể loại</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="CategoryServlet" method="post">
                                                    <div class="mb-3">
                                                        <label for="name${c.category_id}" class="form-label">Tên thể loại</label>
                                                        <input type="text" class="form-control" id="name${c.category_id}" name="name" value="${c.category_name}" required>
                                                    </div>
                                                    <input type="hidden" name="id" value="${c.category_id}">
                                                    <button type="submit" class="btn btn-primary" name="action" value="update">Lưu</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <c:if test="${c.status==1}">
                                    <a class="btn btn-danger" href="CategoryServlet?action=updateStatus&id=${c.category_id}&status=0" >
                                        Ẩn
                                    </a>
                                </c:if>
                                <c:if test="${c.status==0}">
                                    <a class="btn btn-danger" href="CategoryServlet?action=updateStatus&id=${c.category_id}&status=1" >
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

            <!-- Pagination -->
            <!--            <ul class="pagination justify-content-center">
                             Pagination logic here 
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item ${p == currentPage ? 'active' : ''}">
                    <a class="page-link" href="CategoryServlet?action=list&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>-->

<!--            <footer>
                 Footer content here 
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
                // JavaScript logic here
                var errorName = "${requestScope.errorName}";
                if (errorName && errorName.trim() !== "") {
                    $(document).ready(function () {
                        $('#addCategory').modal('show');
                    });
                }

                var errorNameUpdate = "${requestScope.errorNameUpdate}";
                if (errorNameUpdate && errorNameUpdate.trim() !== "") {
                    $(document).ready(function () {
                        $('#updateCategory${id}').modal('show');
                    });
                }
            </script>
    </body>
</html>
