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
    <body class="d-flex flex-column" style="min-height: 100vh;">
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

        <div class="flex-grow-1" >
            <section class="order-form m-4">
                <div class="container pt-4">
                    <form action="order" method="POST">
                        <div class="row">
                            <div class="col-12 px-4">
                                <h1>Vui lòng nhập thông tin đơn hàng</h1>

                            </div>




                            <c:if test="${err != null}">
                                <div class="row mt-3 mx-4">
                                    <div class="alert alert-danger">${err}</div>
                                </div>
                            </c:if>
                            <c:if test="${success != null}">
                                <div class="row mt-3 mx-4">
                                    <div class="alert alert-success">${success}</div>
                                </div>
                            </c:if>


                            <div class="row mt-3 mx-4">
                                <div class="col-12">
                                    <label class="order-form-label">Tên khách hàng</label>
                                </div>
                                <div class="col-12">
                                    <div data-mdb-input-init class="form-outline">
                                        <input value="${user.username}" name="name" type="text" id="form3" class="form-control order-form-input" />
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3 mx-4">
                                <div class="col-12">
                                    <label class="order-form-label">Email</label>
                                </div>
                                <div class="col-12">
                                    <div data-mdb-input-init class="form-outline">
                                        <input type="text" id="form4" name="email" value="${user.email}" class="form-control order-form-input" />
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3 mx-4">
                                <div class="col-12">
                                    <label class="order-form-label" for="date-picker-example">Số điện thoại</label>
                                </div>
                                <div class="col-12">
                                    <div data-mdb-input-init class="form-outline datepicker" data-mdb-toggle-button="false">
                                        <input type="text" id="form4" name="phone" value="${user.phone}" class="form-control order-form-input" />
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3 mx-4">
                                <div class="col-12">
                                    <label class="order-form-label">Địa chỉ</label>
                                </div>
                                <div class="col-12">
                                    <div data-mdb-input-init class="form-outline">
                                        <input name="address" type="text" id="form5" class="form-control order-form-input" />

                                    </div>
                                </div>

                            </div>



                            <div class="row mt-3 mx-4">
                                <div class="col-12">
                                    <label class="order-form-label">Chi tiết sản phẩm</label>
                                </div>
                                <div class="col-12">
                                    <div data-mdb-input-init class="form-outline">
                                        <table class="table table-bordered mt-3">
                                            <thead>
                                                <tr>

                                                    <th scope="col">Tên sản phẩm</th>
                                                    <th scope="col">Ảnh sản phẩm</th>
                                                    <th scope="col">Số lượng</th>
                                                    <th scope="col">Giá sản phẩm</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${list != null}">
                                                    <c:forEach items="${list}" var="i"> 
                                                        <tr>
                                                            <td>${i.foodName}</td>
                                                            <td><img src="${i.image}" style="width: 200px;height: 160px; object-fit: cover" alt="alt"/></td>
                                                            <td>${i.quantity}</td>
                                                            <td>${i.price}
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>





                                            </tbody>
                                        </table>

                                    </div>
                                </div>

                            </div>




                            <c:if test="${success != null}">
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <button  type="button" data-mdb-button-init id="btnSubmit" data-mdb-ripple-init class="btn btn-primary d-block mx-auto btn-submit">
                                            <a style="color: white; text-decoration: none" href="actioncustomer?action=getListFood">Về trang chủ</a>
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${success == null}">
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <button  type="submit" data-mdb-button-init id="btnSubmit" data-mdb-ripple-init class="btn btn-primary d-block mx-auto btn-submit">Thanh toán</button>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </form>
                </div>
            </section>
        </div>

        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
