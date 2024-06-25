<%-- 
    Document   : about
    Created on : Jun 16, 2024, 5:01:26 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                    <a href="blog.jsp" class="dropdown-item">Blog Grid</a>
                                    <a href="bestsellers.jsp" class="dropdown-item">Our Features</a>
                                    <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                                    <a href="404.jsp" class="dropdown-item">404 Page</a>
                                    <a href="contact.jsp" class="dropdown-item">Liên Hệ</a>
                                </div>
                            </div>
                            <form class="d-none d-lg-flex ms-2 align-items-center">
                                <div class="input-group">
                                    <input type="text" class="form-control border-1" placeholder="Tìm kiếm..." aria-label="Tìm kiếm">
                                    <button class="btn btn-outline-success" type="submit">
                                        <i class="fa fa-search"></i>
                                    </button>



                                    <a class="btn-sm-square bg-white rounded-circle ms-3" href="login.jsp">
                                        <small class="fa fa-user text-body"></small>
                                    </a>
                                    <a class="btn-sm-square bg-white rounded-circle ms-3" href="customer/cart.jsp">
                                        <small class="fa fa-shopping-bag text-body"></small>
                                    </a>
                                </div>
                            </form>

                        </div>
                    </div>
            </nav>

        </div>
        <!-- Navbar End -->


        <!-- Page Header Start -->
        <div class="container-fluid page-header mb-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container">
                <h1 class="display-3 mb-3 animated slideInDown">Giới Thiệu</h1>
                <nav aria-label="breadcrumb animated slideInDown">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a class="text-body" href="#">Home</a></li>
                        <li class="breadcrumb-item"><a class="text-body" href="#">Pages</a></li>
                        <li class="breadcrumb-item text-dark active" aria-current="page">About Us</li>
                    </ol>
                </nav>
            </div>
        </div>
        <!-- Page Header End -->


        <!-- About Start -->
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
    </head>
<body>
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-6 wow fadeIn about-img" data-wow-delay="0.1s">
                    <div class="position-relative overflow-hidden p-5 pe-0">
                        <img class="img-fluid w-100" src="img/about-2.jpg" alt="About Us">
                    </div>
                </div>
                <div class="col-lg-6 wow fadeIn about-section" data-wow-delay="0.5s">
                    <h1 class="display-5 mb-4">Chào mừng đến với Foody - Thiên Đường Ẩm Thực</h1>
                    <p class="mb-4">Tại Foody, chúng tôi tự hào mang đến cho bạn những sản phẩm thực phẩm chất lượng cao, được chọn lọc kỹ càng từ những trang trại tốt nhất. Với tiêu chí "Sạch từ nguồn - Tươi từ đất", chúng tôi cam kết cung cấp thực phẩm an toàn, lành mạnh và bổ dưỡng cho mọi bữa ăn của gia đình bạn.</p>

                    <h2 class="mb-3">Sứ Mệnh Của Chúng Tôi</h2>
                    <p class="mb-4">Sứ mệnh của Foody là mang lại nguồn thực phẩm hữu cơ tươi ngon, đảm bảo sức khỏe cho người tiêu dùng và bảo vệ môi trường. Chúng tôi tin rằng thực phẩm không chỉ là dinh dưỡng, mà còn là niềm vui và sự gắn kết trong mỗi bữa ăn gia đình.</p>

                    <h2 class="mb-3">Tại Sao Chọn Foody?</h2>
                    <ul class="list-unstyled mb-4">
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Chất Lượng Hàng Đầu</strong>: Sản phẩm của chúng tôi được trồng và chăm sóc theo tiêu chuẩn nghiêm ngặt, đảm bảo không chứa hóa chất độc hại.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Nguồn Gốc Rõ Ràng</strong>: Mỗi sản phẩm đều có nguồn gốc rõ ràng, từ trang trại đến bàn ăn, giúp bạn hoàn toàn yên tâm về chất lượng.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Đa Dạng Sản Phẩm</strong>: Từ rau củ quả tươi, thịt cá, đến các sản phẩm chế biến sẵn, Foody cung cấp đầy đủ nhu cầu thực phẩm cho gia đình bạn.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Giao Hàng Tận Nơi</strong>: Chúng tôi hỗ trợ giao hàng nhanh chóng và tiện lợi, giúp bạn tiết kiệm thời gian và công sức.</li>
                    </ul>

                    <h2 class="mb-3">Sản Phẩm Nổi Bật</h2>
                    <p class="mb-4">Tại Foody, bạn sẽ tìm thấy những sản phẩm nổi bật như:</p>
                    <ul class="list-unstyled mb-4">
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Cơm Rang</strong>: Ngon miệng và đầy đủ dinh dưỡng, phù hợp cho bữa trưa và bữa tối.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Phở</strong>: Hương vị truyền thống, thơm ngon và bổ dưỡng.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Bún</strong>: Đa dạng với nhiều loại bún khác nhau, phục vụ mọi sở thích của bạn.</li>
                        <li class="mb-2"><i class="fa fa-check text-primary me-3"></i><strong>Các Món Ăn Vặt</strong>: Tiện lợi và ngon miệng, phù hợp cho những lúc bạn muốn ăn nhẹ.</li>
                    </ul>

                    <h2 class="mb-3">Liên Hệ Với Chúng Tôi</h2>
                    <p class="mb-4">Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn. Nếu có bất kỳ thắc mắc hay yêu cầu nào, xin vui lòng liên hệ với chúng tôi qua:</p>
                    <p class="mb-2"><i class="fa fa-map-marker-alt text-primary me-3"></i>Địa Chỉ: Thạch Hòa, Thạch Thất, Hà Nội</p>
                    <p class="mb-2"><i class="fa fa-envelope text-primary me-3"></i>Email: foody@gmail.com</p>
                    <p class="mb-2"><i class="fa fa-phone-alt text-primary me-3"></i>Số Điện Thoại: 0123 456 789</p>

                    <a class="btn btn-primary rounded-pill py-3 px-5 mt-3" href="contact.jsp">Liên Hệ Ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js"></script>
<script>
    new WOW().init();
</script>


<!-- About End -->

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