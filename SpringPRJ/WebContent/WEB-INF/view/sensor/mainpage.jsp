<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="poly.util.CmmUtil"%>
<% 
	List<String> temp = (List<String>)request.getAttribute("temp");
	List<String> humidity = (List<String>)request.getAttribute("humidity");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>산불 예방 시스템</title>

<link href="/yjcss/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="/yjcss/css/sb-admin-2.css" rel="stylesheet">
<!-- rMateMapChartH5 에서 사용하는 스타일 -->
<link rel="stylesheet" type="text/css" href="/rMateMapChartH5/Assets/rMateMapChartH5.css" />
<!-- rMateMapChartH5 라이센스 -->
<script language="javascript" type="text/javascript" src="/LicenseKey/rMateMapChartH5License.js"></script>
<!-- 실제적인 rMateMapChartH5 라이브러리 -->
<script language="javascript" type="text/javascript" src="/rMateMapChartH5/JS/rMateMapChartH5.js"></script>
<script>
        function getMountainData(){
            var localAreaCode = $('#localAreaCode option:selected').val();
             var cont = ""; //cont 로 해서 화면 보여줘도 되고  , 나중에 html(cont) 이렇게 하는거 말고 다른방식을 알려드림
            $.ajax({
                url:"/getMountainData.do",
                method:"get",
                data:{
                    "localAreaCode":localAreaCode
                },
                success:function(resp){
                    //json parse 는 jsonstring 을  jsonobject 로 바꿔줌
                    console.table(JSON.parse(resp))
                    $.each(JSON.parse(resp).metadata.outputData.items,function(index,data){
                        cont+="<div>";
                        cont+="<span>"+ $('#localAreaCode option:selected').text()+  "</span>";
                        cont+="<span>"+data.analdate  +"  </span>";
                        if(data.meanavg>=0&&data.meanavg<=50){
                            cont+="<span style='color:green'>관심</span>";

                        }else if(data.meanavg>=51&&data.meanavg<66){
                            cont+="<span style='color:yellow'>주의</span>";

                        }else if(data.meanavg>=66&&data.meanavg<86){
                            cont+="<span style='color:orange'>경계</span>";

                        }else {
                            cont+="<span style='color:red'>심각</span>";
                        }
                        cont+="</div>";
                        $('#render').html(cont);

                    })

                },
                error:function(err){

                }
            })
        }

       //select box  값 바꿀떄 마다 실행 onchange 를 해야 값변경할떄 바로 바로 변경됨 onclick 은 클릭한 시점 onchange 는 값을 변경한 시점
       //이거 써주는 이유 dom 이 읽히기전에 id localAreaCode 인것을 못찾아오니 dom(document object Model) 문서 를 한번 읽고 id localAreaCode 찾아야됨
       // api 값 받아오는데 시간이 좀걸리니 자주 select 박스 클릭 안하는게 좋긴함
       $(function(){
           getMountainData();
           $('#localAreaCode').change (function(){
               getMountainData();
           })

       })

    </script>
 <style type="text/css">	
	/* banner */
	.banner {position: relative; width: 100px; height: 50px; top: 20px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 100px; height: 50px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script language="JavaScript">

	$(document).ready(function() {
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $length = $banner.children().length;//이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 5000);//다음 이미지로 롤링 애니메이션 할 시간차
    
		function rollingStart() {
			$banner.css("width", $bannerWidth * $length + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- 상단 제목 -->
				<div class="sidebar-brand-text mx-3">
					<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/sensor/mainpage.do">
						산불 예방 시스템
					</a>
				</div>

			<!-- 산 메뉴 -->
			<hr class="sidebar-divider my-0">
			<hr class="sidebar-divider" />
			<div class="sidebar-heading">Mountain menu...</div>
			<!-- ㄱ-ㄹ까지의 산 목록  -->
			<ul id="main-menu">
				<li><a href="#"><h5>ㄱ-ㄹ</h5></a>
					<ul id="sub-menu">
						<li><a href="detailpage.do?value=">관악산 </a></li>
						<li><a href="#">개양산 </a></li>
						<li><a href="#">괴산 </a></li>
						<li><a href="#">갈기산 </a></li>
						<li><a href="#">갑장산</a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅁ-ㅅ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">무봉산 </a></li>
						<li><a href="#">무이산 </a></li>
						<li><a href="#">마야산 </a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅇ-ㅊ</h5></a>
					<ul id="sub-menu">
						<li><a href="detailpage.do?value=우장산">우장산 </a></li>
						<li><a href="#">유달산 </a></li>
						<li><a href="#">유학산 </a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅋ-ㅎ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">한라산 </a></li>
						<li><a href="#">함지산 </a></li>
						<li><a href="#">호방산 </a></li>
						<li><a href="#">화방산 </a></li>
						<li><a href="#">학산 </a></li>
					</ul></li>
			</ul>
		</ul>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- 검색창 -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<div><h1 class="h3 mb-0 text-gray-800">오늘의 환경</h1></div>
					</div>
					<!-- Content Row -->
					 <div class="row">

						<!-- Earnings (Monthly) Card Example -->

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-success text-uppercase mb-1"
												style="text-align: center">지역</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align: center; margin: 5px;">
												<div class="banner">
													<ul>
														<li>서울</li>
														<li>춘천</li>
														<li>청주</li>
														<li>수원</li>
														<li>대전</li>
														<li>대구</li>
														<li>광주</li>
														<li>목포</li>
														<li>울산</li>
														<li>부산</li>
														<li>제주</li>
													</ul>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-temperature-low fa-3x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-success text-uppercase mb-1"
												style="text-align: center">기온</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800"
												style="text-align: center; margin: 5px;">
												<div class="banner">
													<ul>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														<li>${temp.get(0)}</li>
														
													</ul>
												</div>
											</div>
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
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1"
												style="text-align: center">습도</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align: center; margin: 5px;">
												<div class="banner">
													<ul>
														<li>${humidity.get(0).get(1)}</li>
														<li>${humidity.get(1).get(1)}</li>
														<li>${humidity.get(2).get(1)}</li>
														<li>${humidity.get(3).get(1)}</li>
														<li>${humidity.get(4).get(1)}</li>
														<li>${humidity.get(5).get(1)}</li>
														<li>${humidity.get(6).get(1)}</li>
														<li>${humidity.get(7).get(1)}</li>
														<li>${humidity.get(8).get(1)}</li>
														<li>${humidity.get(9).get(1)}</li>
														<li>${humidity.get(10).get(1)}</li>
														
													</ul>
												</div>
											</div>
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
											<div
												class="text-xs font-weight-bold text-warning text-uppercase mb-1"
												style="text-align: center">
												<h7>풍속</h7>
											</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800" style="text-align: center; margin: 5px;">
												<div class="banner">
													<ul>
														<li>${humidity.get(0).get(2)}</li>
														<li>${humidity.get(1).get(2)}</li>
														<li>${humidity.get(2).get(2)}</li>
														<li>${humidity.get(3).get(2)}</li>
														<li>${humidity.get(4).get(2)}</li>
														<li>${humidity.get(5).get(2)}</li>
														<li>${humidity.get(6).get(2)}</li>
														<li>${humidity.get(7).get(2)}</li>
														<li>${humidity.get(8).get(2)}</li>
														<li>${humidity.get(9).get(2)}</li>
														<li>${humidity.get(10).get(2)}</li>
														
													</ul>
												</div>
											</div>
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
						<div class="col-xl-6 col-lg-10 mb-8">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header ">
									<h6 class="m-0 font-weight-bold text-primary" align="center">전국지도</h6>
									<div class="dropdown no-arrow"></div>
								</div>
								 <!-- Card Body -->
								<div class="card-body">
									<div class="dropdown no-arrow">
										<div id="mapHolder" style="width: 100%; height: 450px;">
											<div>
												<script>
												//rmate 맵차트 생성준비가 완료된 상태시 호출할 함수 지정
												var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";
												var id = "map1";
												//
												function mapReadyHandler(id) {
													 document.getElementById(id).setLayout(layoutStr);
													 document.getElementById(id).setData(mapData);
													 document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
													 document.getElementById(id).setSourceURLEx(sourceURL);
													}
												var mapDataBaseURL = "/rMateMapChartH5/MapDataBaseXml/SouthKorea_Design_01.xml";
												var sourceURL = "/rMateMapChartH5/MapSource/SouthKorea_Design_01.svg";
												var na = "https://naver.com";
												var layoutStr = '<?xml version="1.0" encoding="utf-8"?><rMateMapChart><MapChart id="mainMap1" showDataTips="true" dataTipType="Type2"><series><MapSeries id="mapseries" interactive="true" selectionMarking="color" color="#777777" labelPosition="none" displayName="Map" selectionStrokeAlpha="0" rollOverFill="transparent" transparentValue="60"><selectionFill><SolidColor color="#ffffff" /></selectionFill><selectionStroke><Stroke color="#ffffff" weight="0" alpha="1"/></selectionStroke><rollOverStroke><Stroke color="#ffffff" weight="0" alpha="1"/></rollOverStroke><showDataEffect><SeriesInterpolate duration="1000"/></showDataEffect></MapSeries><MapImageSeries id="image" labelField="label" imageUrlField="imgurl" horizontalCenterGapField="h" verticalCenterGapField="v" color="#ffffff" labelPosition="bottom" displayName="날씨" imageWidth="57" imageHeight="55" selectedFill="#0f0" interactive="false" disabledColor="#ffffff" areaCodeField="icode"><showDataEffect><SeriesSlide duration="1000"/></showDataEffect></MapImageSeries></series></MapChart></rMateMapChart>';
												
												var mapData = [
														{ "icode":100, "id":"w01", "label":"설악산", "temperature":10, "imgurl":"/rMateMapChartH5/Images/mountain.png", "v":-10, "h":10 },
														{ "icode":1500, "id":"w02", "label":"서대산", "temperature":10,  "imgurl":"/rMateMapChartH5/Images/mountain.png", "v":-30, "h":0 },
														{ "icode":1300, "id":"w03", "label":"덕유산", "temperature":10,  "imgurl":"/rMateMapChartH5/Images/mountain.png", "v":-20, "h":-10 },
														{ "icode":1200, "id":"w04", "label":"지리산", "temperature":10,  "imgurl":"/rMateMapChartH5/Images/mountain.png", "v":-10, "h":0 },
														{ "icode":400, "id":"w05", "label":"금오산", "temperature":10, "imgurl":"/rMateMapChartH5/Images/mountain.png", "v":-20, "h":20 }
														];
												
												rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%"); //함수 호출

												
											</script>
											</div>
										</div>
									</div>
								</div> 
							</div>
						</div>

						<!-- 건조 주의보 -->
						<div class="col-xl-6 col-lg-10 mb-8 ">
							<div class="card shadow mb-4">
								<div class="card-header ">
									<h6 class="m-0 font-weight-bold text-primary" align="center">산불위험도</h6>
									<div class="dropdown no-arrow"></div>
								</div>
								<div class="card-body">
									<div class="mt-4 text-center small"style="width: 100%; height: 425px;">
									<select id="localAreaCode" style="width: 200px; heigh: 50px;">
										    <option value="11" selected>서울</option>
										    <option value="26">부산</option>
										    <option value="27">대구</option>
										    <option value="28">인천</option>
										    <option value="29">광주</option>
										    <option value="30">대전</option>
										    <option value="31">울산</option>
										    <option value="36">세종</option>
										    <option value="41">경기</option>
										    <option value="42">강원</option>
										    <option value="43">충북</option>
										    <option value="44">충남</option>
										    <option value="45">전북</option>
										    <option value="46">전남</option>
										    <option value="47">경북</option>
										    <option value="48">경남</option>
										    <option value="50">제주도</option>
										</select>
										<div id="render"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
</body>

</html>
