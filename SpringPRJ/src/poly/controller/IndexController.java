package poly.controller;

import org.apache.log4j.Logger;
import org.json.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sun.util.logging.resources.logging;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Controller
public class IndexController {
	private Logger log = Logger.getLogger(this.getClass());
    //이건 신경쓰지 말고
    @RequestMapping(value="/")
    public String index(){
        return "/index";
    }

    //이건 산불 위험 화면 보여주는 요청
    @RequestMapping(value="/index2")
     public String index2(){
    	log.info("index page");
        return "/index2";
    }

    //이건 ajax 산불 위험 예보
    @RequestMapping(value="/getMountainData")
    public @ResponseBody String getMountainFireAlarm(HttpServletRequest req) throws Exception{
        //하기전에
        /*
         maven dependency 추가

         pom.xml 에
         <dependency>
          <groupId>org.json</groupId>
          <artifactId>json</artifactId>
          <version>20180813</version>
        </dependency>
        추가
        */
        //일단 실행의 의의를 두고 개발진행했으니 코드정리 안되어있어도 어쩔수 없음
        /*지형, 임상, 기상자료를 이용하여 전국 시․군․구 행정구역에 매시간 산불위험 상황을 제공하며, 12시 ~ 21시까지 3시간 간격으로 이틀(48시간) 유관부처에 정보를 제공하고 조회 합니다.*/
        //api키와  version은 필수값 pdf 문서 참조 (산불위험지수)
        //이 키는 여기가서 신청하고 아래 키 바꿔주셈 아래는 내가 신청한 키라서.
        //http://know.nifos.go.kr/know/service/list/forestPointInfo.do?opt=2&tab=9&subTab=1
        String ServiceKey = "JMF1F4kkAHcMcWlI5beQWeblL0kp0R%2FzQ77YkgycC6w%3D";
        String version = "1.1";
        //전국인지 시도인지 읍면동인지   이것도 문서참조 여기서는 시도로 고정
        String gubun = "sido";

        //지역코드 pdf 참조 //html 에서 select 만들어서 onchange 걸어서 11 ,26 코드 바뀌게  11은 서울 26은 부산      지역코드도 데이터베이스 넣고 하는게 좋은데 시간없으니 일단은 하드코딩
        String localAreaCode = req.getParameter("localAreaCode");
        System.out.println("유연준: "+localAreaCode);

        //urlString 만드는 StringBuilder
        StringBuilder urlBuilder = new StringBuilder("http://know.nifos.go.kr/openapi/forestPoint/forestPointListSearch.do"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("keyValue","UTF-8") + "=" +ServiceKey);
        urlBuilder.append("&" + URLEncoder.encode("version","UTF-8") + "=" + URLEncoder.encode(version, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("gubun","UTF-8") + "=" + URLEncoder.encode(gubun, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("localArea","UTF-8") + "=" + URLEncoder.encode(localAreaCode, "UTF-8"));
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());

        String xml_result = sb.toString();
        //이건 뭔지 모르겠음 xml 파싱할떄  //// ㄴ 일단 xml 을 json 으로 바꿔야 jsp 에서 사용하기 편하기 떄문에
        int PRETTY_PRINT_INDENT_FACTOR = 4;

        //결과 반환하기위해
        String jsonResultStr= "";
        try { // JSONObject 도 org.json XML => org.json 에 있는 XML 임  import 안되면 org.json.XML이라고 적으면됨
//            XML 을 JSON 으로    왜 변환시키냐   이유는 jsp에서 편하게 쓰려고
            JSONObject xmlJSONObj = XML.toJSONObject(xml_result);
            jsonResultStr = xmlJSONObj.toString(PRETTY_PRINT_INDENT_FACTOR);
            System.out.println(jsonResultStr);
        } catch (JSONException je) {
            System.out.println(je.toString());
        }
        log.info("dbduswns");
        return  jsonResultStr;
    }


}


