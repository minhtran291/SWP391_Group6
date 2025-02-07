<%-- 
    Document   : manageFood
    Created on : May 24, 2024, 9:30:43 PM
    Author     : Dell
--%>

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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> <!-- de su dung cho cai doan javascript de mo cai modal -->

        <title>Quản lí sản phẩm</title>
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
            #fileLabel {
                cursor: pointer;
                transition: background-color 0.3s ease; /* Thêm hiệu ứng chuyển màu mượt mà */
            }

            #fileLabel:hover {
                background-color: #e0e0e0; /* Màu nền xám khi di chuột qua */
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
                        <input type="hidden" name="action" value="manageGetFoodBySearch">
                        <input class="form-control me-2" type="text" placeholder="Tìm kiếm" name="search"
                               style="width: 300px">
                        <button class="btn btn-square bg-white rounded-circle me-2" type="submit">
                            <i class="fa fa-search text-body"></i>
                        </button>

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



        <c:set var="n" value="${currentPage}"/>

        <div class="flex-grow-1">

            <!--            <div class="d-flex bg-light mb-5">
                            <div class="navbar navbar-expand-sm" style="padding-left: 100px; padding-right: 100px;">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="actionshop?action=homeFood" style="font-size: 16px;">Trang chủ</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <button type="button" class="btn text-secondary dropdown-toggle" data-bs-toggle="dropdown"">
                                            Thể loại</button>
                                        <ul class="dropdown-menu">
            <c:forEach var="c" items="${cList}">
                <li><a class="dropdown-item" 
                       href="actionshop?action=getFoodByCategory&&cid=${c.category_id}">${c.category_name}</a></li>
            </c:forEach>
    </ul>
</li>
</ul>
</div>
</div>-->

            <h1 class="text-center m-3">Quản lý món ăn</h1>

            <div class="d-flex mb-3">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFood"
                        style="margin-left: 20px">
                    Thêm món ăn
                </button>
                <div class="modal fade" id="addFood">
                    <div class="modal-dialog modal-dialog-scrollable">    
                        <div class="modal-content">  

                            <div class="modal-header">
                                <h4 class="modal-title">Thêm món ăn mới</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">
                                <form action="actionshop" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="addFood">
                                    <input type="hidden" name="page" value="${n}">

                                    <b>Tên món ăn:</b>
                                    <input type="text"
                                           class="form-control"
                                           required=""
                                           name="name"
                                           >
                                    <h5 class="text-danger">${requestScope.errorName}</h5>
                                    <b>Giá:</b>
                                    <input type="number"
                                           class="form-control"
                                           required=""
                                           min="1000"
                                           name="price"
                                           >
                                    <h5 class="text-danger">${requestScope.errorPrice}</h5>
                                    <b>Số lượng tồn kho:</b>
                                    <input type="number"
                                           class="form-control"
                                           required=""
                                           min="1"
                                           name="stock"
                                           >
                                    <h5 class="text-danger">${requestScope.errorStock}</h5>
                                    <b>Thể loại:</b>
                                    <div>
                                        <select class="form-select" name="cid">
                                            <c:forEach var="c" items="${sessionScope.cList}">
                                                <option value="${c.category_id}">${c.category_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <b>Miêu tả:</b>
                                    <input type="text"
                                           class="form-control"
                                           name="description"
                                           >
                                    <b>Hình ảnh:</b>
                                    <input type="file"
                                           class="form-control mb-3"
                                           required=""
                                           name="image"
                                           accept=".jpg, .jpeg, .png, .gif"
                                           id="fileInputAdd">
                                    <div>
                                        <img id="imagePreviewAdd" src="" alt="" style="max-width: 100%; height: auto; max-height: 300px; object-fit: contain;" />
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
                <div class="dropdown" style="margin-left: 1100px">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
                            style="margin-right: 20px;">
                        Sắp xếp</button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item ${type eq "1"?"active":""}" 
                               href="actionshop?action=manageSort&&type=1">Tên tăng dần</a></li>
                        <li><a class="dropdown-item ${type eq "2"?"active":""}" 
                               href="actionshop?action=manageSort&&type=2">Tên giảm dần</a></li>
                        <li><a class="dropdown-item ${type eq "3"?"active":""}" 
                               href="actionshop?action=manageSort&&type=3">Giá tăng dần</a></li>
                        <li><a class="dropdown-item ${type eq "4"?"active":""}" 
                               href="actionshop?action=manageSort&&type=4">Giá giảm đần</a></li>
                        <li><a class="dropdown-item ${type eq "5"?"active":""}" 
                               href="actionshop?action=manageSort&&type=5">Ngày thêm vào mới nhất</a></li>
                        <li><a class="dropdown-item ${type eq "6"?"active":""}" 
                               href="actionshop?action=manageSort&&type=6">Ngày thêm vào cũ nhất</a></li>
                        <li><a class="dropdown-item ${type eq "7"?"active":""}" 
                               href="actionshop?action=manageSort&&type=7">Số lượng đã bán nhiều</a></li>
                        <li><a class="dropdown-item ${type eq "8"?"active":""}" 
                               href="actionshop?action=manageSort&&type=8">Số lượng đã bán ít</a></li>
                        <li><a class="dropdown-item ${type eq "9"?"active":""}" 
                               href="actionshop?action=manageSort&&type=9">Số lượng tồn kho nhiều</a></li>
                        <li><a class="dropdown-item ${type eq "10"?"active":""}" 
                               href="actionshop?action=manageSort&&type=10">Số lượng tồn kho ít</a></li>
                    </ul>
                </div>

                <div class="dropdown ms-auto">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
                            style="margin-right: 20px;">
                        Thể loại</button>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item"
                               href="actionshop?action=manageGetFoodByCategory&&cid=all">
                                Tất cả
                            </a>
                        </li>
                        <c:forEach var="c" items="${cList}">
                            <li>
                                <a class="dropdown-item" 
                                   href="actionshop?action=manageGetFoodByCategory&&cid=${c.category_id}">${c.category_name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <table class="table text-center">
                <tr>
                    <th>Mã món ăn</th>
                    <th>Tên món ăn</th>
                    <th>Giá</th>
                    <th>Sô lượng tồn kho</th>
                    <th>Thể loại</th>
                    <th>Ngày thêm vào</th>
                    <th>Hình ảnh</th>
                    <th>Số lượng đã bán</th>
                    <th>Tùy chọn</th>
                </tr>
                <c:forEach var="f" items="${foodOnCurrentPage}">
                    <tr style="vertical-align: middle">
                        <td>${f.foodId}</td>
                        <td>${f.foodName}</td>
                        <td><fmt:formatNumber type="currency" 
                                          currencyCode="VND"
                                          maxFractionDigits="0"
                                          value="${f.price}"/></td>
                        <td>${f.stock}</td>
                        <td>${f.categoryId.category_name}</td>
                        <td><fmt:formatDate value="${f.createDate}" pattern="dd-MM-yyyy"></fmt:formatDate></td>
                        <td><img width="113px" height="113px"  src="${f.image}"></td>
                        <td>${f.sold}</td>
                        <td>
                            <button class="border-0 btn btn-lg" data-bs-toggle="modal" data-bs-target="#updateFood${f.foodId}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>
                            <div class="modal fade text-start" id="updateFood${f.foodId}">
                                <div class="modal-dialog modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Cập nhật món ăn</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">    
                                            <form action="actionshop" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="action" value="updateFood">
                                                <input type="hidden" name="page" value="${n}">

                                                <b>Mã món ăn:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       readonly=""
                                                       value="${f.foodId}"
                                                       name="id"
                                                       >
                                                <b>Tên món ăn:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       value="${f.foodName}"
                                                       required=""
                                                       name="name"
                                                       >
                                                <h5 class="text-danger">${requestScope.errorNameUpdate}</h5>
                                                <b>Giá:</b>
                                                <input type="number"
                                                       class="form-control"
                                                       value="<fmt:formatNumber groupingUsed="false" 
                                                                         value="${f.price}"/>"
                                                       required=""
                                                       name="price"
                                                       min="1000"
                                                       >
                                                <h5 class="text-danger">${requestScope.errorPriceUpdate}</h5>
                                                <b>Số lượng tồn kho:</b>
                                                <input type="number"
                                                       class="form-control"
                                                       value="${f.stock}"
                                                       required=""
                                                       name="stock"
                                                       min="1"
                                                       >
                                                <h5 class="text-danger">${requestScope.errorStockUpdate}</h5>
                                                <b>Thể loại:</b>
                                                <div>
                                                    <select class="form-select" name="cidUpdate">
                                                        <c:forEach var="c" items="${sessionScope.cList}">
                                                            <option value="${c.category_id}" ${f.categoryId.category_name == c.category_name?"selected":""}>
                                                                ${c.category_name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <b>Ngày thêm vào:</b>
                                                <input type="date"
                                                       class="form-control"
                                                       readonly=""
                                                       value="${f.createDate}"
                                                       name="creatDate"
                                                       >
                                                <b>Miêu tả:</b>
                                                <input type="text"
                                                       class="form-control"
                                                       value="${f.description}"
                                                       name="description"
                                                       >
                                                <b>Hình ảnh:</b>
                                                <!--                                                <div class="custom-file-upload" id="fileUploadArea">-->
                                                <label class="form-control mb-3" for="fileInputUpdate${f.foodId}" id="fileLabel">Chọn hình ảnh mới</label>
                                                <input type="file"
                                                       class="form-control mb-3 fileInputUpdate"
                                                       name="image"
                                                       accept=".jpg, .jpeg, .png, .gif"
                                                       id="fileInputUpdate${f.foodId}"
                                                       data-food-id="${f.foodId}"
                                                       style="display: none;"
                                                       >
                                                <!--</div>-->
                                                <input type="hidden" name="imageOld" value="${f.image}">
                                                <div>
                                                    <img id="imagePreviewUpdate${f.foodId}" src="${f.image}" style="max-width: 100%; height: auto; max-height: 300px; object-fit: contain;" />
                                                </div>
                                                <!--                                                <div>
                                                                                                    <img id="imagePreviewUpdate" src="" alt="" style="max-width: 100%; height: auto; max-height: 300px; object-fit: contain;" />
                                                                                                </div>-->
                                                <!--                                                <b>Số lượng đã bán:</b>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       value="${f.sold}"
                                                                                                       required=""
                                                                                                       step="1"
                                                                                                       name="sold"
                                                                                                       >-->

                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${f.foodDelete == 1}">
                                <a class="btn btn-lg btn-danger" 
                                   href="actionshop?action=deleteFood&&deleteId=${f.foodId}&&page=${n}&&foodDelete=0"
                                   onclick="return confirm('Bạn có chắc chắn muốn ẩn món ăn ${f.foodId} ?')">
                                    Ẩn
                                </a>
                            </c:if>
                            <c:if test="${f.foodDelete == 0}">
                                <a class="btn btn-lg btn-danger" 
                                   href="actionshop?action=deleteFood&&deleteId=${f.foodId}&&page=${n}&&foodDelete=1"
                                   onclick="return confirm('Bạn có chắc chắn muốn hiện món ăn ${f.foodId} ?')">
                                    Hiện
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
            <c:if test="${totalPages > 1}">
                <!-- Trang đầu tiên -->
                <li class="page-item">
                    <c:if test="${listSearch != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actionshop?action=manageGetFoodBySearch&&page=1&&search=${search}">1</a>
                    </c:if>
                    <c:if test="${listFoodByCategory != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actionshop?action=manageGetFoodByCategory&&page=1&&cid=${cid}">1</a>
                    </c:if>
                    <c:if test="${listSort != null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actionshop?action=manageSort&&page=1&&type=${type}">1</a>
                    </c:if>
                    <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                        <a class="page-link ${1==currentPage?'active':''}" 
                           href="actionshop?action=manageFood&&page=1">1</a>
                    </c:if>
                </li>

                <!-- Dấu ba chấm nếu cần -->
                <c:if test="${currentPage > 3}">
                    <li class="page-item">
                        <span class="page-link">...</span>
                    </li>
                </c:if>

                <!-- Các trang gần trang hiện tại -->
                <c:forEach var="p" begin="${currentPage-1}" end="${currentPage+1}">
                    <c:if test="${p > 1 && p < totalPages}">
                        <li class="page-item">
                            <c:if test="${listSearch != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actionshop?action=manageGetFoodBySearch&&page=${p}&&search=${search}">${p}</a>
                            </c:if>
                            <c:if test="${listFoodByCategory != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actionshop?action=manageGetFoodByCategory&&page=${p}&&cid=${cid}">${p}</a>
                            </c:if>
                            <c:if test="${listSort != null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actionshop?action=manageSort&&page=${p}&&type=${type}">${p}</a>
                            </c:if>
                            <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                                <a class="page-link ${p==currentPage?'active':''}" 
                                   href="actionshop?action=manageFood&&page=${p}">${p}</a>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>

                <!-- Dấu ba chấm nếu cần -->
                <c:if test="${currentPage < totalPages - 2}">
                    <li class="page-item">
                        <span class="page-link">...</span>
                    </li>
                </c:if>

                <!-- Trang cuối cùng -->
                <li class="page-item">
                    <c:if test="${listSearch != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actionshop?action=manageGetFoodBySearch&&page=${totalPages}&&search=${search}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actionshop?action=manageGetFoodByCategory&&page=${totalPages}&&cid=${cid}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listSort != null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actionshop?action=manageSort&&page=${totalPages}&&type=${type}">${totalPages}</a>
                    </c:if>
                    <c:if test="${listFoodByCategory == null && listSearch == null && listSort == null}">
                        <a class="page-link ${totalPages==currentPage?'active':''}" 
                           href="actionshop?action=manageFood&&page=${totalPages}">${totalPages}</a>
                    </c:if>
                </li>
            </c:if>
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
            var errorPrice = "${requestScope.errorPrice}";
            var errorStock = "${requestScope.errorStock}";
            if (errorName.trim() !== "" || errorPrice.trim() !== "" || errorStock.trim() !== "") {
                $(document).ready(function () {
                    $('#addFood').modal('show');
                });
            }
            var errorNameUpdate = "${requestScope.errorNameUpdate}";
            var errorPriceUpdate = "${requestScope.errorPriceUpdate}";
            var errorStockUpdate = "${requestScope.errorStockUpdate}";
            if (errorNameUpdate.trim() !== "" || errorPriceUpdate.trim() !== "" || errorStockUpdate.trim() !== "") {
                $(document).ready(function () {
                    $('#updateFood${id}').modal('show');
                });
            }
            // doan nay cho xem trc hinh anh sau khi chon
            document.getElementById('fileInputAdd').addEventListener('change', function (event) {
                const file = event.target.files[0];
                if (file) {
                    // Tạo URL tạm thời cho tệp hình ảnh
                    const url = URL.createObjectURL(file);

                    // Cập nhật thuộc tính src của thẻ img
                    const imgElement = document.getElementById('imagePreviewAdd');
                    imgElement.src = url;

                    // Hiển thị thẻ img và thiết lập thuộc tính alt
                    imgElement.style.display = 'block';
                    imgElement.alt = file.name;  // Cập nhật thuộc tính alt để chứa tên file

                    // Giải phóng URL khi không còn sử dụng
                    imgElement.onload = function () {
                        URL.revokeObjectURL(url);
                    };
                } else {
                    // Nếu không có file, ẩn hình ảnh
                    const imgElement = document.getElementById('imagePreviewAdd');
                    imgElement.src = '';
                    imgElement.alt = 'Image Preview';
                    imgElement.style.display = 'none';  // Ẩn thẻ img nếu không có file
                }
            });

            document.querySelectorAll('.fileInputUpdate').forEach(input => {
                input.addEventListener('change', function (event) {
                    const file = event.target.files[0];
                    const foodId = event.target.dataset.foodId;
                    const imgElement = document.getElementById('imagePreviewUpdate' + foodId);

                    if (file) {
                        const url = URL.createObjectURL(file);
                        imgElement.src = url;
                        imgElement.style.display = 'block';
                        imgElement.alt = file.name;
                        imgElement.onload = function () {
                            URL.revokeObjectURL(url);
                        };
                    } else {
                        imgElement.src = '';
                        imgElement.alt = 'Image Preview';
                        imgElement.style.display = 'none';
                    }
                });
            });
        </script>
    </body>
</html>
