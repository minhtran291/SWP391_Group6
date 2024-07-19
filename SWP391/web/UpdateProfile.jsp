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
            }
        </style>
    </head>
    <body>
        <div class="container bootstrap snippets bootdey">
            <h1 class="text-primary">Chỉnh sửa hồ sơ</h1>
            <hr>
            <div class="row">
                <div class="col-md-9 personal-info">
                    <h3>Thông tin cá nhân</h3>
                    <form class="form-horizontal" role="form" id="profileForm" enctype="multipart/form-data">
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
                            <h4>${errorEmailUpdate}</h4>
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
                            <h4>${errorPhoneUpdate}</h4>
                        </div>

<!--                        <div id="avatarPreview">
                            <h3>Xem trước ảnh đại diện mới</h3>
                            <img id="currentImage" src="${sessionScope.acc.avatar}" alt="Không thể tải ảnh" class="img-fluid d-block mx-auto">
                        </div>
                        <div class="mt-3 mb-3">-->
<!--                            <input id="imageUrlInput" name="avatar" type="text" placeholder="Nhập địa chỉ ảnh" class="form-control" oninput="previewImageByUrl(event);" />
                            <div id="imagePreview" class="mt-3">
                                <img id="newImage" src="" alt="Ảnh xem trước" class="img-fluid d-block mx-auto" style="display:none;">
                            </div>
                        </div>-->
                        <div class="modal-footer justify-content-start">
                            <button type="button" class="btn btn-success" onclick="saveProfile()">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <hr>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                function previewImageByUrl(event) {
                                    var imageUrl = event.target.value;
                                    var imageElement = document.getElementById('newImage');

                                    if (imageUrl) {
                                        imageElement.src = imageUrl;
                                        imageElement.style.display = 'block';
                                    } else {
                                        imageElement.style.display = 'none';
                                    }
                                }

                                function saveProfile() {
                                    var formData = new FormData(document.getElementById('profileForm'));

                                    $.ajax({
                                        url: 'profile', // The servlet URL to handle the form submission
                                        type: 'POST',
                                        data: formData,
                                        processData: false,
                                        contentType: false,
                                        success: function (response) {
                                            // Optionally, display a success message to the user
                                            alert('Profile updated successfully!');
                                            // Redirect to profile.jsp
                                            window.location.href = 'profile';
                                        },
                                        error: function () {
                                            // Optionally, display an error message to the user
                                            alert('An error occurred while updating the profile.');
                                        }
                                    });
                                }
        </script>
    </body>
</html>
