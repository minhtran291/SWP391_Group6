

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
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
            a{
                color: #000
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
                                        <a class="dropdown-item" href="actioncustomer?action=history">
                                            Lịch sử
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="profile">
                                            Hồ sơ
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
        <section class="h-100 h-custom" style="background-color: #eee;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">
                        <div class="card">
                            <div class="card-body p-4">

                                <div class="row">

                                    <div class="col-lg-7">
                                        <h5 class="mb-3"><a href="actioncustomer?action=getListFood" class="text-body"><i
                                                    class="fas fa-long-arrow-alt-left me-2"></i>Tiếp tục mua sắm</a></h5>
                                        <hr>

                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <div>
                                                <p class="mb-1">Giỏ hàng của bạn</p>
                                                <p class="mb-0">Bạn có ${count_cart} sản phẩm trong giỏ hàng</p>
                                            </div>

                                        </div>


                                        <c:if test="${cart == null}">

                                            <div class="alert alert-warning">Bạn không có bất kì sản phẩm nào trong giỏ hàng</div>
                                        </c:if>
                                            
                                        <c:if test="${cart.size() == 0}">

                                            <div class="alert alert-warning">Bạn không có bất kì sản phẩm nào trong giỏ hàng</div>
                                        </c:if>

                                        <c:if test="${err != null}">

                                            <div class="alert alert-danger">${err}</div>
                                        </c:if>
                                            <c:if test="${success != null}">

                                            <div class="alert alert-success">${success}</div>
                                        </c:if>


                                        <c:if test="${cart != null}">

                                            <c:forEach items="${cart}" var="p">
                                                <div class="card mb-3">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div>
                                                                    <img
                                                                        src=${p.image}
                                                                        class="img-fluid rounded-3" alt="Shopping item" style="width: 65px;">
                                                                </div>
                                                                <div class="ms-3">
                                                                    <h5>${p.foodName}</h5>

                                                                </div>
                                                            </div>
                                                            <div class="d-flex flex-row gap-4 align-items-center justify-content-between" style="width: 40%">
                                                                <div class="quantity gap-3 d-flex flex-row align-items-center" style="width: 50px;">
                                                                    <div><a href="add-to-cart?id=${p.foodId}&minus=1"><i class="fa-solid fa-minus"></i></a></div>
                                                                    <h5 class="fw-normal mb-0">${p.quantity}</h5>
                                                                    <div><a href="add-to-cart?id=${p.foodId}&plus=1"><i class="fa-solid fa-plus"></a></i></div>
                                                                </div>
                                                                <div style="width: 80px;">
                                                                    <h5 class="mb-0">${p.price} VND</h5>
                                                                </div>
                                                                <a href="delete-cart?id=${p.foodId}" style="color: #cecece;"><i class="fas fa-trash-alt"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:forEach>
                                        </c:if>











                                    </div>
                                    <div class="col-lg-5">

                                        <div class="card bg-primary text-white rounded-3">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h5 class="mb-0">Thanh Toán</h5>
                                                   
                                                </div>



                                                <form class="mt-4" action="order">
                                                   



                                               

                                                <hr class="my-4">



                                                <div class="d-flex justify-content-between mb-4">
                                                    <p class="mb-2">Tổng thanh toán</p>
                                                    <p class="mb-2">${total_s} VND</p>
                                                </div>

                                                <c:if test="${cart != null}">
                                                    <button  type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-block btn-lg">
                                                       Tiếp tục
                                                    </button>
                                                </c:if>
                                                
                                                <c:if test="${cart.size() == 0}">
                                                    <button  type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-block btn-lg">
                                                       Tiếp tục
                                                    </button>
                                                </c:if>
                                             </form>
                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </body>
</html>
