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
<script src="/js/echarts.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	function search(name){
		if(name.length ==0){
			$(name).focus();
			alert("no data");
			return false;
		}
		  $.ajax({
			url : '/sensor/sensorDataList.do',
			type : 'post',
			data : {name : name},
			success : function(data) {
				var resHTML = '';
				console.log(data);
				if (data.length == 0) {
					resHTML += '<div class="ajax_div_content_box">검색결과가 없습니다.</div>';
				}
				resHTML += '<div class="cotianer">';
				resHTML += '<div class="item">co2</div>';
				resHTML += '<div class="item">temp</div>';
				resHTML += '<div class="item">humidity</div>';
				resHTML += '<div class="item">G_Value</div>';
				resHTML += '</div>'
				for (var i = data.length; i > data.length -10; i--) {
					resHTML += '<div class="trow" style="display : table-row;">';
					resHTML += '<div class="ajax_div_content_box">'
					        +data[i].getSs_val_co2_val
					        +'</div>';
					resHTML += '<div class="ajax_div_content_box">'
					        +data[i].ss_val_temp_val
					        +'</div>';
					resHTML += '<div class="ajax_div_content_box">'
							+data[i].ss_val_hmd_val
							+'</div>';
					resHTML += '<div class="ajax_div_content_box">'
							+data[i].ss_val_g_val
							+'</div>';
					resHTML +='</div>';
				}
				$("#resContainer").html(resHTML);
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

									<script type="text/javascript"
										src="//dapi.kakao.com/v2/maps/sdk.js?appkey=767d28fae545a0f72f93cd6018b21d63"></script>
									<script>
										
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
											mapOption = {
												center : new kakao.maps.LatLng(
														<%=request.getAttribute("M_Loc_x") %>, <%=request.getAttribute("M_Loc_y") %>), // 지도의 중심좌표
												level : 2
											// 지도의 확대 레벨
											};

											// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
											var map = new kakao.maps.Map(mapContainer, mapOption);
											
											var markerPosition  = new kakao.maps.LatLng(<%=request.getAttribute("SS_Loc_x") %>, <%=request.getAttribute("SS_Loc_y") %>); 

											// 마커를 생성합니다
											var marker = new kakao.maps.Marker({
											    position: markerPosition
											});

											// 마커가 지도 위에 표시되도록 설정합니다
											marker.setMap(map);
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
									<div class="col-6 col-md-4"> <div id="main" style="width: 200px;height:300px;"></div></div>
									<div class="col-6 col-md-4"> <div id="main2" style="width: 200px;height:300px;"></div></div>
									<div class="col-6 col-md-4"> <div id="main3" style="width: 200px;height:300px;"></div></div>
								</div>
								<div class="row">
									<div class="col-6 col-md-4"> <div id="main4" style="width: 200px;height:300px;"></div></div>
									<div class="col-6 col-md-4"> <div id="main5" style="width: 200px;height:300px;"></div></div>
									<div class="col-6 col-md-4"> <div id="main6" style="width: 200px;height:300px;"></div></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<div class="card-body">
			<%for(int i=0; i < sList.size(); i++){ %>
				<a href="JavaScript:search('<%=CmmUtil.nvl(sList.get(i).getSs_id()) %>');" name="<%=CmmUtil.nvl(sList.get(i).getSs_id()) %>"; class="btn btn-success btn-circle"><%= i+1 %></a>
			<%} %>
			</div>
			</div>
		</div>
		<script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart = echarts.init(document.getElementById('main'));
        var seq = 30;

        var option2 = {
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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0); /* //랜덤  데이터생성 */
                        }
                        return res;
                    })()
               }]
           };

           myChart.setOption(option2);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data0 = option2.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data0.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data0.push(json);
                  seq++;
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option2.xAxis.data.shift();
               option2.xAxis.data.push(axisData);

              //차트에 반영
               myChart.setOption(option2);
           }, 2000);
    </script>
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart2 = echarts.init(document.getElementById('main2'));
        var seq = 30;

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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               }]
           };

           myChart2.setOption(option2);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData2 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data2 = option2.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data2.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data2.push(json);
                  seq++;
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
           }, 2000);
    </script>
    
    <!--*********************************************************************  -->
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart3 = echarts.init(document.getElementById('main3'));
        var seq = 30;

        var option3 = {
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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               }]
           };

           myChart3.setOption(option3);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData3 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data3 = option3.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data3.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data3.push(json);
                  seq++;
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
           }, 2000);
    </script>
    <!--*********************************************************************  -->
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart4 = echarts.init(document.getElementById('main4'));
        var seq = 30;

        var option4 = {
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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               }]
           };

           myChart4.setOption(option4);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData4 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data4 = option4.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data4.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data4.push(json);
                  seq++;
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option4.xAxis.data.shift();
               option4.xAxis.data.push(axisData4);

              //차트에 반영
               myChart4.setOption(option4);
           }, 2000);
    </script>
    <!--*********************************************************************  -->
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart5 = echarts.init(document.getElementById('main5'));
        var seq = 30;

        var option5 = {
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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               }]
           };

           myChart5.setOption(option5);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData5 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data5 = option5.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data5.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data5.push(json);
                  seq++;
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option5.xAxis.data.shift();
               option5.xAxis.data.push(axisData5);

              //차트에 반영
               myChart5.setOption(option5);
           }, 2000);
    </script>
    <!--*********************************************************************  -->
    <script type="text/javascript">
        // based on prepared DOM, initialize echarts instance
        var myChart6 = echarts.init(document.getElementById('main6'));
        var seq = 30;

        var option6 = {
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
                            now = new Date(now-2000);
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
                        var len = 20;
                        while (len--) {
                            res.push(Math.round(Math.random()*100)/100.0);
                        }
                        return res;
                    })()
               }]
           };

           myChart6.setOption(option6);

           setInterval(function (){
              //x축에 실시간 데이터 생성
               var axisData6 = (new Date()).toLocaleTimeString().replace(/^\D*/, '');

               var data6 = option6.series[0].data; //순수익 데이터

               //데이터의 가장 왼쪽 값을 제거
               data6.shift();
               //데이터의 가장 오른쪽 값을 추가
               //data0.push(Math.round(Math.random() * 100)/100.0);
            //ajax 구문 추가
            $.ajax({
               url : "/sensor/receiveSensorData.do?ss_id=woojang_1&ss_val_seq="+seq,
               type : "post",
               dataType : "json",
               contentType : "application/json; charset=UTF-8",
               success : function(json){
                  data6.push(json);
                  seq++;
               },
               error:function() {
                  alert("err");
               }
            })
               
              //x축에 시간 데이터 추가
               option6.xAxis.data.shift();
               option6.xAxis.data.push(axisData6);

              //차트에 반영
               myChart6.setOption(option6);
           }, 2000);
    </script>
</body>
</html>
