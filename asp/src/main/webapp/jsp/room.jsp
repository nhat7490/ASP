﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Web Manage</title>

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="../vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="../vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<div id="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="room.html">Trang Quản Lý</a>
        </div>

        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown open">
            <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
            </li>
            </li>
        </ul>

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li>
                        <a href="user.html"><i class="fa fa-table fa-fw"></i>Quản lý người dùng</a>
                    </li>
                    <li>
                        <a href="room.html"><i class="fa fa-table fa-fw"></i>Danh sách phòng</a>
                    </li>

                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>

    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Quản lý phòng</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Danh sách phòng
                    </div>
                    <!-- /.panel-heading -->
                    <c:set var="sizes" value="${[10, 20, 50]}"/>
                    <div style="padding: 0px 15px; font-size: 2rem;">
                        Hiển thị
                        <select onchange="handleOnChange(${requestScope.CURRENTPAGE}, event.target.value)" id="page-size">
                            <c:forEach var="size" items="${sizes}">
                                <c:if test="${requestScope.SIZE eq size}">
                                    <option selected value="${size}">${size}</option>
                                </c:if>
                                <c:if test="${requestScope.SIZE ne size}">
                                    <option value="${size}">${size}</option>
                                </c:if>
                                <%--<option value="${size}">${size}</option>--%>
                            </c:forEach>
                        </select> phòng
                    </div>
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover"
                               id="dataTables-example">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Phòng</th>
                                <th>Diện tích</th>
                                <th>Giá</th>
                                <th>Ngày đăng</th>
                                <th>Địa chỉ</th>
                                <th>Hình ảnh</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="roomList" value="${requestScope.ROOMS}"/>
                            <c:forEach var="room" items="${roomList}">
                                <tr>
                                    <td>${room.roomId}</td>
                                    <td>${room.name}</td>
                                    <td>${room.area}</td>
                                    <td class="center">${room.price}</td>
                                    <td>${room.dateCreated}</td>
                                    <td class="center">${room.address}</td>
                                    <td>
                                        <button type="button" class="btn btn-primary" style="width: 100px"
                                                data-toggle="modal"
                                                data-target="#myModal">Xem
                                        </button>
                                    </td>
                                    <div class="modal fade" id="myModal" role="dialog">
                                        <div class="modal-dialog">

                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;
                                                    </button>
                                                    <h4 class="modal-title">Hình Ảnh Phòng</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <c:forEach var="image" items="${room.imageUrls}">
                                                        <img src="${image}" style="width: 100%; margin-bottom:10px">
                                                    </c:forEach>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">
                                                        Close
                                                    </button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    <td>
                                        <button type="button" class="btn btn-success">Chứng Thực</button>&nbsp;&nbsp;&nbsp;<button
                                            type="button"
                                            class="btn btn-danger">
                                        Từ Chối
                                    </button>
                                    </td>
                                </tr>

                            </c:forEach>
                            </tbody>
                        </table>

                        <ul class="pagination pagination-lg">
                            <c:set var="totalPage" value="${requestScope.PAGE}"/>
                            <c:set var="currentPage" value="${requestScope.CURRENTPAGE}"/>

                            <c:if test="${currentPage eq 1}">
                                <li><a>Previous</a></li>
                                <c:forEach var="i" begin="1" end="${totalPage}">
                                    <li onclick="changePage(${i})">
                                        <a>
                                                ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li><a href="/room?page=${currentPage+1}">Next</a></li>
                            </c:if>

                            <c:if test="${currentPage eq totalPage }">
                                <li><a href="/room?page=${currentPage-1}">Previous</a></li>
                                <c:forEach var="i" begin="1" end="${totalPage}">
                                    <li onclick="changePage(${i})">
                                        <a>
                                                ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li><a>Next</a></li>
                            </c:if>

                            <c:if test="${currentPage gt 1 && currentPage lt totalPage}">
                                <li><a href="/room?page=${currentPage-1}">Previous</a></li>
                                <c:forEach var="i" begin="1" end="${totalPage}">
                                    <li onclick="changePage(${i})">
                                        <a>
                                                ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li><a href="/room?page=${currentPage+1}">Next</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

<!-- /#wrapper -->

<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../vendor/metisMenu/metisMenu.min.js"></script>

<!-- DataTables JavaScript -->
<%--<script src="../vendor/datatables/js/jquery.dataTables.min.js"></script>--%>
<script src="../vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="../vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../dist/js/sb-admin-2.js"></script>

<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
    $(document).ready(function () {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });

    function handleOnChange(page, size){
        window.location = "/room?page="+page+"&size="+size;
    }

    function changePage(page) {
        var size = document.getElementById("page-size").value;
        window.location = "/room?page=" + page + "&size=" + size;
    }
</script>

</body>

</html>
