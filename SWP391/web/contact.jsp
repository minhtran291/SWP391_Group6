<%-- 
    Document   : contact
    Created on : Jun 16, 2024, 5:02:58 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
                                    <a href="blog" class="dropdown-item">Blog Grid</a>
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
                                    <a class="btn-sm-square btn-transparent rounded-circle ms-3" href="customer/cart.jsp">
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
                            <a class="btn btn-square btn-transparent rounded-circle cart" href="actioncustomer?action=cart">
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
                <h1 class="display-3 mb-3 animated slideInDown">Liên Hệ</h1>
                <nav aria-label="breadcrumb animated slideInDown">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a class="text-body" href="#">Home</a></li>
                        <li class="breadcrumb-item"><a class="text-body" href="#">Pages</a></li>
                        <li class="breadcrumb-item text-dark active" aria-current="page">Contact Us</li>
                    </ol>
                </nav>
            </div>
        </div>
        <!-- Page Header End -->

        <!-- Contact Start -->
        <div class="container-xxl py-6">
            <div class="container">
                <div class="section-header text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                    <h1 class="display-5 mb-3">Liên Hệ</h1>
                    
                </div>
                <div class="row g-5 justify-content-center">
                    <div class="col-lg-5 col-md-12 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="bg-primary text-white d-flex flex-column justify-content-center h-100 p-5">
                            <h5 class="text-white">Call Us</h5>
                            <p class="mb-5"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                            <h5 class="text-white">Email Us</h5>
                            <p class="mb-5"><i class="fa fa-envelope me-3"></i>foody@gmail.com</p>
                            <h5 class="text-white">Office Address</h5>
                            <p class="mb-5"><i class="fa fa-map-marker-alt me-3"></i>Thạch Hòa, Thạch Thất, Hà Nội</p>
                            <h5 class="text-white">Follow Us</h5>
                            <div class="d-flex pt-2">
                                <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i class="fab fa-youtube"></i></a>
                                <a class="btn btn-square btn-outline-light rounded-circle me-0" href=""><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-12 wow fadeInUp" data-wow-delay="0.5s">
                        <c:if test="${not empty message}">
                            <div>
                                ${message}
                            </div>
                        </c:if>
                        <form action="ContactServlet" method="post" class="bg-white p-md-5 p-4 mb-5 border">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" id="name" name="name" class="form-control" value="${not empty param.name ? param.name : ''}" required>
                                        <label for="name">Your Name</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="email" id="email" name="email" class="form-control" value="${not empty param.email ? param.email : ''}" required>
                                        <label for="email">Your Email</label>
                                    </div>
                                </div>
                                <div class="form-floating">
                                        <input type="text" id="phone" name="phone" class="form-control" value="${not empty param.phone ? param.phone : ''}" required>
                                        <label for="email">Phone</label>
                                    </div>
                                
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea name="message" id="message" class="form-control" cols="30" rows="8" required>${not empty param.message ? param.message : ''}</textarea>
                                        <label for="message">Message</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <input type="submit" value="Send Message" class="btn btn-primary text-white font-weight-bold">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->


        <!-- Google Map Start -->
        <div class="container-xxl px-0 wow fadeIn" data-wow-delay="0.1s" style="margin-bottom: -6px;">
            <iframe class="w-100" style="height: 450px;"
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3001156.4288297426!2d-78.01371936852176!3d42.72876761954724!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4ccc4bf0f123a5a9%3A0xddcfc6c1de189567!2sNew%20York%2C%20USA!5e0!3m2!1sen!2sbd!4v1603794290143!5m2!1sen!2sbd"
                    frameborder="0" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
        </div>
        <!-- Google Map End -->


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
                        <div class="col-md-6 text-center text-md-end">
                            <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                            <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
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