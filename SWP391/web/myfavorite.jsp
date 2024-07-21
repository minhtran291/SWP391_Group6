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

        <title>Sản phẩm đã lưu</title>
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
             .image {
            width: 200px;
            height: 100px;
            overflow: hidden;
       
        }

        .image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Sử dụng cover để ảnh phủ đầy khung chứa mà không bị méo */
        }


      
        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh;">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">



            <div class="container-fluid" style="padding-left: 40px;">
                <ul class="navbar-nav">

                    <li class="nav-item">
                        <c:if test="${sessionScope.acc.roleid==1}">
                            <a class="nav-link" href="actioncustomer?action=getListFood">
                                <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                    F<span style="color: #ff6633">oo</span>dy
                                </h1></a>
                            </c:if>
                            <c:if test="${sessionScope.acc.roleid==2}">
                            <a class="nav-link" href="actionshop?action=homeFood">
                                <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                    F<span style="color: #ff6633">oo</span>dy
                                </h1></a>
                            </c:if>
                    </li>
                </ul>

                <div style="margin-right: 20px">
                    <form class="d-flex" action="actionshop?action=homeFood" method="get">
                        <input type="hidden" name="action" value="getFoodBySearch">
                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                               style="width: 300px">
                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                            <i class="fa fa-search text-body"></i>
                        </button>

                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu">
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
                                <li><a class="dropdown-item" href="managefavorite?action=viewfavorite">Sản phẩm đã lưu</a></li>
                                <li>
                                    <a class="dropdown-item" href="managefavorite?action=viewfavorite">
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


                        <a class="btn btn-square bg-white rounded-circle" href="">
                            <i class="fa fa-shopping-bag text-body"></i>
                        </a>
                    </form>
                </div>
            </div>
        </nav>



        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">

            <div class="d-flex bg-light mb-5">
                <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="actionshop?action=homeFood" style="font-size: 16px;">Trang chủ</a>
                        </li>

                    </ul>
                </div>
            </div>

            <h1 class="text-center m-3">Sản phẩm đã lưu</h1>



            <table class="table text-center">
                <tr>

                    <th>Tên</th>
                    <th>Ảnh</th>                   
                    <th></th>
                </tr>
                <c:forEach var="f" items="${FavoriteOnCurrentPage}">
                    <tr style="vertical-align: middle">
             
                        <td>${f.foodName}</td>             
                        <td><img class=" image" src="${f.image}" alt="Image"></td>             
                        <td><a href="detail?action=detail&foodId=${f.foodId}">Chi tiết</a></td> 

                        <td>
                           
                            <a class="btn btn-lg" 
                               href="managefavorite?action=deleteFood&&deleteId=${f.wishid}&&page=${n}"
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
                       href="managefavorite?action=viewfavorite&&page=${p}">${p}</a>
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
