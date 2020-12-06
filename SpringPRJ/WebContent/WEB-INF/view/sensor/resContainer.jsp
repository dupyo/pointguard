<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.SensorInfoDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="java.util.ArrayList"%>
<%
    List<SensorInfoDTO> rList = (List<SensorInfoDTO>)request.getAttribute("rList");
	
	if(rList.size() == 0) {
		rList = new ArrayList<SensorInfoDTO>();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Custom fonts for this template-->
<link href="/yjcss/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="/yjcss/css/sb-admin-2.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary"><%=CmmUtil.nvl(rList.get(0).getSs_id()) %></h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>date</th>
							<th>Co2</th>
							<th>Temp</th>
							<th>HMD</th>
							<th>G</th>
						</tr>
					</thead>
					 <tbody>
						<%for(int i=0; i<10; i++){ %>
						<tr>
							<td><%=CmmUtil.nvl(rList.get(i).getSs_val_rgdate())%></td>
							<td><%=CmmUtil.nvl(rList.get(i).getSs_val_co2_val())%></td>
							<td><%=CmmUtil.nvl(rList.get(i).getSs_val_temp_val()) %></td>
							<td><%=CmmUtil.nvl(rList.get(i).getSs_val_hmd_val()) %></td>
							<td><%=CmmUtil.nvl(rList.get(i).getSs_val_g_val()) %></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		</div>
	</div> 
	
</script>
	
</body>

</html>