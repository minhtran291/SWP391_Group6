<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh Sửa Hồ Sơ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/dd760d7b93.js" crossorigin="anonymous"></script>
        <style type="text/css">
            body {
                margin-top: 20px;
            }
            .avatar {
                width: 200px;
                height: 200px;
                object-fit: cover; /* Đảm bảo ảnh không bị méo */
            }
        </style>
    </head>
    <body>
        <div class="container bootstrap snippets bootdey">
            <h1 class="text-primary">Chỉnh sửa hồ sơ</h1>
            <hr>

            <div class="col-md-9 personal-info">
                <h3>Thông tin cá nhân</h3>
                <!-- Thẻ form với enctype="multipart/form-data" để tải lên ảnh -->
                <form class="form-horizontal" role="form" id="profileForm" action="profile" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="text-center">
                                <!-- Hiển thị hình ảnh hiện tại -->
                                <img src="${sessionScope.acc.avatar}" class="avatar img-circle img-thumbnail" alt="avatar" id="currentAvatar">
                                <h6>Chọn một hình ảnh khác</h6>
                                <!-- Cho phép tải lên ảnh mới -->
                                <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" onchange="previewImage(event)">
                            </div>
                        </div>
                        <input type="hidden" name="id" value="${sessionScope.acc.userid}"/>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Tên đăng nhập:</label>
                            <div class="col-lg-8">
                                <input class="form-control" name="username" type="text" readonly="" value="${sessionScope.acc.username}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Email:</label>
                            <div class="col-lg-8">
                                <input class="form-control" name="email" type="text" value="${sessionScope.acc.email}">
                            </div>
                            <h5 class="text-danger">${errorEmailUpdate}</h5>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Giới tính:</label>
                            <div class="col-lg-8">
                                <select class="form-control" name="gender">
                                    <option value="1" ${sessionScope.acc.gender == 1 ? "selected" : ""}>Nam</option>
                                    <option value="0" ${sessionScope.acc.gender == 0 ? "selected" : ""}>Nữ</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label class="col-lg-3 control-label">Số điện thoại:</label>
                            <div class="col-lg-8">
                                <input class="form-control" name="phone" type="text" value="${sessionScope.acc.phone}">
                            </div>
                            <h5 class="text-danger">${errorPhoneUpdate}</h5>
                        </div>
                        <div class="modal-footer justify-content-start">
                            <button type="submit" class="btn btn-success">Lưu</button>
                        </div>
                </form>
            </div>
        </div>
        <hr>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                    function previewImage(event) {
                                        var file = event.target.files[0];
                                        var reader = new FileReader();

                                        reader.onload = function (e) {
                                            var imageElement = document.getElementById('currentAvatar');
                                            imageElement.src = e.target.result;
                                        }

                                        if (file) {
                                            reader.readAsDataURL(file);
                                        }
                                    }
        </script>
    </body>
</html>
