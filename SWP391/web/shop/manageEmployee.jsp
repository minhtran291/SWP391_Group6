<%-- 
    Document   : manageFood
    Created on : May 24, 2024, 9:30:43 PM
    Author     : Dell
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <title>Quản lí nhân viên</title>
        <style>
            .navbar-nav {
                display: flex;
                flex-direction: row;
            }

            .fa-pen-to-square{
                color: #76b852;
            }
            .fa-trash-can{
                color: coral;
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
        </style>
    </head>
    <body class="d-flex flex-column" style="min-height: 100vh;">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">

            <div style="margin-left: 20px;">
                <button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    <i class="fa-solid fa-bars"></i>
                </button>
            </div>


            <div class="container-fluid" style="padding-left: 40px;">
                <ul class="navbar-nav">

                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <h1 class="fw-bold" style="font-family: Florence, cursive; color: #33cc00">
                                F<span style="color: #ff6633">oo</span>dy
                            </h1></a>
                    </li>
                </ul>

                <div style="margin-right: 20px">
                    <form class="d-flex" action="actionshop" method="get">
                        <input type="hidden" name="action" value="getFoodBySearch">
                        <!--                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                                                       style="width: 300px">
                                                <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                                                    <i class="fa fa-search text-body"></i>
                                                </button>-->

                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li >
                                    <a class="dropdown-item" href="actionshop?action=profile">
                                        Hồ sơ
                                    </a>
                                </li>
                                <!--                                <li>
                                                                    <a class="dropdown-item" href="actioncustomer?action=history">
                                                                        Đơn hàng
                                                                    </a>
                                                                </li>-->

                                <li>
                                    <a class="dropdown-item" href="logout">
                                        Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <!--                        <a class="btn btn-square bg-white rounded-circle" href="">
                                                    <i class="fa fa-shopping-bag text-body"></i>
                                                </a>-->
                    </form>
                </div>
            </div>
        </nav>





        <c:set var="n" value="${currentPageEmp}"/>

        <div class="flex-grow-1">

            <!--            <div class="d-flex bg-light mb-5">
                            <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="#" style="font-size: 16px;">Trang chủ</a>
                                    </li>
            
                                </ul>
                            </div>
                        </div>-->

            <h1 class="text-center m-3">Quản lý nhân viên</h1>
            <div class="d-flex mb-3">

                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addEmployee"
                        style="margin-left: 20px">
                    Thêm nhân viên
                </button>
                <div class="modal fade" id="addEmployee">
                    <div class="modal-dialog modal-dialog-scrollable">    
                        <div class="modal-content">  

                            <div class="modal-header">
                                <h4 class="modal-title">Thêm nhân viên mới</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <form action="employee" method="post">
                                <input type="hidden" name="action" value="addEmployee">
                                <input type="hidden" name="page" value="${n}">
                                <div class="modal-body">

                                    <div>
                                        <label class="form-label" for="usernameInput">Tên đăng nhập</label>
                                        <input type="text"
                                               class="form-control"
                                               required type="text" 
                                               name="username" id="usernameInput"
                                               >
<!--                                        <h5 id="usernameError" style="color: red; display: none;">
                                            Tên đăng nhập không được để trống.
                                        </h5>-->


                                        <h5 class="text-danger">${requestScope.errorName}</h5>
                                    </div>

                                    <div>
                                        <label class="form-label" for="passwordInput">Mật khẩu</label>
                                        <input type="password"
                                               class="form-control"
                                               name="password"
                                               minlength="8" required 
                                               id="passwordInput"
                                               pattern="(?=.*[a-zA-Z])(?=.*\d).{8,}" title="Mật khẩu phải có 8 ký tự, ít nhất 1 ký tự số."
                                               >
                                        <!--                                        <h5 id="passwordError" style="color: red; display: none;">
                                                                                    Mật khẩu phải có ít nhất 6 ký tự.
                                                                                </h5>-->
                                    </div>      
                                    <label>Giới tính:</label><br>
                                    <input name="gender" required type="radio" value="1" id="genderMale" />
                                    <label for="genderMale">Nam</label><br>
                                    <input name="gender" required type="radio" value="0" id="genderFemale" />
                                    <label for="genderFemale">Nữ</label><br>


                                    <div>

                                        <label class="form-label" for="emailInput">Email</label>

                                        <input type="email"
                                               required 
                                               class="form-control"
                                               required=""
                                               name="email"
                                               id="emailInput"
                                               pattern="^[^\s@]+@[^\s@]+\.[^\s@]{2,}$" title="Hãy nhập đúng địa chỉ email hợp lệ ví dụ foody@gmail.com"
                                               >
                                        <!--                                        <h5 id="emailError" style="color: red; display: none;">
                                                                                    Vui lòng nhập một địa chỉ email hợp lệ.
                                                                                </h5>-->
                                        <div><label class="text-danger" for="form3Examplea9">${requestScope.mess}</label></div>
                                        <h5 class="text-danger">${requestScope.errorEmail}</h5>
                                    </div>

                                    <div>
                                        <label class="form-label" for="phoneInput">Số điện thoại</label>
                                        <input type="text"
                                               class="form-control"
                                               name="phone" required
                                               type="tel" id="phoneInput" 
                                               pattern="[0-9]{10}"
                                               title="Số điện thoại phải có 10 chữ số"
                                               >
                                        <!--                                        <h5 id="phoneError" style="color: red; display: none;">
                                                                                    Số điện thoại phải có ít nhất 10 chữ số.
                                                                                </h5>-->
                                        <h5 class="text-danger">${requestScope.errorphone}</h5>
                                    </div>

                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>  

            </div>


            <table class="table text-center">
                <tr>
                    <th>ID </th>
                    <th>Tên đăng nhập </th>
                    <th>Giới tính</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                    <th>Tùy chọn</th>
                </tr>
                <c:forEach var="f" items="${employeeOnCurrentPage}">
                    <tr style="vertical-align: middle">
                        <td>${f.userid}</td>
                        <td>${f.username}</td>             

                        <td>${f.gender == 1 ? "Nam" : "Nữ"}</td>
                        <td>${f.email}</td>
                        <td>${f.phone}</td>
                        <td> <c:choose>
                                <c:when test="${f.roleid == 2}">
                                    Quản lí cửa hàng
                                </c:when>
                                <c:when test="${f.roleid == 3}">
                                    Người giao hàng
                                </c:when>
                                <c:when test="${f.roleid == 4}">
                                    Quản trị viên
                                </c:when>
                                <c:otherwise>
                                    Khách hàng
                                </c:otherwise>
                            </c:choose></td>
                        <td>
                            <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateEmployee${f.userid}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>
                            <div class="modal fade text-start" id="updateEmployee${f.userid}">
                                <div class="modal-dialog modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Cập nhật nhân viên</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">    
                                            <form action="employee" method="post"  id="myForm">
                                                <input type="hidden" name="action" value="updateEmployee">
                                                <input type="hidden" name="page" value="${n}">
                                                <div>
                                                    <b>ID:</b>
                                                    <input type="text"
                                                           class="form-control"
                                                           readonly=""
                                                           value="${f.userid}"
                                                           name="id" style="background-color: #d3d3d4"
                                                           >
                                                </div>


                                                <div>
                                                    <label class="form-label" for="usernameInput">Tên đăng nhập</label>
                                                    <input type="text" 
                                                           class="form-control"
                                                           value="${f.username}"
                                                           name="username"
                                                           id="usernameInput"
                                                           readonly="" style="background-color: #d3d3d4">


                                                </div>



                                                <label>Vai trò:</label>
                                                <div>
                                                    <select class="form-select" name="roleid">
                                                        <c:forEach var="r" items="${sessionScope.listrole}">
                                                            <option value="${r.roleid}" ${f.rolename == r.rolename?"selected":""}>
                                                                ${r.rolename}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div>
                                                    <label class="form-label" >Email</label>
                                                    <input type="email"

                                                           class="form-control"
                                                           value="${f.email}"
                                                           name="email"
                                                           id="email"
                                                           readonly="" style="background-color: #d3d3d4">

                                                </div>

                                                <div>
                                                    <label class="form-label" >Số điện thoại</label>
                                                    <input type="tel"
                                                           class="form-control"
                                                           name="phone"
                                                           id="phone"
                                                           value="${f.phone}"
                                                           style="background-color: #d3d3d4"
                                                           readonly="">

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--                            <a class="btn btn-lg" 
                                                           href="employee?action=deleteAcc&&deleteId=${f.userid}&&page=${n}"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa không nhân viên ${f.username} ?')">
                                                            <i class="fa-solid fa-unlock"></i>
                                                        </a>-->

                            <c:if test="${f.status==1}">
                                <a class="fa-solid fa-unlock" style="color: black; font-size: 20px" href="employee?action=updatestatusEmp&&Id=${f.userid}&&page=${n}&status=0"
                                   onclick="return confirm('Bạn có chắc chắn muốn khóa không nhân viên ${f.username} ?')">

                                </a>
                            </c:if>
                            <c:if test="${f.status==0}">
                                <a class="fa-solid fa-lock" style="color: red; font-size: 20px" href="employee?action=updatestatusEmp&&Id=${f.userid}&&page=${n}&status=1" 
                                   onclick="return confirm('Bạn có chắc chắn muốn mở khóa không nhân viên ${f.username} ?')">

                                </a>
                            </c:if>
                        </td>
                    </c:forEach>
            </table>
        </div>


        <div class="offcanvas offcanvas-start text-bg-dark" id="demo">
            <div class="offcanvas-header">
                <h1 class="offcanvas-title">Quản lí cửa hàng</h1>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=dashBoard">Bảng diều khiển</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=manageFood">Quản lí sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="CategoryServlet?action=manageCategory">Quản lí thể loại sản phẩm</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=confirmOrder">Xác nhận đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=all-order">Quản lí đơn hàng</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="employee?action=manageEmp">Quản lí nhân viên</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="discount?action=list">Quản lí giảm giá</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="manageblog">Quản lí Blog</a></p>
                <p><a class="btn text-white btn-primary" 
                      href="actionshop?action=orderDivision">Phân đơn hàng</a></p>
            </div>
        </div>


        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPagesEmp}">
                <li class="page-item">
                    <a class="page-link ${p==n?"active":""}"  
                       href="employee?action=manageEmp&&page=${p}">${p}</a>
                </li>
            </c:forEach>
        </ul>


        <!--        <footer>
                    <div class="bg-dark p-3">
                        <div class="container text-white">
                            <div class="row">
                                <div class="col-md-6">
                                    <h4>Liên hệ</h4>
                                    <p>Địa chỉ: Thạch Hòa, Thạch Thất, Hà Nội</p>
                                    <p>Email: minh291@gmail.com</p>
                                    <p>Số điện thoại: 0123456789</p>
                                </div>
                                <div class="col-md-6">
                                    <h4>Liên kết</h4>
                                    <ul class="list-unstyled">
                                        <li><a href="#">Trang chủ</a></li>
                                        <li><a href="#">Giới thiệu</a></li>
                                        <li><a href="#">Sản phẩm</a></li>
                                        <li><a href="#">Liên hệ</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>-->


        <script>
            var errorName = "${requestScope.errorName}";
            var errorEmail = "${requestScope.errorEmail}";
            var errorphone = "${requestScope.errorphone}";
            if (errorName.trim() !== "" || errorEmail.trim() !== "" || errorphone.trim() !== "") {
                $(document).ready(function () {
                    $('#addEmployee').modal('show');
                });
            }
            var errorNameUpdate = "${requestScope.errorNameUpdate}";
            var errorEmailUpdate = "${requestScope.errorEmailUpdate}";
            var errorphoneUpdate = "${requestScope.errorphoneUpdate}";
            if (errorNameUpdate.trim() !== "" || errorEmailUpdate.trim() !== "" || errorphoneUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateEmployee${id}').modal('show');
                });
            }
        </script>
        <!--        <script>
                    document.getElementById('emailInput').addEventListener('input', function () {
                        var emailField = document.getElementById('emailInput');
                        var emailError = document.getElementById('emailError');
        
                        // Simple email regex for validation
                        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
                        if (!emailRegex.test(emailField.value)) {
                            emailError.style.display = 'block';
                        } else {
                            emailError.style.display = 'none';
                        }
                    });
                </script>-->
        <!--        <script>
                    document.getElementById('passwordInput').addEventListener('input', function () {
                        var passwordField = document.getElementById('passwordInput');
                        var passwordError = document.getElementById('passwordError');
        
                        // Minimum password length
                        var minLength = 6;
        
                        if (passwordField.value.length < minLength) {
                            passwordError.style.display = 'block';
                        } else {
                            passwordError.style.display = 'none';
                        }
                    });
                    document.getElementById('phoneInput').addEventListener('input', function () {
                        var phoneField = document.getElementById('phoneInput');
                        var phoneError = document.getElementById('phoneError');
        
                        // Remove all non-numeric characters from input
                        var phoneNumber = phoneField.value.replace(/\D/g, '');
        
                        // Minimum phone number length
                        var minLength = 10;
        
                        if (phoneNumber.length < minLength) {
                            phoneError.style.display = 'block';
                        } else {
                            phoneError.style.display = 'none';
                        }
                    });
                    document.getElementById('usernameInput').addEventListener('input', function () {
                        var usernameField = document.getElementById('usernameInput');
                        var usernameError = document.getElementById('usernameError');
        
                        // Check for spaces in the username
                        if (usernameField.value.includes(' ')) {
                            usernameError.style.display = 'block';
                        } else {
                            usernameError.style.display = 'none';
                        }
                    });
                </script>-->
    </body>
</html>
