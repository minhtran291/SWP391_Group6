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
            <h2>Enter your email address</h2>
            <form action="forget" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <div class="instructions">
                    Enter the registered email address. Then we'll email a OTP to this address.
                </div>
                <div class="buttons">
                    <button type="submit" class="submit-btn">Get New Password</button>
                    <button type="button" class="back-btn" onclick="window.location.href = 'login.jsp'">Back to Login</button>
                </div>
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
