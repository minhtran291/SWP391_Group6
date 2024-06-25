<%-- 
    Document   : shopHome
    Created on : May 24, 2024, 11:41:33 AM
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
        <title>Shop</title>
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
                        <a class="nav-link" href="home">
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
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="actionshop?action=profile">
                                            Hồ sơ
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="logout">
                                            Đăng xuất
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="managecomment?action=viewcomment">
                                            Xem lại bình luận
                                        </a>
                                    </li>
                                </ul>
                            </div>



                            <a class="btn btn-square bg-white rounded-circle" href="">
                                <i class="fa fa-shopping-bag text-body"></i>
                            </a>
                        </form>

                    </c:if>
                    
                </div>
            </div>
        </nav>

        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1" >
            <div class="d-flex bg-light mb-5">
                <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="actionshop?action=homeFood" style="font-size: 16px;">Trang chủ</a>
                        </li>
                        <li class="nav-item dropdown">
                            <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                Thể loại</button>
                            <ul class="dropdown-menu">
                                <c:forEach var="c" items="${cList}">
                                    <li><a class="dropdown-item" 
                                           href="actionshop?action=getFoodByCategory&&cid=${c.category_id}">${c.category_name}</a></li>
                                    </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="container">
                <ul class="list-unstyled d-flex flex-wrap justify-content-center">
                    <c:forEach var="f" items="${foodOnCurrentPage}">
                        <li class="m-3 border rounded-1 border-dark text-center">
                            <a class="text-decoration-none" href="detail?action=detail&foodId=${f.foodId}">
                                <img src="${f.image}" class="img-fluid" 
                                     style="width: 250px; height: 210px" alt="${f.foodName}"/>
                                <p class="text-muted fw-bold fs-5">${f.foodName}</p>
                                <p>Giá: <span class="text-danger fw-bold">
                                        <fmt:formatNumber type="currency" 
                                                          currencyCode="VND"
                                                          maxFractionDigits="0"
                                                          value="${f.price}">
                                        </fmt:formatNumber>
                                    </span></p>
                            </a>
                            <c:if test="${f.stock == 0}">
                                        <button class="btn btn-danger" 
                                                type="button">Hết hàng</button>
                                    </c:if>
                                    <c:if test="${f.stock > 0}">
                                        <a class="btn btn-primary"
                                           href="#">
                                            Thêm vào giỏ hàng
                                        </a>
                                    </c:if>    
                        </li>
                    </c:forEach>
                </ul>
            </div> 
        </div>

        <!-- sidebar -->
        <div class="offcanvas offcanvas-start text-bg-dark" id="demo">
            <div class="offcanvas-header">
                <h1 class="offcanvas-title">Quản lí cửa hàng</h1>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=manageFood">
                        Quản lí sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" href="CategoryServlet?action=manageCategory">
                        Quản lí thể loại sản phẩm</a></p>
                         <p><a class="btn text-white btn-primary" href="actionshop?action=all-order">Quản lí đơn hàng</a></p>
                <p><a class="btn text-white btn-primary">Quản lí đơn hàng</a></p>
                <p><a href="employee?action=manageEmp"
                        class="btn text-white btn-primary">Quản lí nhân viên</a></p>
                <p><a class="btn text-white btn-primary">Phân đơn hàng</a></p>
            </div>
        </div>



        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <c:if test="${listSearch != null}">
                        <a class="page-link ${p==n?"active":""}"  
                       href="actionshop?action=getFoodBySearch&&page=${p}&&search=${search}">${p}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory != null}">
                        <a class="page-link ${p==n?"active":""}"  
                       href="actionshop?action=getFoodByCategory&&page=${p}&&cid=${cid}">${p}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory == null && listSearch == null}">
                        <a class="page-link ${p==n?"active":""}"  
                       href="actionshop?action=homeFood&&page=${p}">${p}</a>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
