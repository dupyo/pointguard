package poly.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import poly.dto.SensorDTO;
import poly.service.ISensorService;

@Controller
public class SensorController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "SensorService")
	private ISensorService sensorService;
	
	@RequestMapping(value = "sensor/getSensorData", method = RequestMethod.POST, produces = {"application/json; charset=UTF-8"})
	public void getSensorData(@RequestBody String info) throws Exception{ 
		
		log.info(this.getClass().getName() + ".getSonsorData start !");
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(info);
		JSONObject jsonObj = (JSONObject) obj;
		
		log.info("info : " + info);
		
		log.info("codata : " + jsonObj.get("CoData"));
		
		//�엫�떆 �뒿�룄 媛�
		double HmdData = 10;
		double HmdpData = 100;
		
		//�엫�떆 �룞�씪 媛�利앹튂
		double co2_weight = 0.34;
		double temp_weight = 0.33;
		double hmd_weight = 0.33;
		
		/* 媛�以묒튂瑜� 議곌굔�쓣 二쇨퀬 �븳 媛�吏� �긽�솴�뿉�꽌留� �옉�룞�븯寃� �걫  ( �씠寃껊뱾�� �궗�떎 �븘�몢�씠�끂�뿉�꽌 媛숈씠 蹂대궡�빞�븷 �뜲�씠�꽣�땲源� �굹以묒뿉 �븘�몢�씠�끂濡� �삷湲곗옄)
		 * 
		 * 1. �젣�씪 媛��슫�뜲�뿉 �엳�뒗 �꽱�꽌�뱾
		 * >> �삩�룄媛� �젣�씪 以묒슂�븯湲� �븣臾몄뿉 �삩�룄�뿉 媛�以묒튂瑜� �넂寃� �꽕�젙
		 *  double co2_weight = 0.10;
			double temp_weight = 0.80;
			double hmd_weight = 0.10;
		 * 2. 諛붽묑�뿉 �엳�뒗 �꽱�꽌�뱾
		 * >> �삩�룄蹂대떎�뒗 �씠�궛�솕�깂�냼, �뒿�룄 �꽱�꽌媛� 以묒슂�빐�꽌 媛�以묒튂瑜� �넂寃� �꽕�젙
		 *  double co2_weight = 0.60;
			double temp_weight = 0.10;
			double hmd_weight = 0.30;
		 * 
		*/
		
		log.info(" jsonObj.get(\"CoData\").toString() : " + jsonObj.get("CoData").toString());
		

		
		//�꽱�꽌�뿉 �뜲�씠�꽣瑜� �꽔�쓣 DTO �깮�꽦
		SensorDTO sDTO = new SensorDTO();
		
		sDTO.setCo2_nowval(Double.parseDouble(jsonObj.get("CoData").toString()));
		sDTO.setTemp_nowval(Double.parseDouble(jsonObj.get("TempData").toString()));
		sDTO.setHmd_nowval(HmdData);
		sDTO.setCo2_pastval(Double.parseDouble(jsonObj.get("CopData").toString()));
		sDTO.setTemp_pastval(Double.parseDouble(jsonObj.get("TemppData").toString()));
		sDTO.setHmd_pastval(HmdpData);
		sDTO.setCo2_pptcn(Double.parseDouble(jsonObj.get("co2_pptcn").toString()));
		sDTO.setTemp_pptcn(Double.parseDouble(jsonObj.get("temp_pptcn").toString()));
		sDTO.setHmd_pptcn(Double.parseDouble(jsonObj.get("hmd_pptcn").toString()));
		sDTO.setCo2_maxchg(Double.parseDouble(jsonObj.get("co2_maxchg").toString()));
		sDTO.setTemp_maxchg(Double.parseDouble(jsonObj.get("temp_maxchg").toString()));
		sDTO.setHmd_maxchg(Double.parseDouble(jsonObj.get("hmd_maxchg").toString()));
		sDTO.setCo2_weight(co2_weight);
		sDTO.setTemp_weight(temp_weight);
		sDTO.setHmd_weight(hmd_weight);

		
		log.info("co2_nowval : " + sDTO.getCo2_nowval());
		log.info("temp_nowval : " + sDTO.getTemp_nowval());
		log.info("hmd_nowval : " + sDTO.getHmd_nowval());
		log.info("co2_pastval : " + sDTO.getCo2_pastval());
		log.info("temp_pastval : " + sDTO.getTemp_pastval());
		log.info("hmd_pastval : " + sDTO.getHmd_pastval());
		
		
		//�꽌鍮꾩뒪濡� �꽆湲곌린
		int result = sensorService.putSensorData(sDTO);
		
	}
	
	@RequestMapping(value="index")
	public String index() throws Exception {
		log.info("--------start");
		log.info("--------end");
		return "/index";
	}
	
	@RequestMapping(value="mm")
	public String mm() throws Exception {
		log.info("--------start");
		log.info("--------end");
		return "/mm";
	}
	//유연준 (디테일페이지)
	@RequestMapping(value="sensor/detailpage")
	public String detailpage(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass());
		
		String M_Name = request.getParameter("value");
		
		MLocDTO pDTO = null;
		pDTO = new MLocDTO();
		
		pDTO.setM_name(M_Name);
		
		model.addAttribute("M_Name", M_Name);
		log.info(M_Name);
		
		
		
		return "/sensor/detailpage";
	} 
	//유연준 메인페이지
	@RequestMapping(value="sensor/mainpage")
	public String mainpage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		log.info(this.getClass());
		
		
		String [] Url = {"https://weather.naver.com/today","https://weather.naver.com/today/01110675","https://weather.naver.com/today/16111120","https://weather.naver.com/today/02113128","https://weather.naver.com/today/07110101",
							"https://weather.naver.com/today/06110101","https://weather.naver.com/today/05110101","https://weather.naver.com/today/12110152","https://weather.naver.com/today/10110101","https://weather.naver.com/today/08110580"
							,"https://weather.naver.com/today/14130116"};
		String [] a = {"서울","춘천","청주","수원","대전","대구","광주","목포","울산","부산","제주"};
		List temp = new ArrayList();
		List humidity = new ArrayList();
		List wind = new ArrayList();
		List Loc = new ArrayList();
		for(int j=0; j<a.length; j++) {
			Loc.add(a[j]);
		}
		for(int i=0; i<Url.length; i++) {
			String WeatherURL = Url[i];
			Document doc =Jsoup.connect(WeatherURL).get();
			 Elements Temp =doc.select(".weather_area .summary_list  .desc_feeling");
			 Elements Humidity = doc.select(".weather_area .summary_list  .desc_humidity");
			 Elements Wind= doc.select(".weather_area .summary_list  .desc_wind");
			 String[] str1 = Temp.text().split(" ");
			 String[] str2 = Humidity.text().split(" ");
			 String[] str3 = Wind.text().split(" ");
			 temp.add(Temp);
			 humidity.add(Humidity);
			 wind.add(Wind);
		}
		model.addAttribute("temp", temp);
		model.addAttribute("humidity", humidity);
		model.addAttribute("wind", wind);
		model.addAttribute("loc", Loc);
		//기상 데이터 크롤링 
		/*
		 * String WeatherURL = "https://weather.naver.com/today"; Document doc =
		 * Jsoup.connect(WeatherURL).get(); //HTML로 부터 데이터 가져오기 Elements temp =
		 * doc.select(".weather_area .summary_list  .desc_feeling");//원하는 태그 선택 String[]
		 * str1 = temp.text().split(" ");//정보 파싱 Elements humidity =
		 * doc.select(".weather_area .summary_list  .desc_humidity");//원하는 태그 선택
		 * String[] str2 = humidity.text().split(" ");//정보 파싱 Elements wind=
		 * doc.select(".weather_area .summary_list  .desc_wind");//원하는 태그 선택 String[]
		 * str3 = wind.text().split(" ");//정보 파싱 String loc = "서울";
		 */
		//기상특보 크롤링 
		
		
		return "/sensor/mainpage";
	}

}
