<!DOCTYPE html>
<html lang="en">

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }
        .star-rating input[type=radio] {
            display: none;
        }
        .star-rating label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
        }
        .star-rating input[type=radio]:checked ~ label {
            color: #ffca08;
        }
        .star-rating label:hover, .star-rating label:hover ~ label {
            color: #ffca08;
        }
    </style>

    <body>
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark ">           
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
                            <c:if test="${sessionScope.acc==null}">
                            <a class="nav-link" href="actioncustomer?action=getListFood">
                                <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                    F<span style="color: #ff6633">oo</span>dy
                                </h1></a>
                            </c:if>

                    </li>
                </ul>

                <div style="margin-right: 20px">
                    <!-- da dang nhap -->
                    <c:if test="${acc!=null}">
                        <form class="d-flex " action="actionshop" method="get">
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
                                <div class="cart-count">${count_cart}</div>
                                <i class="fa fa-shopping-bag text-body"></i>
                            </a>
                        </form>

                    </c:if>
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
                            <div class="carousel-item ">
                                <img class=" image" src="${img2.image}" alt="Image">
                            </div>
                            <div class="carousel-item  ">
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
                        <h3 class="font-weight-semi-bold mb-4"> <p> <span class="text-danger fw-bold">
                                    <fmt:formatNumber type="currency" 
                                                      currencyCode="VND"
                                                      maxFractionDigits="0"
                                                      value="${detail.price}"></fmt:formatNumber>
                                    <!--<h4> <span>Giá bán: ${detail.price}">-->
                                </span></p></h3>
                        <p class="mb-2">Số lượng: ${detail.stock}</p>
                        <p class="mb-2">Đã bán: ${detail.sold}</p>


                        <div class="d-flex align-items-center mb-4 pt-2">

                            <a class="btn btn-primary"
                               href="add-to-cart?id=${detail.foodId}"> <!--&page=${page}-->
                                Thêm vào giỏ hàng
                            </a>

                        </div>

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

                                                <h6>${cmt1.userName}<small> - <i>${cmt1.createDate}</i></small></h6>

                                                <p>${cmt1.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt2.userName}<small> - <i>${cmt2.createDate}</i></small></h6>

                                                <p>${cmt2.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt3.userName}<small> - <i>${cmt3.createDate}</i></small></h6>

                                                <p>${cmt3.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt4.userName}<small> - <i>${cmt4.createDate}</i></small></h6>

                                                <p>${cmt4.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt5.userName}<small> - <i>${cmt5.createDate}</i></small></h6>

                                                <p>${cmt5.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt6.userName}<small> - <i>${cmt6.createDate}</i></small></h6>

                                                <p>${cmt6.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt7.userName}<small> - <i>${cmt7.createDate}</i></small></h6>

                                                <p>${cmt7.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt8.userName}<small> - <i>${cmt8.createDate}</i></small></h6>

                                                <p>${cmt8.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt9.userName}<small> - <i>${cmt9.createDate}</i></small></h6>

                                                <p>${cmt9.commentText}</p>
                                            </div>

                                        </div>
                                        <div class="media mb-4">

                                            <div class="media-body">
                                                <h6>${cmt10.userName}<small> - <i>${cmt10.createDate}</i></small></h6>

                                                <p>${cmt10.commentText}</p>
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
                                                <!--  <div class="d-flex my-0">
                                                      <p class="mb-5 mr-0">Đánh giá:</p>                                           
                                                      <div class="star-rating">
                                                          <input type="radio" id="5-stars" name="rating" value="5" />
                                                          <label for="5-stars" class="star">&#9733;</label>
                                                          <input type="radio" id="4-stars" name="rating" value="4" />
                                                          <label for="4-stars" class="star">&#9733;</label>
                                                          <input type="radio" id="3-stars" name="rating" value="3" />
                                                          <label for="3-stars" class="star">&#9733;</label>
                                                          <input type="radio" id="2-stars" name="rating" value="2" />
                                                          <label for="2-stars" class="star">&#9733;</label>
                                                          <input type="radio" id="1-star" name="rating" value="1" />
                                                          <label for="1-star" class="star">&#9733;</label>
                                                      </div>
    
                                                  </div>-->

                                                <div class="form-group">
                                                    <label for="name">Bình luận: </label>
                                                    <h3 name="username"></h3>
                                                    <textarea name="content" rows="5" cols="60" onclick="moveCursorToStart()"></textarea>

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
                                    <a class="btn btn-outline-dark btn-square" href=""><i class="fa fa-shopping-cart"></i></a>
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
    <div class="container-fluid bg-dark text-secondary mt-5 pt-5">
        <div class="row px-xl-5 pt-5">
            <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
                <h5 class="text-secondary text-uppercase mb-4">Liên hệ</h5>
                <!-- <p class="mb-4"></p> -->
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
                            <!-- <a class="text-secondary" href="#"><i class="fa fa-angle-right mr-2"></i>Contact Us</a> -->
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