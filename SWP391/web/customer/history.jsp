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
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="profile">
                                            Hồ sơ
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="actioncustomer?action=getListFood">
                                            Danh sách sản phẩm
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
                            <!--                            <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                                               style="width: 300px">
                                                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                                            <i class="fa fa-search text-body"></i>
                                                        </button>-->
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
        <div class="container mt-5">
            <c:if test="${err != null}">
                <div class="alert alert-danger">${err}</div>
            </c:if>
            <c:if test="${param.err != null}">
                <div class="alert alert-danger">${param.err}</div>
            </c:if>
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th scope="col">Đơn hàng</th>
                        <th scope="col">Địa chỉ</th>
                        <th scope="col">Thời gian</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${hitoryOnCurrentPage != null}">
                        <c:forEach items="${hitoryOnCurrentPage}" var="i" varStatus="index"> 
                            <tr>
                                <td>${i.id}</td>
                                <td>${i.address}</td>
                                <td><fmt:formatDate value="${i.orderDate}" pattern="dd-MM-yyyy"></fmt:formatDate></td>
                                <td>${i.status_text}</td>
                                <td>
                                    <button class="btn btn-primary"><a href="actioncustomer?action=history_detail&id=${i.id}" style="color: white; text-decoration: none">Xem chi tiết</a></button>
                                    <c:if test="${i.status == 1 || i.status == 2}">
                                        <button class="btn btn-danger" type="button" data-bs-toggle="modal" data-bs-target="#myModal${i.id}">Hủy đơn</button>
                                        <div class="modal fade" id="myModal${i.id}">
                                            <div class="modal-dialog">
                                                <div class="modal-content">

                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Nhập lí do</h4>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>

                                                    <div class="modal-body">
                                                        <form action="actioncustomer" method="get">
                                                            <input type="hidden" name="action" value="remove-order"/>
                                                            <input type="hidden" name="id" value="${i.id}"/>
                                                            <input class="form-control" type="text" required="" name="customerNotes" placeholder="Nhập lí do">
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                                <button type="submit" class="btn btn-success" data-bs-dismiss="modal">Gửi</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

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
                       href="actioncustomer?action=history&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>

        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
