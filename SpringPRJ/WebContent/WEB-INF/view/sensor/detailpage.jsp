<%@page import="poly.util.CmmUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.SensorInfoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%
	String ss_id = (String)request.getAttribute("SS_ID");
	List<SensorInfoDTO> sList = (List<SensorInfoDTO>)request.getAttribute("sList");
	
	if(sList.size() == 0) {
		sList = new ArrayList<SensorInfoDTO>();
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/js/echarts.min.js"></script>

<title>산불 예방 시스템</title>

<!-- Custom fonts for this template-->
<link href="/yjcss/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="/yjcss/css/sb-admin-2.css" rel="stylesheet">
<script>
   var bgc = "#ffffff";
   var bgc2 = "#ffffff";
   var bgc3 = "#ffffff";
   var sensor1_ss_val_g_val = 0;
   var sensor2_ss_val_g_val = 0;
   var sensor1_ss_loc_x = 0;
   var sensor1_ss_loc_y = 0;
   var sensor1_ss_val_temp_val = 0;
   var sensor1_ss_val_temp_val_p = 0;
   var sensor2_ss_loc_x = 0;
   var sensor2_ss_loc_y = 0;
   var sensor2_ss_val_temp_val = 0;
   var sensor2_ss_val_temp_val_p = 0;
   var fire_loc_x = 0;
   var fire_loc_y = 0;
   var firedist = 0;
   var dist = 0;
</script>
<script>
	function search(name){
		console.log(name);
		if(name.length ==0){
			$(name).focus();
			alert("no data");
			return false;
		}
		  $.ajax({
			url : '/sensor/sensorDataList.do',
			type : 'post',
			data : {"name" : name},
			success : function(data) {
				$("#resContainer").html(data);
			},
			error:function (e){
				alert("err");
				console.log(e)
			}
		}) 
	}
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
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="/sensor/mainpage.do">
				<div class="sidebar-brand-text mx-3">산불 예방 시스템</div>
			</a>

			<!-- 산 메뉴 -->
			<hr class="sidebar-divider my-0">
			<hr class="sidebar-divider" />
			<div class="sidebar-heading">Mountain menu</div>
			<!-- ㄱ-ㄹ까지의 산 목록  -->
			<ul id="main-menu">
				<li><a href="#"><h5>ㄱ-ㄹ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">관악산 </a></li>
						<li><a href="#">개양산 </a></li>
						<li><a href="#">괴산 </a></li>
						<li><a href="#">갈기산 </a></li>
						<li><a href="#">갑장산</a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅁ-ㅅ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">가야산 </a></li>
						<li><a href="#">금강산 </a></li>
						<li><a href="#">고블린 </a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅇ-ㅊ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">가야산 </a></li>
						<li><a href="#">금강산 </a></li>
						<li><a href="#">고블린 </a></li>
					</ul></li>
			</ul>
			<ul id="main-menu">
				<li><a href="#"><h5>ㅋ-ㅎ</h5></a>
					<ul id="sub-menu">
						<li><a href="#">가야산 </a></li>
						<li><a href="#">금강산 </a></li>
						<li><a href="#">고블린 </a></li>
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

					<!-- 검색창 -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
						action="/sensor">
						<div class="input-group">
							<div>
						<h1 class="h3 mb-0 text-gray-800">
							<%=request.getAttribute("M_Name") %></h1>
					</div>
						</div>
					</form>
				</nav>
				<div class="row">

					<!-- Page Heading -->

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

									<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a398788e01a2ef914dd4ccba0bb6e698"></script>
									<script>
									var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
									    mapOption = { 
									        center: new kakao.maps.LatLng(<%=request.getAttribute("M_Loc_x") %>, <%=request.getAttribute("M_Loc_y") %>), // 지도의 중심좌표
									        level: 2 // 지도의 확대 레벨
									    };
									var map = new kakao.maps.Map(mapContainer, mapOption); 
									
											var positions = [
																
															    {
															        title: '<%=CmmUtil.nvl(sList.get(0).getSs_id())%>', 
															        latlng: new kakao.maps.LatLng(<%=CmmUtil.nvl(sList.get(0).getSs_loc_x())%>,<%=CmmUtil.nvl(sList.get(0).getSs_loc_y())%>)
															    },
															    {
															        title: '<%=CmmUtil.nvl(sList.get(1).getSs_id())%>', 
															        latlng: new kakao.maps.LatLng(<%=CmmUtil.nvl(sList.get(1).getSs_loc_x())%>,<%=CmmUtil.nvl(sList.get(1).getSs_loc_y())%>)
															    },
															    {
															        title: '<%=CmmUtil.nvl(sList.get(2).getSs_id())%>', 
															        latlng: new kakao.maps.LatLng(<%=CmmUtil.nvl(sList.get(2).getSs_loc_x())%>,<%=CmmUtil.nvl(sList.get(2).getSs_loc_y())%>)
															    }
															    
															];
											// 마커를 생성합니다
											var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
													for (var i = 0; i < positions.length; i ++) {
													    
													    // 마커 이미지의 이미지 크기 입니다
													    var imageSize = new kakao.maps.Size(24, 35); 
													    
													    // 마커 이미지를 생성합니다    
													    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
													    
													    // 마커를 생성합니다
													    var marker = new kakao.maps.Marker({
													        map: map, // 마커를 표시할 지도
													        position: positions[i].latlng, // 마커를 표시할 위치
													        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
													        image : markerImage // 마커 이미지 
													    });
													}
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
							<div class="card-body">
								<div class="row">
									<div class="col-6 col-md-4"> <div id="main" style="width: 200px;height:300px;background-color:#ffffff;"></div></div>
									<div class="col-6 col-md-4"> <div id="main2" style="width: 200px;height:300px;background-color:#ffffff;"></div></div>
									<div class="col-6 col-md-4"> <div id="main3" style="width: 200px;height:300px;background-color:#ffffff;"></div></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<div class="card-body">
			<%for(int i=0; i < sList.size(); i++){ %>
				<a href="JavaScript:search('<%=CmmUtil.nvl(sList.get(i).getSs_id()) %>');"  class="btn btn-success btn-circle"><%= i+1 %></a>
			<%} %>
			</div>
			<div id="resContainer"> </div>
			</div>
		</div>
		<script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart = echarts.init(document.getElementById('main'));
        var option = {
              title: {
                   text: '센서_1',
               },
               tooltip: {
                   trigger: 'axis',
                   axisPointer: {
                       type: 'cross',
                       label: {
                           backgroundColor: '#283b56'
                       }
                   }
               },
               xAxis: {
                   type: 'category',
                   boundaryGap: true,
                    data: (function (){
                        var now = new Date();
                        var res = [];
                        var len = 7;
                        while (len--) {
                            res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
                            now = new Date(now-60000);
                        }
                        return res;
                    })()
               },
               dataZoom: {
                   show: false,
                   start: 0,
                   end: 100
               },
               yAxis: {
                   type: 'value',
                   scale : true,
                   max : 5,
                   min : 0,
               },
               series: [{
                  name : 'G값',
                   type: 'line',
                   lineStyle : {
                      color:'#2A265C'
                   },
                   smooth: true,
                   data: (function (){
                        var res = [];
                        var len = 8;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               },
               {
                    name: '경고값',
                    type: 'line',
                    lineStyle:{
                    color:'#D7DF01' //line차트 색상 변경
                 },
                    smooth: true, //부드러운 line 표현
                    yAxisIndex: 0, //yAxis 1번째 사용
                    data: (function (){
                        var res = [];
                        var len = 0;
                        while (len < 20) {
                            res.push(1.8); //랜덤 데이터 생성
                            len++;
                        }
                        return res;
                    })()
                    , symbol : "none"},
                    {
                        name: '위험값',
                        type: 'line',
                        lineStyle:{
                        color:'#DF0101' //line차트 색상 변경
                     },
                        smooth: true, //부드러운 line 표현
                        yAxisIndex: 0, //yAxis 1번째 사용
                        data: (function (){
                            var res = [];
                            var len = 0;
                            while (len < 20) {
                                res.push(3.6); //랜덤 데이터 생성
                                len++;
                            }
                            return res;
                        })()
                        , symbol : "none"}]
           };

           myChart.setOption(option);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data0 = option.series[0].data; //순수익 데이터
               
               //데이터의 가장 왼쪽 값을 제거
               data0.shift();
               
               var mainObj = document.getElementById("main");
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
            	   data0.push(json.ss_val_g_val);
            	   if (json.ss_val_g_val < 1.8) {
                       bgc2 = "#ffffff";
                    }
                    else if (json.ss_val_g_val >= 1.8 && json < 3.6) {
                       bgc2 = "#fff091";
                    }
                    else if (json.ss_val_g_val >= 3.6) {
                       bgc2 = "#ffa6a6";
                    }

            	   mainObj.style.backgroundColor = bgc2;
                   sensor1_ss_loc_x = json.ss_loc_x*1000000;
                   sensor1_ss_loc_y = json.ss_loc_y*1000000;
                   sensor1_ss_val_temp_val = json.ss_val_temp_val;
                   sensor1_ss_val_temp_val_p = json.ss_val_temp_val_p;
                   sensor1_ss_val_g_val = json.ss_val_g_val;
                   console.log(sensor1_ss_loc_x);
                   console.log(sensor1_ss_loc_y);
                   
                   fireloc()
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option.xAxis.data.shift();
               option.xAxis.data.push(axisData);

              //차트에 반영
               myChart.setOption(option);
           }, 10010);
    </script>
    
    <!--==================================================================================================================================  -->
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart2 = echarts.init(document.getElementById('main2'));
        var seq = 480;
        var option2 = {
              title: {
                   text: '센서_2',
               },
               tooltip: {
                   trigger: 'axis',
                   axisPointer: {
                       type: 'cross',
                       label: {
                           backgroundColor: '#283b56'
                       }
                   }
               },
               xAxis: {
                   type: 'category',
                   boundaryGap: true,
                    data: (function (){
                        var now = new Date();
                        var res = [];
                        var len = 7;
                        while (len--) {
                            res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
                            now = new Date(now-60000);
                        }
                        return res;
                    })()
               },
               dataZoom: {
                   show: false,
                   start: 0,
                   end: 100
               },
               yAxis: {
                   type: 'value',
                   scale : true,
                   max : 5,
                   min : 0,
               },
               series: [{
                  name : 'G값',
                   type: 'line',
                   lineStyle : {
                      color:'#2A265C'
                   },
                   smooth: true,
                   data: (function (){
                        var res = [];
                        var len = 8;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               },
               {
                    name: '경고값',
                    type: 'line',
                    lineStyle:{
                    color:'#D7DF01' //line차트 색상 변경
                 },
                    smooth: true, //부드러운 line 표현
                    yAxisIndex: 0, //yAxis 1번째 사용
                    data: (function (){
                        var res = [];
                        var len = 0;
                        while (len < 20) {
                            res.push(1.8); //랜덤 데이터 생성
                            len++;
                        }
                        return res;
                    })()
                    , symbol : "none"},
                    {
                        name: '위험값',
                        type: 'line',
                        lineStyle:{
                        color:'#DF0101' //line차트 색상 변경
                     },
                        smooth: true, //부드러운 line 표현
                        yAxisIndex: 0, //yAxis 1번째 사용
                        data: (function (){
                            var res = [];
                            var len = 0;
                            while (len < 20) {
                                res.push(3.6); //랜덤 데이터 생성
                                len++;
                            }
                            return res;
                        })()
                        , symbol : "none"}]
           };

           myChart2.setOption(option2);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData2 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
               var data2 = option2.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data2.shift();
               
               var main2Obj = document.getElementById("main2");
            //ajax 구문 추가
           $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_2&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
            	   data2.push(json.ss_val_g_val);
                   if (json.ss_val_g_val < 1.8) {
                      bgc2 = "#ffffff";
                   }
                   else if (json.ss_val_g_val >= 1.8 && json < 3.6) {
                      bgc2 = "#fff091";
                   }
                   else if (json.ss_val_g_val >= 3.6) {
                      bgc2 = "#ffa6a6";
                   }
                   main2Obj.style.backgroundColor = bgc2;
                   
                   sensor2_ss_loc_x = json.ss_loc_x*1000000;
                   sensor2_ss_loc_y = json.ss_loc_y*1000000;
                   sensor2_ss_val_temp_val = json.ss_val_temp_val;
                   sensor2_ss_val_temp_val_p = json.ss_val_temp_val_p;
                   sensor2_ss_val_g_val = json.ss_val_g_val;
                   console.log(sensor2_ss_loc_x);
                   console.log(sensor2_ss_loc_y);

               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option2.xAxis.data.shift();
               option2.xAxis.data.push(axisData2);

              //차트에 반영
               myChart2.setOption(option2);
           }, 10000);
           
    </script>
<!-- =============================================================================================== -->
   <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart3 = echarts.init(document.getElementById('main3'));
        var seq = 480;
        var option3 = {
              title: {
                   text: '센서_3',
               },
               tooltip: {
                   trigger: 'axis',
                   axisPointer: {
                       type: 'cross',
                       label: {
                           backgroundColor: '#283b56'
                       }
                   }
               },
               xAxis: {
                   type: 'category',
                   boundaryGap: true,
                    data: (function (){
                        var now = new Date();
                        var res = [];
                        var len = 7;
                        while (len--) {
                            res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
                            now = new Date(now-60000);
                        }
                        return res;
                    })()
               },
               dataZoom: {
                   show: false,
                   start: 0,
                   end: 100
               },
               yAxis: {
                   type: 'value',
                   scale : true,
                   max : 5,
                   min : 0,
               },
               series: [{
                  name : 'G값',
                   type: 'line',
                   lineStyle : {
                      color:'#2A265C'
                   },
                   smooth: true,
                   data: (function (){
                        var res = [];
                        var len = 8;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               },
               {
                    name: '경고값',
                    type: 'line',
                    lineStyle:{
                    color:'#D7DF01' //line차트 색상 변경
                 },
                    smooth: true, //부드러운 line 표현
                    yAxisIndex: 0, //yAxis 1번째 사용
                    data: (function (){
                        var res = [];
                        var len = 0;
                        while (len < 20) {
                            res.push(1.8); //랜덤 데이터 생성
                            len++;
                        }
                        return res;
                    })()
                    , symbol : "none"},
                    {
                        name: '위험값',
                        type: 'line',
                        lineStyle:{
                        color:'#DF0101' //line차트 색상 변경
                     },
                        smooth: true, //부드러운 line 표현
                        yAxisIndex: 0, //yAxis 1번째 사용
                        data: (function (){
                            var res = [];
                            var len = 0;
                            while (len < 20) {
                                res.push(3.6); //랜덤 데이터 생성
                                len++;
                            }
                            return res;
                        })()
                        , symbol : "none"}]
           };

           myChart3.setOption(option3);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData3 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
               var data3 = option3.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data3.shift();
               
               var main3Obj = document.getElementById("main3");
            //ajax 구문 추가
           $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_3&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
            	   data3.push(json.ss_val_g_val);
                   if (json.ss_val_g_val < 1.8) {
                      bgc3 = "#ffffff";
                   }
                   else if (json.ss_val_g_val >= 1.8 && json < 3.6) {
                      bgc3 = "#fff091";
                   }
                   else if (json.ss_val_g_val >= 3.6) {
                      bgc3 = "#ffa6a6";
                   }
                   main3Obj.style.backgroundColor = bgc3;
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option3.xAxis.data.shift();
               option3.xAxis.data.push(axisData3);

              //차트에 반영
               myChart3.setOption(option3);
           }, 10000);
           
    </script>
    
    <script>
    	function divreload() {
    		$('map').load(window.location.href + '#map');
    	}
    	function fireloc() {
        	if(sensor1_ss_val_g_val >3.5 && sensor2_ss_val_g_val > 3.5) {
          	dist = Math.sqrt(Math.abs(Math.pow(sensor1_ss_loc_x - sensor2_ss_loc_x,2)-Math.pow(sensor1_ss_loc_y - sensor2_ss_loc_y,2)));
           console.log("dist : " + dist);
           console.log(Math.sqrt(Math.abs(Math.pow(sensor1_ss_loc_x - sensor2_ss_loc_x,2)-Math.pow(sensor1_ss_loc_y - sensor2_ss_loc_y,2))));
           console.log(Math.pow(sensor1_ss_loc_y - sensor2_ss_loc_y,2));
           console.log(Math.pow(sensor1_ss_loc_x - sensor2_ss_loc_x,2));
           dist = dist/(sensor1_ss_val_temp_val - sensor1_ss_val_temp_val_p + sensor2_ss_val_temp_val - sensor2_ss_val_temp_val_p);
           firedist = dist * (sensor2_ss_val_temp_val - sensor2_ss_val_temp_val_p);
           fire_loc_x = Math.abs(sensor1_ss_loc_x-(Math.round(firedist/Math.sqrt(2))))/1000000+0.000797;
           fire_loc_y = Math.abs(sensor1_ss_loc_y-(Math.round(firedist/Math.sqrt(2))))/1000000;
       
          
           console.log("firedist : " + firedist);
           console.log("fire_loc_x : " + fire_loc_x);
           console.log("fire_loc_y : " + fire_loc_y);
           
           /*  */
			var circle = new kakao.maps.Circle({
			map: map, // 원을 표시할 지도 객체
			center : new kakao.maps.LatLng(fire_loc_x, fire_loc_y), // 지도의 중심 좌표
			radius : 3, // 원의 반지름 (단위 : m)
			fillColor: '#FF0000', // 채움 색
			fillOpacity: 0.5, // 채움 불투명도
			strokeWeight: 3, // 선의 두께
			strokeColor: '#FF0000', // 선 색
			strokeOpacity: 0.9, // 선 투명도 
			strokeStyle: 'solid' // 선 스타일
			});	
			/*  */
			
			divreload()
           
           
       }
    }
    </script>
</body>
</html>
