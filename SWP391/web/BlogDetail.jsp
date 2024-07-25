<%-- 
    Document   : blog
    Created on : Jun 16, 2024, 5:02:30 AM
    Author     : admin
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <style>
            .about-img {
                position: -webkit-sticky; /* For Safari */
                position: sticky;
                top: 0;
                z-index: 1000;
                background-color: white; /* Màu nền để tránh chồng hình ảnh lên nội dung khác */
            }
            .about-section {
                padding-top: 20px;
            }
        </style>

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
                                            <div class="cart-count">${count_cart}</div>
                                            <i class="fa fa-shopping-bag text-body"></i>
                                        </a>
                                </form>
                            </c:if>
                        </div>
                    </div>
            </nav>
        </div>
        <!-- Navbar End -->


        <!-- Page Header Start -->
        <div class="container-fluid page-header wow fadeIn" data-wow-delay="0.1s">
            <div class="container">
                <h1 class="display-3 mb-3 animated slideInDown">Blog Detail</h1>
                <nav aria-label="breadcrumb animated slideInDown">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a class="text-body" href="#">Home</a></li>
                        <li class="breadcrumb-item"><a class="text-body" href="#">Pages</a></li>
                        <li class="breadcrumb-item text-dark active" aria-current="page">Blog</li>
                    </ol>
                </nav>
            </div>
        </div>
        <!-- Page Header End -->
        <!-- Blog Start -->

        <!-- Blog End -->
        <div>
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="row g-5">
                        <div class="col-lg-6 wow fadeIn about-img" data-wow-delay="0.1s">
                            <div class="position-relative overflow-hidden p-5 pe-0">
                                <img class="img-fluid w-100" src="${blogDetail.imagePath}" alt="About Us">
                            </div>
                        </div>
                        <div class="col-lg-6 wow fadeIn about-section" data-wow-delay="0.5s">
                            <h1 class="display-5 mb-4">${blogDetail.title}</h1>


                            <h2 class="mb-3">Tác Giả: ${blogDetail.author}</h2>
                            <p class="mb-4">${blogDetail.content}</p>


                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h1 class="fw-bold text-primary mb-4">F<span class="text-secondary">oo</span>dy</h1>
                        <p>Diam dolor diam ipsum sit. Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit.</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-square btn-outline-body me-0" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-light mb-4">Address</h5>
                        <p><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                        <p><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                        <p><i class="fa fa-envelope me-3"></i>info@example.com</p>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-light mb-4">Quick Links</h5>
                        <a class="btn btn-link" href="">About Us</a>
                        <a class="btn btn-link" href="">Contact Us</a>
                        <a class="btn btn-link" href="">Our Services</a>
                        <a class="btn btn-link" href="">Terms & Condition</a>
                        <a class="btn btn-link" href="">Support</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-light mb-4">Newsletter</h5>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                            <input class="form-control border-primary w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                            <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.

                            <!-- This template is free as long as you keep the footer author’s credit link. -->
                            Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="">Home</a>
                                <a href="">Cookies</a>
                                <a href="">Help</a>
                                <a href="">FQAs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top pt-2"><i class="fa fa-angle-double-up"></i></a>


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
