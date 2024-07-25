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

        <title>Quản lí tài khoản</title>
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


                        <div class="dropdown">
                            <button type="button" class="btn btn-square bg-white rounded-circle me-2 dropdown-toggle" 
                                    data-bs-toggle="dropdown">
                                <i class="fa fa-user text-body"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">



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


        <c:set var="n" value="${currentPage}"/>

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

            <h1 class="text-center m-3">Quản lý tài khoản</h1>
            <div class="d-flex mb-3">

                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAccount"
                        style="margin-left: 20px">
                    Thêm tài khoản
                </button>
                <div class="modal fade" id="addAccount">
                    <div class="modal-dialog modal-dialog-scrollable">    
                        <div class="modal-content">  

                            <div class="modal-header">
                                <h4 class="modal-title">Thêm tài khoản mới</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <form action="actionadmin" method="post">
                                <input type="hidden" name="action" value="addAccount">
                                <input type="hidden" name="page" value="${n}">
                                <div class="modal-body">

                                    <div>
                                        <label class="form-label" for="usernameInput">Tên đăng nhập</label>
                                        <input type="text"
                                               class="form-control"
                                               required type="text" 
                                               name="username" id="usernameInput"
                                               >
                                        <h5 id="usernameError" style="color: red; display: none;">
                                            Tên đăng nhập không được để trống.
                                        </h5>


                                        <h5 class="text-danger">${requestScope.errorName}</h5>
                                    </div>

                                    <div>
                                        <label class="form-label" for="passwordInput">Mật khẩu</label>
                                        <input type="password"
                                               class="form-control"
                                               name="password"
                                               minlength="6" required 
                                               id="passwordInput" 
                                               >
                                        <h5 id="passwordError" style="color: red; display: none;">
                                            Mật khẩu phải có ít nhất 6 ký tự.
                                        </h5>
                                    </div>      
                                    <label>Giới tính:</label><br>
                                    <input name="gender" required type="radio" value="1" id="genderMale" />
                                    <label for="genderMale">Nam</label><br>
                                    <input name="gender" required type="radio" value="0" id="genderFemale" />
                                    <label for="genderFemale">Nữ</label><br>

                                    <label>Vai trò:</label>
                                    <div>
                                        <select class="form-select" name="roleid">
                                            <c:forEach var="r" items="${sessionScope.rlist}">
                                                <option value="${r.roleid}">${r.rolename}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div>

                                        <label class="form-label" for="emailInput">Email</label>

                                        <input type="email"
                                               required 
                                               class="form-control"
                                               required=""
                                               name="email"
                                               id="emailInput"
                                               >
                                        <h5 id="emailError" style="color: red; display: none;">
                                            Vui lòng nhập một địa chỉ email hợp lệ.
                                        </h5>
                                        <div><label class="text-danger" for="form3Examplea9">${requestScope.mess}</label></div>
                                        <h5 class="text-danger">${requestScope.errorEmail}</h5>
                                    </div>

                                    <div>
                                        <label class="form-label" for="phoneInput">Số điện thoại</label>
                                        <input type="text"
                                               class="form-control"
                                               name="phone" required
                                               type="tel" id="phoneInput" 
                                               >
                                        <h5 id="phoneError" style="color: red; display: none;">
                                            Số điện thoại phải có ít nhất 10 chữ số.
                                        </h5>
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
                <div class="dropdown ms-auto">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
                            style="margin-right: 20px;">
                        Vai trò</button>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item"
                               href="actionadmin?action=searchByRole&&roleid=all">
                                Tất cả
                            </a>
                        </li>
                        <c:forEach var="c" items="${rlist}">
                            <li>
                                <a class="dropdown-item" 
                                   href="actionadmin?action=searchByRole&&roleid=${c.roleid}">${c.rolename}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>    
            </div>


            <table class="table text-center">
                <tr>
                    <th>ID </th>
                    <th>Tên đăng nhập </th>
                    <th>Mật khẩu</th>
                    <th>Giới tính</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                </tr>
                <c:forEach var="f" items="${empOnCurrentPage}">
                    <tr style="vertical-align: middle">
                        <td>${f.userid}</td>
                        <td>${f.username}</td>             
                        <c:forEach var="password" items="${f.password}" varStatus="status">

                            <td>
                                <span id="passwordField${status.index}" data-password="${password}">${fn:length(password) > 0 ? '******' : ''}</span>
                            </td>

                        </c:forEach>
                        <td>${f.gender == 1 ? "Nam" : "Nữ"}</td>
                        <td>${f.email}</td>
                        <td>${f.phone}</td>
                        <td> <c:choose>
                                <c:when test="${f.roleid == 2}">
                                    Quản lí cửa hàng
                                </c:when>
                                <c:when test="${f.roleid == 3}">
                                    Nhân viên giao hàng
                                </c:when>
                                <c:when test="${f.roleid == 4}">
                                    Quản trị hệ thống
                                </c:when>
                                <c:otherwise>
                                    Khách hàng
                                </c:otherwise>
                            </c:choose></td>
                        <td>
                            <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateAccount${f.userid}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>
                            <div class="modal fade text-start" id="updateAccount${f.userid}">
                                <div class="modal-dialog modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Cập nhật tài khoản</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">    
                                            <form action="actionadmin" method="post"  id="myForm">
                                                <input type="hidden" name="action" value="updateAccount">
                                                <input type="hidden" name="page" value="${n}">
                                                <div>
                                                    <b>ID:</b>
                                                    <input type="text"
                                                           class="form-control"
                                                           readonly=""
                                                           value="${f.userid}"
                                                           name="id"
                                                           >
                                                </div>


                                                <div>
                                                    <label class="form-label" for="usernameInput">Tên đăng nhập</label>
                                                    <input type="text"
                                                           class="form-control"
                                                           value="${f.username}"
                                                           required
                                                           name="username"
                                                           id="usernameInput">
                                                    <h5 id="usernameError" style="color: red; display: none;">
                                                        Tên đăng nhập không được để trống.
                                                    </h5>
                                                    <h5 class="text-danger">${requestScope.errorNameUpdate}</h5>
                                                </div>
                                                <div>
                                                    <label class="form-label" for="passwordInput">Mật khẩu</label>
                                                    <input type="password"
                                                           class="form-control"
                                                           name="password"
                                                           id="passwordInput"
                                                           value="${f.password}"
                                                           minlength="6"
                                                           required
                                                           pattern="^\S{6,}$"
                                                           title="Mật khẩu phải có ít nhất 6 ký tự và không có dấu cách."
                                                           oninvalid="this.setCustomValidity('Mật khẩu phải có ít nhất 6 ký tự và không có dấu cách.')"
                                                           oninput="setCustomValidity('')">
                                                    <h5 id="passwordError" style="color: red; display: none;">
                                                        Mật khẩu phải có ít nhất 6 ký tự và không có dấu cách.
                                                    </h5>
                                                </div>   


                                                <label>Vai trò:</label>
                                                <div>
                                                    <select class="form-select" name="roleid">
                                                        <c:forEach var="c" items="${sessionScope.rlist}">
                                                            <option value="${c.roleid}" ${f.rolename == c.rolename?"selected":""}>
                                                                ${c.rolename}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div>
                                                    <label class="form-label" for="emailInput">Email</label>
                                                    <input type="email"
                                                           required
                                                           class="form-control"
                                                           value="${f.email}"
                                                           name="email"
                                                           id="email"
                                                           pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}"
                                                           oninvalid="this.setCustomValidity('Vui lòng nhập một địa chỉ email hợp lệ.')"
                                                           oninput="setCustomValidity('')">
                                                    <h5 id="emailError" style="color: red; display: none;">
                                                        Vui lòng nhập một địa chỉ email hợp lệ.
                                                    </h5>
                                                    <div>
                                                        <label class="text-danger" for="form3Examplea9">${requestScope.mess}</label>
                                                    </div>
                                                    <h5 class="text-danger">${requestScope.errorEmailUpdate}</h5>
                                                </div>

                                                <div>
                                                    <label class="form-label" for="phoneInput">Số điện thoại</label>
                                                    <input type="tel"
                                                           class="form-control"
                                                           name="phone"
                                                           id="phone"
                                                           value="${f.phone}"
                                                           pattern="\d{10}"
                                                           required
                                                           oninvalid="this.setCustomValidity('Vui lòng nhập số điện thoại hợp lệ.')"
                                                           oninput="setCustomValidity('')">
                                                    <h5 id="phoneError" style="color: red; display: none;">
                                                        Số điện thoại phải có đúng 10 chữ số.
                                                    </h5>
                                                    <h5 class="text-danger">${requestScope.errorphoneUpdate}</h5>
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
                            <a class="btn btn-lg" 
                               href="actionadmin?action=deleteAcc&&deleteId=${f.userid}&&page=${n}"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa không tài khoản ${f.username} ?')">
                                <i class="fa-solid fa-trash-can"></i>
                            </a>
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
                      href="actionadmin?action=manageAcc">Quản lí tài khoản</a></p>
<!--                <p><a class="btn text-white btn-primary" 
                      href="">Quản lí địa điểm giao nhận hàng</a></p>-->
                <div class="dropdown">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
                        Quản lí địa điểm giao nhận hàng
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="actionadmin?action=districtManagement">Quản lí quận, huyện</a></li>
                        <li><a class="dropdown-item" href="actionadmin?action=wardManagement">Quản lí xã, phường</a></li>
                    </ul>
                </div>
            </div>



        </div>
        <ul class="pagination justify-content-center">
            <c:forEach var="p" begin="${1}" end="${totalPages}">
                <li class="page-item">

                    <c:if test="${listUserbyRole != null}">
                        <a class="page-link ${p==n?"active":""}"  
                           href="actionadmin?action=searchByRole&&page=${p}&&roleid=${roleid}">${p}</a>
                    </c:if>
                    <c:if test="${listUserbyRole == null }">
                        <a class="page-link ${p==n?"active":""}"  
                           href="actionadmin?action=manageAcc&&page=${p}">${p}</a>
                    </c:if>
                </li>
            </c:forEach>
        </ul>




        <footer>
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
        </footer>


        <script>
            var errorName = "${requestScope.errorName}";
            var errorEmail = "${requestScope.errorPrice}";
            var errorphone = "${requestScope.errorStock}";
            if (errorName.trim() !== "" || errorEmail.trim() !== "" || errorphone.trim() !== "") {
                $(document).ready(function () {
                    $('#addAccount').modal('show');
                });
            }
            var errorNameUpdate = "${requestScope.errorNameUpdate}";
            var errorEmailUpdate = "${requestScope.errorEmailUpdate}";
            var errorphoneUpdate = "${requestScope.errorphoneUpdate}";
            if (errorNameUpdate.trim() !== "" || errorEmailUpdate.trim() !== "" || errorphoneUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateAccount${id}').modal('show');
                });
            }

        </script>
        <script>
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
        </script>
        <script>
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



        </script>
    </body>
</html>
