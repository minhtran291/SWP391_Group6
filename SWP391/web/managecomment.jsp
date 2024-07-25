<%-- 
    Document   : manageFood
    Created on : May 24, 2024, 9:30:43 PM
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <title>Quản lí bình luận</title>
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



            <div class="container-fluid" style="padding-left: 40px;">
                <ul class="navbar-nav">

                    <li class="nav-item">
                        <c:if test="${sessionScope.acc.roleid==1}">
                            <a class="nav-link" href="home">
                                <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                    F<span style="color: #ff6633">oo</span>dy
                                </h1></a>
                            </c:if>
                            <c:if test="${sessionScope.acc.roleid==2}">
                            <a class="nav-link" href="actionshop?action=dashboard">
                                <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                    F<span style="color: #ff6633">oo</span>dy
                                </h1></a>
                            </c:if>
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
                                    <c:if test="${sessionScope.acc.roleid==1}">
                                        <a class="dropdown-item" href="profile">
                                            Hồ sơ
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.acc.roleid==2}">
                                        <a class="dropdown-item" href="actionshop?action=profile">
                                            Hồ sơ
                                        </a>
                                    </c:if>

                                </li>
                                <li>
                                    <a class="dropdown-item" href="actioncustomer?action=history">
                                        Đơn hàng
                                    </a>
                                </li>
                                <li><a class="dropdown-item" href="managefavorite?action=viewfavorite">Sản phẩm đã lưu</a></li>
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


                        <a class="btn btn-square bg-white rounded-circle" href="actioncustomer?action=cart">
                            <i class="fa fa-shopping-bag text-body"></i>
                        </a>
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

                    </ul>
                </div>
            </div>-->

            <h1 class="text-center m-3">Lich sử bình luận</h1>



            <table class="table text-center">
                <tr>

                    <th>Bình luận</th>
                    <th>Thời gian</th>
                    <th>Xem chi tiết</th>
                    <th>Tùy chọn</th>
                </tr>
                <c:forEach var="f" items="${cmtOnCurrentPage}">
                    <tr style="vertical-align: middle">

                        <td>${f.commentText}</td>
                        <td>${f.createDate}</td>             
                        <td><a href="detail?action=detail&foodId=${f.foodId}">Chi tiết</a></td> 

                        <td>
                            <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateEmployee${f.commentId}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>
                            <div class="modal fade text-start" id="updateEmployee${f.commentId}">
                                <div class="modal-dialog modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Cập nhật bình luận</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">    
                                            <form action="managecomment" method="post">
                                                <input type="hidden" name="action" value="updateCmt">
                                                <input type="hidden" name="page" value="${n}">


                                                <b>ID:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       readonly=""
                                                       value="${f.commentId}"
                                                       name="cmtId"
                                                       >
                                                <b>Bình luận:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       value="${f.commentText}"
                                                       required=""
                                                       name="comment"
                                                       >


                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a class="btn btn-lg" 
                               href="managecomment?action=deleteCmt&&deleteId=${f.commentId}&&page=${n}"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa không ?')">
                                <i class="fa-solid fa-trash-can"></i>
                            </a>
                        </td>
                    </c:forEach>
            </table>
        </div>




        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="managecomment?action=viewcomment&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>


        <footer>
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
        </footer>


        <script>
            var errorName = "${requestScope.errorName}";
            var errorEmail = "${requestScope.errorPrice}";
            var errorphone = "${requestScope.errorStock}";
            if (errorName.trim() !== "" || errorEmail.trim() !== "" || errorphone.trim() !== "") {
                $(document).ready(function () {
                    $('#addEmployee').modal('show');
                });
            }
            var errorNameUpdate = "${requestScope.errorNameUpdate}";
            var errorEmailUpdate = "${requestScope.errorEmailUpdate}";
            var errorphoneUpdate = "${requestScope.errorphoneUpdate}";
            if (errorNameUpdate.trim() !== "" || errorerrorEmailUpdate.trim() !== "" || errorphoneUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateEmployee${id}').modal('show');
                });
            }
        </script>
    </body>
</html>
