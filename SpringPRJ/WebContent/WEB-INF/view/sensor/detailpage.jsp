<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>산불 예방 시스템</title>

<!-- Custom fonts for this template-->
<link
	href="/yjcss/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- rMate 지도 스타일 -->
<!-- Custom styles for this template-->
 <link href="/yjcss/css/sb-admin-2.css" rel="stylesheet">
 <style>
 
	.main{
	}
	.main_common{
		display : inline;
		width: 33%;
		height: 50%;
		border : 1px solid blue;
	}	
</style>

</head>

<body id="page-top">

	 <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- 상단 제목 -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/sensor/index.do">
        <div class="sidebar-brand-text mx-3">산불 예방 시스템</div>
      </a>

      <!-- 산 메뉴 -->
      <hr class="sidebar-divider my-0">
      <hr class="sidebar-divider"/>
      <div class="sidebar-heading">
           Mountain menu
      </div>
      <!-- ㄱ-ㄹ까지의 산 목록  -->
			    <ul id ="main-menu">
					<li><a href="#"><h5>ㄱ-ㄹ</h5></a>
						<ul id ="sub-menu">
							<li><a href="#">관악산 </a></li>
							<li><a href="#">개양산 </a></li>
							<li><a href="#">괴산 </a></li>
							<li><a href="#">갈기산 </a></li>
							<li><a href="#">갑장산</a></li>
						</ul>
					</li>
				</ul>
			    <ul id ="main-menu">
					<li><a href="#"><h5>ㅁ-ㅅ</h5></a>
						<ul id ="sub-menu">
							<li><a href="#">가야산 </a></li>
							<li><a href="#">금강산 </a></li>
							<li><a href="#">고블린 </a></li>
						</ul>
					</li>
				</ul>
			    <ul id ="main-menu">
					<li><a href="#"><h5>ㅇ-ㅊ</h5></a>
						<ul id ="sub-menu">
							<li><a href="#">가야산 </a></li>
							<li><a href="#">금강산 </a></li>
							<li><a href="#">고블린 </a></li>
						</ul>
					</li>
				</ul>
			    <ul id ="main-menu">
					<li><a href="#"><h5>ㅋ-ㅎ</h5></a>
						<ul id ="sub-menu">
							<li><a href="#">가야산 </a></li>
							<li><a href="#">금강산 </a></li>
							<li><a href="#">고블린 </a></li>
						</ul>
					</li>
				</ul>
		     </ul>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <!-- Main Content -->
      <div id="content">
        <!-- 검색창 -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- 검색창 -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" action="/sensor">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>
        </nav>
					<!-- Content Row -->

					<div class="row">

						<!-- 지도 api -->
						<div class="col-xl-6 col-lg-8 mb-8">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header ">
									<h6 class="m-0 font-weight-bold text-primary" align="center">전국지도</h6>
									<div class="dropdown no-arrow"></div>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="dropdown no-arrow">
										<div id="map" style="width: 100%; height: 400px;"></div>

										<script type="text/javascript"
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=767d28fae545a0f72f93cd6018b21d63"></script>
										<script>
											var mapContainer = document
													.getElementById('map'), // 지도를 표시할 div 
											mapOption = {
												center : new kakao.maps.LatLng(
														36.996660, 127.900067), // 지도의 중심좌표
												level : 12
											// 지도의 확대 레벨
											};

											// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
											var map = new kakao.maps.Map(
													mapContainer, mapOption);
										</script>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-6 col-lg-8 mb-8">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header ">
									<h6 class="m-0 font-weight-bold text-primary" align="center">위험도</h6>
									<div class="dropdown no-arrow"></div>
								</div>
								<!-- Card Body -->
								<div class="main">
									<div class="main_1 main_common">test1</div>
									<div class="main_2 main_common">test2</div>
									<div class="main_3 main_common">test3</div>
								</div>
								<div class="main">
									<div class="main_1 main_common">test1</div>
									<div class="main_2 main_common">test2</div>
									<div class="main_3 main_common">test3</div>
								</div>
							</div>
						</div>
					</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>센서 이름</th>
											<th>시간</th>
											<th>Co2</th>
											<th>온도</th>
											<th>습도</th>
											<th>위도</th>
											<th>경도</th>
										</tr>
									</thead>
								</table>
							</div>
</body>

</html>
