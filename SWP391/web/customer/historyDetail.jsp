<%-- 
    Document   : history
    Created on : Jun 18, 2024, 11:40:38 PM
    Author     : hieua
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <title>Lịch sử</title>
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

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <div class="container">
                <ul class="navbar-nav">
                    <!--                    có sự khác nhau trong narbar-nav tự css và sử dụng các class
                                        được định nghĩa sẵn trong bootstrap 5 như d-flex và flex-row-->
                    <li class="nav-item">
                        <a class="nav-link" href="actioncustomer?action=getListFood">
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

                            <div class="dropdown">
                                <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                        data-bs-toggle="dropdown">
                                    <i class="fa fa-user text-body"></i>
                                </button>
                                <ul class="dropdown-menu">
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


                            <a class="btn btn-square bg-white rounded-circle cart" href="">
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
        <h2 class="container my-5">Chi tiết đơn hàng</h2>
        <div class="container mt-5">

            <h5>Người nhận : ${order.name}</h5>
            <h5>Email : ${user.email}</h5>
            <h5>Số điện thoại : ${user.phone}</h5>
            <h5>Địa chỉ : ${address}</h5>
            <h5>Trạng thái đơn hàng : ${order.status_text}</h5>
            <h5>Tổng tiền : <fmt:formatNumber type="currency" 
                              currencyCode="VND"
                              maxFractionDigits="0"
                              value="${order.total}">
                </fmt:formatNumber></h5>
            <h5>Hình thức thanh toán : ${order.payment.paymentType}</h5>
            <h5>Trạng thái thanh toán : ${order.statusPaymentName}</h5>
            <c:if test="${order.shopNotes != null}">
                <h5>Cửa hàng: ${order.shopNotes}</h5>
            </c:if>
            <table class="table table-bordered mt-3 text-center">
                <thead>
                    <tr>

                        <th scope="col">Tên sản phẩm</th>
                        <th scope="col">Ảnh sản phẩm</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Giá sản phẩm</th>

                    </tr>
                </thead>
                <tbody>
                    <c:if test="${hitoryDetailOnCurrentPage != null}">
                        <c:forEach items="${hitoryDetailOnCurrentPage}" var="i"> 
                            <tr style="vertical-align: middle">
                                <td>${i.foodName}</td>
                                <td><img src="${i.image}" style="width: 200px;height: 160px; object-fit: cover" alt="alt"/></td>
                                <td>${i.quantity}</td>
                                <td><fmt:formatNumber type="currency" 
                                                  currencyCode="VND"
                                                  maxFractionDigits="0"
                                                  value="${i.price}">
                                    </fmt:formatNumber>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
            <c:if test="${list == null}">
                <div class="alert alert-warning">Bạn chưa có đơn hàng nào</div>
            </c:if>
        </div>

        <c:set var="n" value="${currentPage}"/>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">
                    <a class="page-link ${p == n?"active":""}" 
                       href="actioncustomer?action=history_detail&&page=${p}&&id=${order.id}">${p}</a>
                </li>
            </c:forEach>
        </ul>

        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
