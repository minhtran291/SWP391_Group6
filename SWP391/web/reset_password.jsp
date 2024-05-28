<%-- 
    Document   : reset_password
    Created on : May 26, 2024, 10:57:52 PM
    Author     : phamc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đặt lại mật khẩu</title>
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
            .container h2 {
                margin-bottom: 20px;
                color: #333;
            }
            .container .input-group {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .container .input-group img {
                margin-right: 10px;
            }
            .container .input-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #17a2b8;
                border-radius: 5px;
            }
            .container .input-group input:focus {
                outline: none;
                border-color: #80bdff;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .container button {
                background-color: #17a2b8;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .container button:hover {
                background-color: #138496;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Reset Password</h2>
            <form action="reset" method="post">
                <div class="input-group">
                    <label for="password">
                        <img src="https://icons.iconarchive.com/icons/webalys/kameleon.pics/48/Key-icon.png" alt="Key Icon">
                    </label>
                    <input type="password" id="password" name="password" placeholder="New Password" required>
                </div>
                <div class="input-group">
                    <label for="confirmPassword">
                        <img src="https://icons.iconarchive.com/icons/webalys/kameleon.pics/48/Key-icon.png" alt="Key Icon">
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm New Password" required>
                </div>
                <button type="submit">Reset</button>
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
