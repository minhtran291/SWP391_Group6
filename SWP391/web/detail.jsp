<!DOCTYPE html>
<html lang="en">

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <c:set var="currentHour" value="<%= java.time.LocalTime.now().getHour() %>"/>
    <c:set var="isOpen" value="${currentHour ge 6 && currentHour lt 24}"/>
    <head>
        <meta charset="utf-8">
        <title>Shop Detail</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">  

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate_detail/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel_detail/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style_detail.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
    </head>
    <style>
        .custom-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.775rem;
        }
        .image {
            width: 550px;
            height: 350px;
            overflow: hidden;
            display: flex;
        }

        .image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Sử dụng cover để ảnh phủ đầy khung chứa mà không bị méo */
        }


        .imagesame img {
            width: 350px;
            height: 250px;
            object-fit: cover; /* Sử dụng cover để ảnh phủ đầy khung chứa mà không bị méo */
            display: flex;
        }
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

        .navbar-custom {
            background-color: #212529; /* Custom black background */
        }
        .btn-spacing {
            margin-right: 0.5rem; /* Adjust the margin as needed */
        }
        .footer-custom {
            background-color: #212529; /* Custom dark background for footer */
        }
        .saved-message {
            display: none;
            color: green;
            margin-top: 10px;
        }
        .text-danger.strikethrough {
            text-decoration: line-through;
        }
    </style>
</head>
<body class="d-flex flex-column" style="min-height: 100vh;">
    <nav class="navbar navbar-expand-sm navbar-dark navbar-custom">
        <div class="container">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="actioncustomer?action=getListFood">
                        <h1 class="fw-bold" style="font-family: Florence, cursive;
                            color: #33cc00">
                            F<span style="color: #ff6633">oo</span>dy
                        </h1>
                    </a>
                </li>
            </ul>

            <div>
                <form class="d-flex" action="actioncustomer" method="get">
                    <input type="hidden" name="action" value="getFoodBySearch">
                    <input class="form-control me-2 btn-spacing" type="text" placeholder="Tìm kiếm" name="search" style="width: 300px">
                    <button class="btn btn-square bg-white rounded-circle btn-spacing" type="submit">
                        <i class="fa fa-search text-body"></i>
                    </button>

                    <div class="dropdown btn-spacing">
                        <button type="button" class="btn btn-square bg-white rounded-circle dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-user text-body"></i>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="profile">Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="actioncustomer?action=history">Đơn hàng</a></li>
                            <li><a class="dropdown-item" href="managecomment?action=viewcomment">Xem lại bình luận</a></li>
                            <li><a class="dropdown-item" href="managefavorite?action=viewfavorite">Sản phẩm đã lưu</a></li>
                            <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                        </ul>
                    </div>

                    <a class="btn btn-square bg-white rounded-circle cart btn-spacing" href="actioncustomer?action=cart">
                        <div class="cart-count">${count_cart}</div>
                        <i class="fa fa-shopping-bag text-body"></i>
                    </a>
                </form>
            </div>
        </div>
    </nav>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    <br>
    <!-- Breadcrumb Start -->
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-12">
                <nav class="breadcrumb bg-light mb-30">
                    <c:if test="${sessionScope.acc.roleid==1}">
                        <a class="breadcrumb-item text-dark" href="actioncustomer?action=getListFood">Trang chủ</a>
                    </c:if>
                    <c:if test="${sessionScope.acc.roleid==2}">
                        <a class="breadcrumb-item text-dark" href="actionshop?action=homeFood">Trang chủ</a>
                    </c:if>
                    <c:if test="${sessionScope.acc.roleid==null}">
                        <a class="breadcrumb-item text-dark" href="actioncustomer?action=getListFood">Trang chủ</a>
                    </c:if>
                    <span class="breadcrumb-item active">Chi tiết sản phẩm</span>
                </nav>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->


    <!-- Shop Detail Start -->
    <div class="container-fluid pb-5">
        <div class="row px-xl-5">
            <div class="col-lg-5 mb-30">
                <div id="product-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner bg-light">
                        <div class="carousel-item active">
                            <img class=" image" src="${img1.image}" alt="Image">
                        </div>
                        <div class="carousel-item">
                            <img class=" image" src="${img2.image}" alt="Image">
                        </div>
                        <div class="carousel-item">
                            <img class="image" src="${img3.image}" alt="Image">
                        </div>

                    </div>
                    <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                        <i class="fa fa-2x fa-angle-left text-dark"></i>
                    </a>
                    <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                        <i class="fa fa-2x fa-angle-right text-dark"></i>
                    </a>
                </div>

            </div>

            <div class="col-lg-7 h-auto mb-30">
                <div class="h-100 bg-light p-30">
                    <h3>${detail.foodName}</h3>
                    <!-- <div class="d-flex mb-3">
                         <div class="text-primary mr-2">
                             <small class="fas fa-star"></small>
                             <small class="fas fa-star"></small>
                             <small class="fas fa-star"></small>
                             <small class="fas fa-star-half-alt"></small>
                             <small class="far fa-star"></small>
                         </div>
                         <small class="pt-1">(99 Reviews)</small>
                     </div>-->
                    <c:if test="${detail.discountRate == 0}">
                    <h3 class="font-weight-semi-bold mb-4"> 

                        <p>Giá gốc:<span class="text-danger fw-bold">
                                <fmt:formatNumber type="currency" 
                                                  currencyCode="VND"
                                                  maxFractionDigits="0"
                                                  value="${detail.price}">
                                </fmt:formatNumber>
                            </span></p> 
                    </h3>
                    </c:if>
                    <c:if test="${detail.discountRate != 0}">
                    <h3 class="font-weight-semi-bold mb-4"> 
                        
                        <p>Giảm giá:<span class="text-danger fw-bold">
                                <fmt:formatNumber type="currency" 
                                                  currencyCode="VND"
                                                  maxFractionDigits="0"
                                                  value="${detail.price - detail.price*detail.discountRate/100}">
                                </fmt:formatNumber>
                            </span></p> 
                        <p>Giá gốc: <span class="text-danger fw-bold strikethrough">
                                <fmt:formatNumber type="currency" 
                                                  currencyCode="VND"
                                                  maxFractionDigits="0"
                                                  value="${detail.price}" >
                                </fmt:formatNumber>
                            </span></p>
                    </h3>
                    </c:if>

                    <p class="mb-2">Số lượng: ${detail.stock}</p>
                    <p class="mb-2">Đã bán: ${detail.sold}</p>

                    <c:if test="${isOpen}">
                        <div class="d-flex align-items-center mb-4 pt-2">

                            <a class="btn btn-primary"
                               href="add-to-cart?id=${detail.foodId}"> <!--&page=${page}-->
                                Thêm vào giỏ hàng
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${isOpen == false}">
                        <div class="d-flex align-items-center mb-4 pt-2">
                            <a class="btn btn-danger"> 
                                Đã đóng cửa
                            </a>
                        </div>
                    </c:if>
                    <form action="detail?action=save&foodId=${detail.foodId}" method="post">

                        <input type="hidden" name="foodId" class="far fa-heart" value="${detail.foodId}">
                        <input type="hidden" name="foodname" class="far fa-heart" value="${detail.foodName}">
                        <input type="hidden" name="image" class="far fa-heart" value="${img1.image}">
                        <c:if test="${sessionScope.acc==null}">
                            <a href="login" class="btn btn-outline-dark btn-square" > <i class="far fa-heart">

                                </i>  </a>
                            </c:if>
                            <c:if test="${sessionScope.acc!=null}">

                            <button type="submit" class="btn btn-outline-dark btn-square" ><i class="far fa-heart"></i></button>

                        </c:if> 


                    </form>
                </div>
            </div>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="bg-light p-30">
                    <div class="nav nav-tabs mb-4">
                        <a class="nav-item nav-link text-dark active" data-toggle="tab" href="#tab-pane-1">Mô tả </a>
                        <a class="nav-item nav-link text-dark" data-toggle="tab" href="#tab-pane-3">Đánh giá</a>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="tab-pane-1">
                            <h4 class="mb-3">Mô tả sản phảm</h4>
                            <p>${detail.description}</p>
                        </div>

                        <div class="tab-pane fade" id="tab-pane-3">
                            <div class="row">
                                <div class="col-md-5">
                                    <h4 class="mb-4">Đánh giá của "${detail.foodName}"</h4>                                 
                                    <div class="media mb-4">

                                        <div class="media-body">
                                            <c:forEach var="list" items="${listcmt}" > 

                                                <h6><div  name="cmtId" >${list.userName}<small> - <i>${list.createDate}</i>
                                                        </small></div>

                                                </h6>

                                                <p>${list.commentText}</p>

                                            </c:forEach>
                                        </div>

                                    </div>

                                </div>



                                <div class="col-md-5">
                                    <h4 class="mb-4">Đánh giá của bạn</h4>
                                    <c:if test="${sessionScope.acc==null}">
                                        <a class="btn btn-primary"
                                           href="login">
                                            Bạn cần đăng nhập trước
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.acc!=null}">
                                        <form action="detail?action=send&foodId=${detail.foodId}" method="post">

                                            <div class="form-group">
                                                <!--                                                <h5><b> <label for="name">Đánh giá: </label></b></h5>
                                                                                                <h2>  <div class="star-rating my-0">
                                                                                                        <input type="radio" id="5-stars" name="rating" value="5" />
                                                                                                        <label for="5-stars" class="star">&#9733;</label>
                                                                                                        <input type="radio" id="4-stars" name="rating" value="4" />
                                                                                                        <label for="4-stars" class="star">&#9733;</label>
                                                                                                        <input type="radio" id="3-stars" name="rating" value="3" />
                                                                                                        <label for="3-stars" class="star">&#9733;</label>
                                                                                                        <input type="radio" id="2-stars" name="rating" value="2" />
                                                                                                        <label for="2-stars" class="star">&#9733;</label>
                                                                                                        <input type="radio" id="1-stars" name="rating" value="1" />
                                                                                                        <label for="1-stars" class="star">&#9733;</label>
                                                                                                    </div></h2>-->
                                                <h5><b> <label for="name">Bình luận: </label></b></h5>
                                                <h3 name="username"></h3>
                                                <textarea required name="content" rows="5" cols="60" onclick="moveCursorToStart()"></textarea>

                                                <div class="form-group mb-0">
                                                    <input type="submit" value="Gửi đánh giá">
                                                    <input type="hidden" name="foodId" value="${detail.foodId}"> 
                                                </div>

                                            </div>
                                        </form>   
                                    </c:if>
                                </div>
                            </div>       
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Shop Detail End -->



<!-- Products Start -->
<div class="container-fluid py-5">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-white pr-3">Sản phẩm tương tự</span></h2>
    <div class="row px-xl-5">

        <div class="col">
            <div class="owl-carousel related-carousel">

                <c:forEach var="s" items="${sameF}">

                    <div class="product-item bg-light">
                        <div class="product-img position-relative overflow-hidden">
                            <div class="imagesame">
                                <img class="img-fluid w-100" src="${s.image}" alt="">
                            </div>
                            <div class="product-action">
                                <a class="btn btn-outline-dark btn-square" href="detail?action=detail&foodId=${s.foodId}"><i class="fa fa-shopping-cart"></i></a>
                                <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                            </div>
                        </div>
                        <div class="text-center py-4">

                            <a class="h6 text-decoration-none text-truncate" href="detail?action=detail&foodId=${s.foodId}">${s.foodName}</a>
                            <div class="d-flex align-items-center justify-content-center mt-2">
                                <h5><div >
                                        <fmt:formatNumber type="currency"
                                                          currencyCode="VND"
                                                          maxFractionDigits="0"
                                                          value="${s.price}"/>
                                    </div></h5>
                            </div>
                            <!--  <div class="d-flex align-items-center justify-content-center mb-1">
                                  <small class="fa fa-star text-primary mr-1"></small>
                                  <small class="fa fa-star text-primary mr-1"></small>
                                  <small class="fa fa-star text-primary mr-1"></small>
                                  <small class="fa fa-star text-primary mr-1"></small>
                                  <small class="fa fa-star text-primary mr-1"></small>
                                  <small>(99)</small>
                              </div>-->
                        </div>
                    </div>

                </c:forEach>   
            </div>
        </div>

    </div>
</div>


<!-- Products End -->
<div class="container-fluid text-secondary mt-5 pt-5 footer-custom">
    <div class="row px-xl-5 pt-5">
        <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
            <h5 class="text-secondary text-uppercase mb-4">Liên hệ</h5>
            <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>Thạch Hòa, Thạch Thất, Hà Nội</p>
            <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i> minh291@gmail.com</p>
            <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>0123456789</p>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="row">
                <div class="col-md-4 mb-5">
                    <h5 class="text-secondary text-uppercase mb-4">Liên kết</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Trang chủ</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Giới thiệu</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Sản phẩm</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Giỏ hàng</a>
                        <a class="text-secondary" href="#"><i class="fa fa-angle-right mr-2"></i>Liên hệ</a>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <h5 class="text-secondary text-uppercase mb-4">Tài khoản</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Hồ sơ</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Đăng kí</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Đăng nhập </a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Đổi mật khẩu</a>
                        <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Quên mật khẩu</a>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <h5 class="text-secondary text-uppercase mb-4">Bản tin</h5>
                    <p>Đăng ký để nhận tin tức mới nhất</p>
                    <form action="">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Nhập emain của bạn">
                            <div class="input-group-append">
                                <button class="btn btn-primary">Đăng ký</button>
                            </div>
                        </div>
                    </form>
                    <h6 class="text-secondary text-uppercase mt-4 mb-3">Follow Us</h6>
                    <div class="d-flex">
                        <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a class="btn btn-primary btn-square" href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<!-- Footer End -->

<!-- Back to Top -->
<a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing_detail/easing.min.js"></script>
<script src="lib/owlcarousel_detail/owl.carousel.min.js"></script>

<!-- Contact Javascript File -->
<script src="mail/jqBootstrapValidation.min.js"></script>
<script src="mail/contact.js"></script>

<!-- Template Javascript -->
<script src="js/main.detail.js"></script>
<script>



</script>
</body>

</html>
