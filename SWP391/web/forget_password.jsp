<%-- 
    Document   : forget_password
    Created on : May 26, 2024, 10:56:42 PM
    Author     : phamc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <title>Quên Mật Khẩu</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 400px;
                margin: 100px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            label {
                display: block;
                margin-bottom: 10px;
                font-weight: bold;
            }
            input[type="email"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .buttons {
                display: flex;
                justify-content: space-between;
            }
            .buttons button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .buttons .submit-btn {
                background-color: #28a745;
                color: white;
            }
            .buttons .back-btn {
                background-color: #dc3545;
                color: white;
            }
            .buttons .submit-btn:hover,
            .buttons .back-btn:hover {
                opacity: 0.8;
            }
            .instructions {
                text-align: center;
                color: #666;
                margin-top: -10px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Nhập email của bạn</h2>
            <form action="forget" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required="">
                <div class="instructions">
                    Nhập email đã được đăng ký. Chúng tôi sẽ gửi 1 mã OTP về địa chỉ email này
                </div>
                <div class="buttons">
                    <button type="submit" class="submit-btn">Đổi mật khẩu mới</button>
                    <button type="button" class="back-btn" onclick="window.location.href = 'login'">Quay lại đăng nhập</button>
                </div>
            </form>
        </div>
        <h6 class="text-center text-danger">
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println(message );
            }
        %>
        </h6>
    </body>
</html>
