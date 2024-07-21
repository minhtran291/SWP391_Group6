<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <title>Quản lí Blog</title>
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
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            .content-column {
                max-width: 300px; /* Giới hạn chiều rộng của cột */
                overflow: hidden; /* Ẩn nội dung vượt quá */
                text-overflow: ellipsis; /* Thêm dấu ba chấm nếu nội dung quá dài */
                white-space: nowrap; /* Không cho phép xuống dòng */
            }

            .content-wrapper {
                max-height: 200px; /* Giới hạn chiều cao của wrapper */
                overflow-y: auto; /* Thêm thanh cuộn dọc nếu cần */
                width: 100%; /* Đảm bảo wrapper chiếm hết chiều rộng của cột */
            }

            .form-control {
                width: 100%; /* Đảm bảo textarea chiếm hết chiều rộng của wrapper */
                resize: none; /* Không cho phép người dùng thay đổi kích thước textarea */
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
                            </h1>
                        </a>
                    </li>
                </ul>
                <div style="margin-right: 20px">
                    <form class="d-flex" action="blog" method="get">
                        <input type="hidden" name="action" value="list">
                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search" style="width: 300px">
                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                            <i class="fa fa-search text-body"></i>
                        </button>
                    </form>
                </div>
            </div>
        </nav>

        <div class="container-fluid mt-4">
            <h1 class="text-center mb-4">Quản lý Blog</h1>

            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                Thêm Blog
            </button>

            <!-- Modal - Thêm Blog -->
            <div class="modal fade" id="addBlogModal" tabindex="-1" aria-labelledby="addBlogModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <form action="manageblog" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBlogModalLabel">Thêm Blog</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-3">
                                    <label for="title" class="form-label">Tiêu đề:</label>
                                    <input type="text" class="form-control" id="title" name="title" required="">
                                </div>
                                <div class="mb-3">
                                    <label for="content" class="form-label">Nội dung:</label>
                                    <textarea class="form-control" id="content" name="content" rows="5" required=""></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="author" class="form-label">Tác giả:</label>
                                    <input type="text" class="form-control" id="author" name="author" required="">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary">Thêm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Danh sách Blog -->
            <table class="table">
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Tiêu đề</th>
            <th scope="col">Nội dung</th>
            <th scope="col">Tác giả</th>
            <th scope="col">Ngày tạo</th>
            <th scope="col">Tùy chọn</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="blog" items="${blogOnCurrentPage}">
            <tr style="vertical-align: middle">
                <th scope="row">${blog.id}</th>
                <td>${blog.title}</td>
                <td class="content-column">
                    <div class="content-wrapper">
                        <textarea class="form-control" id="content" name="contentUpdate" rows="5" required="" readonly>${blog.content}</textarea>
                    </div>
                </td>
                <td>${blog.author}</td>
                <td><fmt:formatDate value="${blog.dateCreated}" pattern="dd-MM-yyyy"/></td>
                <td>
                    <button class="btn btn-sm btn-primary " data-bs-toggle="modal" data-bs-target="#updateDiscount${blog.id}">
                        Sửa
                    </button>
                    <div class="modal fade text-start" id="updateDiscount${blog.id}">
                        <div class="modal-dialog modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Cập nhật Blog</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="manageblog" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${blog.id}">
                                        <b>Tiêu đề:</b>
                                        <input type="text" class="form-control" value="${blog.title}" name="titleUpdate">
                                        <h5 class="text-danger">${requestScope.errorFoodIdUpdate}</h5>
                                        <div class="content-wrapper">
                                            <label for="content" class="form-label">Nội dung:</label>
                                            <textarea class="form-control" id="content" name="contentUpdate" rows="5" required="">${blog.content}</textarea>
                                        </div>
                                        <b>Tác giả:</b>
                                        <input type="text" class="form-control" required="" name="authorUpdate" value="${blog.author}">
                                        <h5 class="text-danger">${requestScope.errorStartDateUpdate}</h5>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-success">Lưu</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteBlogModal${blog.id}">
                        Xóa
                    </button>
                    <div class="modal fade" id="deleteBlogModal${blog.id}" tabindex="-1" aria-labelledby="deleteBlogModalLabel${blog.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteBlogModalLabel${blog.id}">Xác nhận xóa Blog</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Bạn có chắc chắn muốn xóa Blog "${blog.title}" không?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <a href="manageblog?action=delete&id=${blog.id}" class="btn btn-danger">Xóa</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>


        <!-- Offcanvas menu -->
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
        <c:set var="n" value="${currentPage}"/>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item ${p == n ? 'active' : ''}">
                    <a class="page-link" href="manageblog?action=list&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>

    </body>

</body>
</html>
