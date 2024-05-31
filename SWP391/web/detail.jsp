<%-- 
    Document   : Item
    Created on : Feb 28, 2024, 8:05:15 PM
    Author     : anhdo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Item detail</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/item.css" rel="stylesheet" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        
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
                                        <a class="dropdown-item" href="logout">
                                            Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </div>


                            <a class="btn btn-square bg-white rounded-circle cart" href="actioncustomer?action=cart">
                                <div class="cart-count">${countfood}</div>
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
                                <div class="cart-count">${countfood}</div>
                                <i class="fa fa-shopping-bag text-body"></i>
                            </a>
                        </form>
                    </c:if>
                </div>
            </div>
        </nav>

        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6">
                        <table border="1">

                            <tbody>
                                <tr>
                                    <td><img class="card-img-top mb-5 mb-md-0" src="${detail.image}" alt="..." /></td>
                                </tr>
                            </tbody>
                        </table>


                    </div>
                    <div class="col-md-6">
                        <h1 class="display-5 fw-bolder">${detail.foodName}</h1>
                        <div>
                            <h4> <span>Giá bán: ${detail.price}00đ</span></h4>
                        </div>
                        <p class="lead">Số lượng: ${detail.stock}</p>
                        <p class="lead">Đã bán: ${detail.sold}</p>
                        <div class="d-flex">
                            <button class="btn btn-outline-dark flex-shrink-0" type="button">
                                <a href=" add-to-cart?id=${detail.foodId}&detail=${detail.foodId}">
                                    <i class="bi-cart-fill me-1"></i>
                                    Add to Cart
                                </a>
                            </button>
                        </div>
                    </div>
                </div>       
                <p></p>
                <div> <a href="actioncustomer?action=getListFood" class="btn btn-primary">Back to home</a></div>
            </div>
        </section>
        <hr>
        <section class="py-5 bg-light">

            <div class="container px-4 px-lg-5 mt-5">

                <h2 class="fw-bolder mb-4">Sản phẩm tương tự</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach items="${sameF}" var="s">
                        <div class="col mb-5">
                            <div class="card h-100">
                                <!-- Product image-->
                                <img class="card-img-top" src="${s.image}" alt="..." />
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder"><a href="detail?foodId=${s.foodId}" title="Views Food">${s.foodName}</a></h5>
                                        <!-- Product price-->
                                        <div >${s.price}00đ</div>
                                    </div>
                                </div>
                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">                                 
                                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Thêm vào giỏ hàng</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>      



                </div>
            </div>
        </section>
        <!-- Footer-->
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
