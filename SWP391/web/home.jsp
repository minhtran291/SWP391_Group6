<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="model.Food"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Foody - Organic Food Website Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Lora:wght@600;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->
<!--    <head>
        <style>
            .btn-transparent {
                background-color: transparent; /* Nền trong suốt */
                border: none; /* Loại bỏ viền nếu có */
                padding: 0; /* Loại bỏ khoảng cách bên trong nếu cần */
            }
            .fa-user-small {
                font-size: 12px; /* Điều chỉnh kích thước theo ý bạn */
            }
        </style>
    </head>-->
    <style>
        .btn-transparent {
            background-color: transparent; /* Nền trong suốt */
            border: none; /* Loại bỏ viền nếu có */
            padding: 0; /* Loại bỏ khoảng cách bên trong nếu cần */
        }

        .fa-user-small {
            font-size: 12px; /* Điều chỉnh kích thước theo ý bạn */
        }
        .img-fluid-123 {
            max-width: 100%;
            height: 200px; /* Điều chỉnh chiều cao theo nhu cầu của bạn */
            object-fit: cover;
        }

        /* Đảm bảo tất cả tên sản phẩm có cùng chiều cao */
        h4.mb-3 {
            height: 50px; /* Điều chỉnh chiều cao theo nhu cầu của bạn */
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        /* Căn chỉnh bổ sung cho container */
        .container-fluid.bg-light.bg-icon {
            padding: 20px;
        }

        /* Căn chỉnh bổ sung cho các thẻ sản phẩm */
        .bg-white.text-center.h-100.p-4.p-xl-5 {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        /* Đảm bảo các nút được căn ở dưới cùng */
        .bg-white.text-center.h-100.p-4.p-xl-5 .btn {
            margin-top: auto;
        }

        /* Tuỳ chọn: Thêm khoảng cách giữa các thẻ sản phẩm */
        .row.g-4 > div {
            margin-bottom: 20px;
        }
        .blog-img-container {
            position: relative;
        }

        .blog-img-container img {
            width: 100%;
            height: 200px; /* Adjust as needed */
            object-fit: cover;
        }

        .blog-title-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.5); /* Dark overlay */
            color: #fff;
            text-align: center;
            padding: 10px;
            text-decoration: none;
        }

        .blog-content {
            background-color: #fff;
        }
    </style>
<!--</head>-->



<!-- Navbar Start -->

<div class="container-fluid-top-bar fixed-top px-0 bg-white ">
    <div class="top-bar row gx-0 align-items-center bg-white">
        <div class="col-lg-6 px-5 text-start">
            <small><i class="fa fa-map-marker-alt me-2"></i>Thạch Hòa, Thạch Thất, Hà Nội</small>
            <small class="ms-4"><i class="fa fa-envelope me-2"></i>foody@gmail.com</small>
        </div>
        <div class="col-lg-6 px-5 text-end">
            <small>Follow us:</small>
            <a class="text-body ms-3" href=""><i class="fab fa-facebook-f"></i></a>
            <a class="text-body ms-3" href=""><i class="fab fa-twitter"></i></a>
            <a class="text-body ms-3" href=""><i class="fab fa-linkedin-in"></i></a>
            <a class="text-body ms-3" href=""><i class="fab fa-instagram"></i></a>
        </div>
    </div>
    <hr class="my-0" />

    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid mx-lg-5">
            <a href="home" class="navbar-brand">
                <h1 class="fw-bold text-primary m-0">F<span class="text-secondary">oo</span>dy</h1>
            </a>
            <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="home" class="nav-item nav-link active">Trang Chủ</a>
                    <a href="about.jsp" class="nav-item nav-link">Giới Thiệu</a>
                    <a href="actioncustomer?action=getListFood" class="nav-item nav-link">Sản Phẩm</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu m-0">
                            <a href="blog" class="dropdown-item">Blog</a>
                            <a href="contact.jsp" class="dropdown-item">Liên Hệ</a>
                        </div>
                    </div>
                    <c:if test="${acc!=null}">
                        <form class="d-none d-lg-flex ms-2 align-items-center">
                            <div class="input-group">
                                <input type="text" class="form-control border-1" placeholder="Tìm kiếm..." aria-label="Tìm kiếm">
                                <button class="btn btn-outline-success" type="submit">
                                    <i class="fa fa-search"></i>
                                </button>



                                <div class="dropdown ">
                                    <button type="button" class="btn-sm-square btn-transparent rounded-circle ms-3" 
                                            data-bs-toggle="dropdown">
                                        <i class="fa fa-user text-body "></i>
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
                                        <li>
                                            <a class="dropdown-item" href="managefavorite?action=viewfavorite">Sản phẩm đã lưu</a>
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
                                <a class="btn-sm-square btn-transparent rounded-circle ms-3" href="actioncustomer?action=cart">
                                    <small class="fa fa-shopping-bag text-body"></small>
                                </a>
                            </div>
                        </form>
                    </c:if>
                    <!-- chua dang nhap -->    
                    <c:if test="${acc==null}">
                        <form class="d-none d-lg-flex ms-2 align-items-center">
                            <div class="input-group">

                                <a class="btn btn-square btn-transparent rounded-circle me-2" href="login">
                                    <i class="fa fa-user text-body"></i>
                                </a>
                                <a class="btn btn-square btn-transparent rounded-circle cart" href="customer/cart.jsp">
                                    <div class="cart-count"></div>
                                    <i class="fa fa-shopping-bag text-body"></i>
                                </a>
                        </form>
                    </c:if>
                </div>
            </div>
    </nav>

</div>

<!-- Navbar End -->


<!-- Carousel Start -->
<div class="container-fluid p-0 mb-5 " >
    <div id="header-carousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="w-100" src="img/carousel-4.jpg" alt="Image">
                <div class="carousel-caption">
                    <div class="container">
                        <div class="row justify-content-start">
                            <div class="col-lg-7">

                                <a href="actioncustomer?action=getListFood" class="btn btn-primary rounded-pill py-sm-3 px-sm-5">Xem</a>
                                <a href="contact.jsp" class="btn btn-secondary rounded-pill py-sm-3 px-sm-5 ms-3">Liên Hệ</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img class="w-100" src="img/carousel-3.jpg" alt="Image">
                <div class="carousel-caption">
                    <div class="container">
                        <div class="row justify-content-start">
                            <div class="col-lg-7">

                                <a href="actioncustomer?action=getListFood" class="btn btn-primary rounded-pill py-sm-3 px-sm-5">Xem</a>
                                <a href="contact.jsp" class="btn btn-secondary rounded-pill py-sm-3 px-sm-5 ms-3">Liên Hệ</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#header-carousel"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
<!-- Carousel End -->

<div class="container-fluid bg-light bg-icon my-5 py-6">
    <div class="container">
        <div class="section-header text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
            <h1 class="display-5 mb-3">Best Seller</h1>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when  test="${not empty listBestSellers}">
                    <c:forEach var="product" items="${listBestSellers}" varStatus="status">
                        <c:if test="${status.index < 6}">
                            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="bg-white text-center h-100 p-4 p-xl-5">
                                    <img class="img-fluid-123 mb-4" src="${product.image}" alt="">
                                    <h4 class="mb-3">${product.foodName}</h4>
                                    <p class="mb-4">${product.description}</p>
                                    <a class="btn btn-outline-primary border-2 py-2 px-4 rounded-pill" href="detail?action=detail&foodId=${product.foodId}">Đặt hàng</a>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:when>

            </c:choose>
        </div>
    </div>
</div>
<!-- Feature End -->


<!-- About Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="row g-5 align-items-center">
            <div class="col-lg-6 ">
                <div class="about-img position-relative overflow-hidden p-5 pe-0">
                    <img class="img-fluid w-100" src="img/about-2.jpg">
                </div>
            </div>
            <div class="col-lg-6 ">
                <h1 class="display-5 mb-4 text-center">Giới Thiệu</h1>
                <h2 class="mb-3">Chào mừng đến với Foody - Thiên Đường Ẩm Thực</h2>
                <p class="mb-4">Tại Foody, chúng tôi tự hào mang đến cho bạn những sản phẩm thực phẩm chất lượng cao, được chọn lọc kỹ càng từ những trang trại tốt nhất. Với tiêu chí "Sạch từ nguồn - Tươi từ đất", chúng tôi cam kết cung cấp thực phẩm an toàn, lành mạnh và bổ dưỡng cho mọi bữa ăn của gia đình bạn.</p>
                <h2 class="mb-3">Sứ Mệnh Của Chúng Tôi</h2>
                <p class="mb-4">Sứ mệnh của Foody là mang lại nguồn thực phẩm hữu cơ tươi ngon, đảm bảo sức khỏe cho người tiêu dùng và bảo vệ môi trường. Chúng tôi tin rằng thực phẩm không chỉ là dinh dưỡng, mà còn là niềm vui và sự gắn kết trong mỗi bữa ăn gia đình.</p>

                <a class="btn btn-primary rounded-pill py-3 px-5 mt-3" href="about.jsp">Đọc thêm</a>
            </div>
        </div>
    </div>
</div>
<!-- About End -->




<!-- Product Start -->
<div class="container-fluid bg-light bg-icon my-5 py-6">
    <div class="container">
        <div class="section-header text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
            <h1 class="display-5 mb-3">Sản phẩm mới</h1>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when  test="${not empty listNewFoods}">
                    <c:forEach var="product" items="${listNewFoods}" varStatus="status">
                        <c:if test="${status.index < 6}">
                            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="bg-white text-center h-100 p-4 p-xl-5">
                                    <img class="img-fluid-123 mb-4" src="${product.image}" alt="">
                                    <h4 class="mb-3">${product.foodName}</h4>
                                    <p class="mb-4">${product.description}</p>
                                    <a class="btn btn-outline-primary border-2 py-2 px-4 rounded-pill" href="detail?action=detail&foodId=${product.foodId}">Đặt hàng</a>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:when>

            </c:choose>
        </div>
    </div>
</div>
<!--Product End -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="section-header text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
            <h1 class="display-5 mb-3">Blog mới nhất</h1>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty listAllBlogsHome}">
                    <c:forEach var="blog" items="${listAllBlogsHome}" varStatus="status">
                        <c:if test="${status.index < 3}">
                            <div class="col-lg-4 col-md-6">
                                <div class="blog-item bg-light rounded overflow-hidden">
                                    <div class="blog-img-container">
                                        <img class="img-fluid" src="${blog.imagePath}" alt="${blog.title}">
                                        <a class="blog-title-overlay" href="blogDetail?blogId=${blog.id}">${blog.title}</a>
                                    </div>
                                    <div class="p-4 blog-content">
                                        <div class="d-flex mb-3">
                                            <small class="me-3"><i class="fa fa-user text-primary me-2"></i>${blog.author}</small>
                                            <small class="me-3"><i class="fa fa-calendar text-primary me-2"></i>${blog.dateCreated}</small>
                                        </div>
                                        <a class="text-uppercase" href="blogDetail?blogId=${blog.id}">Read More <i class="bi bi-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>


<!-- Blog Start -->

<!-- Blog End -->
<!-- Footer Start -->
<div class="container-fluid bg-dark footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h1 class="fw-bold text-primary mb-4">F<span class="text-secondary">oo</span>dy</h1>
                <p>Chào Mừng bạn đã đến với Foody</p>
                <div class="d-flex pt-2">
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-youtube"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-0" href=""><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Địa chỉ</h4>
                <p><i class="fa fa-map-marker-alt me-3"></i>Thạch Hòa, Thạch Thất, Hà Nội</p>
                <p><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                <p><i class="fa fa-envelope me-3"></i>foody@gmail.com</p>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Liên Kết Nhanh</h4>
                <a class="btn btn-link" href="">Giới Thiệu</a>
                <a class="btn btn-link" href="">Liên Hệ</a>
                <a class="btn btn-link" href="">Our Services</a>
                <a class="btn btn-link" href="">Terms & Condition</a>
                <a class="btn btn-link" href="">Support</a>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Newsletter</h4>
                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                <div class="position-relative mx-auto" style="max-width: 400px;">
                    <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                    <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid copyright">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>

</html>
