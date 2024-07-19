<%-- 
    Document   : enter_code
    Created on : May 26, 2024, 10:57:17 PM
    Author     : phamc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nhập mã OTP</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #f8f9fa;
            }
            .container {
                text-align: center;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .container img {
                width: 100px;
                height: 100px;
            }
            .container h2 {
                margin: 20px 0;
                color: #333;
            }
            .container .input-group {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
            }
            .container .input-group input {
                width: 200px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-left: 10px;
            }
            .container .input-group input:focus {
                outline: none;
                border-color: #80bdff;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .container button {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .container button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <img src="https://png.pngtree.com/png-vector/20190216/ourlarge/pngtree-vector-lock-icon-png-image_540594.jpg" alt="Lock Icon">
            <h2>Nhập OTP</h2>
            <form action="validate" method="post">
                <div class="input-group">
                    <label for="code"><img src="https://icons.iconarchive.com/icons/custom-icon-design/flatastic-11/48/Mailbox-icon.png" alt="Mail Icon"></label>
                    <input type="text" id="code" name="code" placeholder="Enter OTP" required>
                </div>
                <button type="submit">Đặt lại mật khẩu</button>
            </form>
        </div>


        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<p>" + message + "</p>");
            }
        %>
    </body>
</html>
