<%-- 
    Document   : Home
    Created on : May 20, 2024, 7:23:39 PM
    Author     : Dell
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="currentHour" value="<%= java.time.LocalTime.now().getHour() %>"/>
<c:set var="isOpen" value="${currentHour ge 0 && currentHour lt 24}"/>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>

        <title>Trang chủ</title>
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
            .cart{
                position: relative;
            }
            .cart-count{
                background-color: orange;
                position: absolute;
                top: -8px;
                right: -5px;
                color: white;
                width: 20px;
                border-radius: 50%;
                height: 20px;
                line-height: 20px;
                text-align: center;
            }
            .text-danger.strikethrough {
                text-decoration: line-through;
            }


        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh;">

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <div class="container">
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

                <div>
                    <!-- da dang nhap -->
                    <c:if test="${acc!=null}">
                        <form class="d-flex" action="actioncustomer" method="get">
                            <input type="hidden" name="action" value="getFoodBySearch">
                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                   style="width: 300px">
                            <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                <i class="fa fa-search text-body"></i>
                            </button>

                            <div class="dropdown ">
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


                            <a class="btn btn-square bg-white rounded-circle cart" href="actioncustomer?action=cart">
                                <div class="cart-count">${count_cart}</div>
                                <i class="fa fa-shopping-bag text-body"></i>
                            </a>
                        </form>
                    </c:if>
                    <!-- chua dang nhap -->    
                    <c:if test="${acc==null}">
                        <form class="d-flex" action="actioncustomer" method="get">
                            <input type="hidden" name="action" value="getFoodBySearch">
                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                   style="width: 300px">
                            <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                <i class="fa fa-search text-body"></i>
                            </button>
                            <a class="btn btn-square bg-white rounded-circle me-2" href="login">
                                <i class="fa fa-user text-body"></i>
                            </a>
                            <a class="btn btn-square bg-white rounded-circle cart" href="actioncustomer?action=cart">
                                <div class="cart-count">${count_cart}</div>
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
                            <a class="nav-link" href="actioncustomer?action=getListFood" style="font-size: 16px;">Trang chủ</a>
                        </li>
                        <li class="nav-item dropdown">
                            <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                Thể loại</button>
                            <ul class="dropdown-menu">
                                <c:forEach var="c" items="${cList}">
                                    <li><a class="dropdown-item" 
                                           href="actioncustomer?action=getFoodByCategory&&cid=${c.category_id}">${c.category_name}</a></li>
                                    </c:forEach>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                Sắp xếp</button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item ${type eq "1"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=1">Theo tên (A -> Z)</a></li>
                                <li><a class="dropdown-item ${type eq "2"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=2">Theo tên (Z -> A)</a></li>
                                <li><a class="dropdown-item ${type eq "3"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=3">Giá tăng dần</a></li>
                                <li><a class="dropdown-item ${type eq "4"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=4">Giá giảm đần</a></li>
                                <li><a class="dropdown-item ${type eq "5"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=5">Ngày thêm vào mới nhất</a></li>
                                <li><a class="dropdown-item ${type eq "6"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=6">Ngày thêm vào cũ nhất</a></li>
                                <li><a class="dropdown-item ${type eq "7"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=7">Số lượng đã bán nhiều</a></li>
                                <li><a class="dropdown-item ${type eq "8"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=8">Số lượng đã bán ít</a></li>
                                <li><a class="dropdown-item ${type eq "9"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=9">Số lượng tồn kho nhiều</a></li>
                                <li><a class="dropdown-item ${type eq "10"?"active":""}" 
                                       href="actioncustomer?action=homeSort&&type=10">Số lượng tồn kho ít</a></li>
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
                                <c:if test="${f.dicountRate == 0}">
                                    <p>Giá: <span class="text-danger fw-bold">
                                            <fmt:formatNumber type="currency" 
                                                              currencyCode="VND"
                                                              maxFractionDigits="0"
                                                              value="${f.price}">
                                            </fmt:formatNumber>
                                        </span></p>
                                    </c:if>
                                    <c:if test="${f.dicountRate != 0}">
                                    <p>Giảm giá: <span class="text-danger fw-bold">
                                            <fmt:formatNumber type="currency" 
                                                              currencyCode="VND"
                                                              maxFractionDigits="0"
                                                              value="${f.price - f.price * f.dicountRate/100}" >
                                            </fmt:formatNumber>
                                        </span></p>
                                    <p>
                                        Giá gốc:

                                        <span class="text-danger fw-bold strikethrough">
                                            <fmt:formatNumber type="currency" 
                                                              currencyCode="VND"
                                                              maxFractionDigits="0"
                                                              value="${f.price}" >
                                            </fmt:formatNumber>
                                        </span></p>
                                    </c:if>
                            </a>
                            <c:choose>
                                <c:when test="${isOpen == true}">
                                    <c:if test="${f.stock == 0}">
                                        <button class="btn btn-danger" 
                                                type="button">Hết hàng</button>
                                    </c:if>
                                    <c:if test="${f.stock > 0}">
                                        <a class="btn btn-success"
                                           onclick="addCart('${f.foodId}', '${page}', '${acc.userid}')"
                                           href="#">
                                            Thêm vào giỏ hàng
                                        </a>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-danger" type="button" disabled>Đã đóng cửa</button>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>                           
        </div>

        <!--        <ul class="pagination justify-content-center">
        <c:forEach var="p" begin="${1}" end="${totalPages}">
            <li class="page-item">
            <c:if test="${listSearch != null}">
                <a class="page-link ${p==n?"active":""}"  
                   href="actioncustomer?action=getFoodBySearch&&page=${p}&&search=${search}">${p}</a>
            </c:if>
            <c:if test="${listFoodByCategory != null}">
                <a class="page-link ${p==n?"active":""}"  
                   href="actioncustomer?action=getFoodByCategory&&page=${p}&&cid=${cid}">${p}</a>
            </c:if>
            <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                <a class="page-link ${p==n?"active":""}"  
                   href="actioncustomer?action=getListFood&&page=${p}">${p}</a>
            </c:if>
            <c:if test="${listSort != null}">
                <a class="page-link ${p==n?"active":""}"  
                   href="actioncustomer?action=homeSort&&page=${p}&&type=${type}">${p}</a>
            </c:if>
        </li>
        </c:forEach>
    </ul>-->
        <!-- phân trang moi-->
        <ul class="pagination justify-content-center">
            <c:if test="${totalPages > 1}">
                <li class="page-item">
                    <c:if test="${listSearch != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actioncustomer?action=getFoodBySearch&&page=1&&search=${search}">1</a>
                    </c:if>
                    <c:if test="${listFoodByCategory != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actioncustomer?action=getFoodByCategory&&page=1&&cid=${cid}">1</a>
                    </c:if>
                    <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actioncustomer?action=getListFood&&page=1">1</a>
                    </c:if>
                    <c:if test="${listSort != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actioncustomer?action=homeSort&&page=1&&type=${type}">1</a>
                    </c:if>
                </li>
                <c:if test="${currentPage > 3}">
                    <li class="page-item">
                        <span class="page-link">...</span>
                    </li>
                </c:if>
                <c:forEach var="p" begin="${currentPage-1}" end="${currentPage+1}">
                    <c:if test="${p > 1 && p < totalPages}">
                        <li class="page-item">
                            <c:if test="${listSearch != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actioncustomer?action=getFoodBySearch&&page=${p}&&search=${search}">${p}</a>
                            </c:if>
                            <c:if test="${listFoodByCategory != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actioncustomer?action=getFoodByCategory&&page=${p}&&cid=${cid}">${p}</a>
                            </c:if>
                            <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actioncustomer?action=getListFood&&page=${p}">${p}</a>
                            </c:if>
                            <c:if test="${listSort != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actioncustomer?action=homeSort&&page=${p}&&type=${type}">${p}</a>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${currentPage < totalPages - 2}">
                    <li class="page-item">
                        <span class="page-link">...</span>
                    </li>
                </c:if>
                <li class="page-item">
                    <c:if test="${listSearch != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actioncustomer?action=getFoodBySearch&&page=${totalPages}&&search=${search}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actioncustomer?action=getFoodByCategory&&page=${totalPages}&&cid=${cid}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actioncustomer?action=getListFood&&page=${totalPages}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listSort != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actioncustomer?action=homeSort&&page=${totalPages}&&type=${type}">${totalPages}</a>
                    </c:if>
                </li>
            </c:if>
        </ul>



        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
    <script>
        function addCart(id, page, user) {
            console.log("id", id)
            console.log("user", page)

            if (user == "") {
                window.location = "login";
            } else {
                window.location = "add-to-cart?id=" + id + "&page=" + page
            }
        }
    </script>
</html>
