<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Thể Loại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            padding: 1em;
            background: #f9f9f9;
            border-radius: 5px;
        }
        label, input, textarea {
            display: block;
            width: 100%;
            margin-bottom: 1em;
        }
        input, textarea {
            padding: 0.5em;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        input[type="submit"] {
            background: #007bff;
            color: white;
            border: none;
            padding: 1em;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Sửa Thể Loại</h2>
    <c:if test="${not empty category}">
        <form action="CategoryServlet?action=update" method="post">
            <input type="hidden" name="foodId" value="${category.category_id}">
            <label for="categoryName">Tên Thể Loại:</label>
            <input type="text" name="updateCategory" value="${category.category_name}" required>
            <input type="submit" value="Sửa Thể Loại">
        </form>
    </c:if>
</body>
</html>
