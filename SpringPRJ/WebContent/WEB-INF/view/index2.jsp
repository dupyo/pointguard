<%--
  Created by IntelliJ IDEA.
  User: kimhankyeol
  Date: 2020-12-05
  Time: 오전 4:03
  To change this template use File | Settings | File Templates.
  이기준으로 색깔
  매우높음 심각 86~100
(86이상이 70%이상 일때)	동시다발적 발생, 대형 산불로 확산될 개연성이 높다고 인정되는 경우
높음	 경계 66이상~86미만
(66이상이 70% 이상 일때)	대형산불로 확산될 우려가 인정되는 경우
보통	 주의; 51이상~66미만
(51이상이 70% 이상 일때)	산불발생 위험이 높아질 것으로 예상되는 경우
낮음 관심	0~50	산불발생 위험이 낮음
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>산불 위험 정보지수 조회</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
</head>
<body>

<select id="localAreaCode">
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
<div>산불 위험  -  이제 말안해도 뭐해야 될지 알것이여</div>
<div id="render"></div>
</body>
</html>
