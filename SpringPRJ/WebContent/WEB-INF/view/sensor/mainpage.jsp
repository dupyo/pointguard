<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>산불 예방 시스템</title>

  <link href="/a/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="/a/css/sb-admin-2.css" rel="stylesheet">
  <!-- rMateMapChartH5 에서 사용하는 스타일 -->
  <link rel="stylesheet" type="text/css" href="/rMateChartH5/JS/rMateChartH5.css"/>
  <!-- rMateMapChartH5 라이센스 -->
 <script language="javascript" type="text/javascript" src="/rMateChartH5/LicenseKey/rMateChartH5License.js"></script>
 
 
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
           Mountain menu...
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
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">오늘의 환경</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="text-align:center">지역</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align:center; margin:5px;"><h1>${loc.get(0)}</h1></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1" style="text-align:center">기온</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align:center; margin:5px;"><h1>${temp.get(0)}</h1></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-temperature-low fa-3x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
           <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"style="text-align:center">습도</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align:center; margin:5px;"><h1>${humidity.get(0)}</h1></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-80 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1" style="text-align:center"><h7>풍속</h7></div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"style="text-align:center; margin:5px;"><h1>${wind.get(0)}</h1></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-wind fa-3x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

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
										
									</div>
								</div>
							</div>
							</div>

							<!-- 건조 주의보 -->
							<div class="col-xl-3 col-lg-8 mb-8"  >
								<div class="card shadow mb-4">
									<!-- Card Header - Dropdown -->
									<div class="card-header ">
										<h6 class="m-0 font-weight-bold text-primary" align="center">기상특보</h6>
										<div class="dropdown no-arrow" ></div>
									</div>
									<!-- Card Body -->
									<div class="card-body">
										<div class="chart-pie pt-4 pb-2"></div>
										<div class="mt-4 text-center small" style="width: 100%; height: 300px;"></div>
									</div>
								</div>
							</div>
							<!-- 건조주의보 -->
							<div class="col-xl-3 col-lg-8">
								<div class="card shadow mb-4">
									<!-- Card Header - Dropdown -->
									<div class="card-header ">
										<h6 class="m-0 font-weight-bold text-primary" align="center">산불위험도</h6>
										<div class="dropdown no-arrow"></div>
									</div>
									<!-- Card Body -->
									<div class="card-body">
										<div class="chart-pie pt-4 pb-2"></div>
										<div class="mt-4 text-center small" style="width: 100%; height: 300px;"></div>
									</div>
								</div>
							</div>
							</div>
							
						${img}
          
</body>

</html>