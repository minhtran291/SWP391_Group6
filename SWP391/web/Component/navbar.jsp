<%-- 
    Document   : navbar
    Created on : Mar 5, 2023, 4:03:04 PM
    Author     : toden
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="height: 118px" >
    <div class="container-fluid">
        
        <a class="navbar-brand" href="ProductList"><img src="https://lh3.googleusercontent.com/pw/AP1GczNyn7_b0JhbayoCp2uYkvpOGcCcYKIwgxVfv8xK6aS1FjAlu5_BF2VStqalCEpqWL66vbRjQAr8pwAaLS4sCUSEvAmuxQKatO6-cM7GrOsbuokIb0iJCFGhcHPohYtnClgDa4uhUEefj9D9WDOY0rnVxrG37Oc0PVIpB3tZUkxU-hd1DZlutYsjtlKfzZJLkT9SI1_jWgT8K8VGhC8osscZEVNbJIH59NWCD8pupNpjADncGuuh2PU43TUcKyXxve-F_-fSQB3OxKuoXrMVLO3WnzGuCNLsRF_oOsbLDEc3evtUXCB_FGGOhrA12TxWRFEeYQEq26AdDwro3IAMq_GtzsFk9Fk2ymVsXDUOZEXyX85Ia2yHXmxYMjp53GD6QQF75f5HNCu_G_LBZhGBVo_SYS_0CVIA_oQ-jxVfU48YPF-mxJLhJPx3XFRJyYS-L-AR0yzWcXWFWhvOe4BvU4GFEtXdMh_DgIb5sZPfHvFbDMB_SvcenWgPZU5caNwm1EB8rk5rpii4Cx3f9TdbICF26Ie47U9DQsrP2bMQkSGfnSLCGnTP6OJnbQAtHV_k0BYWWZxwy0D4_UDKede6ZDD9eyv7eucNBCFw0dtSgCkPl8wg0LazNNR5Q7sB8WHmfM_04NchxUUhtSDQEHfqqnNE1q5u_aVKxkRC_gpuBoJbylD7_R-0rbxFVWod4fXIfMRvZXeYCseVCG3OXeaJv2JQsOl6w-rqsx_uk2XrSlXnvr2nj3TpKLVRoLxKMB7js_aZWM_mAs_DSSaciQR8JqtSC2OoJYglviMztzxrp9GzzDMFYPwgi6jblUvACBckxFGU0tfl3Qze7GfOMreuLM7TIkKmUilFi0kMQzXAb326zthfYT1OvejCb998I8HAfScO6Q2uQIJniBUcq2F_1N4=w228-h219-s-no-gm?authuser=0" height="110px"> </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="ProductList">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Dropdown
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Action</a></li>
                        <li><a class="dropdown-item" href="#">Another action</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                </li>
            </ul>
            <form method="get" action="ProductList" class="d-flex" style="margin-right: 50px">
                <input name="search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
                <c:choose>
                    <c:when test="${sessionScope.Account!=null}">
                        <div class="ml-4 d-flex mt-3 mr-3">
                            <i class="fa-solid fa-user-tie fa-2xl m-2"></i>
                            <a href="#"><h5>${Account.getAccountName()}</h5></a>

                            <c:if test="${sessionScope.Cart!=null&&sessionScope.Cart.size()>0}">
                                <a href="cart.jsp"><i class="fa-solid fa-cart-arrow-down fa-2xl m-2"></i></a>
                            </c:if>
                            <c:if test="${sessionScope.Cart==null||sessionScope.Cart.size()==0}">
                            <a href="cart.jsp"><i class="fa-solid fa-cart-shopping fa-2xl m-2" style="color: black"></i></a>
                                </c:if>
                        </div>
                        <a href="LogOut" style="margin-left: 5px;"><button name="logout" style="width: 100px; height: 50px" class="btn btn-primary" type="button">Log Out</button></a>
                    </c:when>
                    <c:otherwise>
                        <a href="signIn.jsp" style="margin-left: 5px;"><button style="width: 100px; height: 50px" class="btn btn-primary" type="button">Sign In</button></a>
                    </c:otherwise>    
                </c:choose>


            </form>
        </div>
    </div>
</nav>