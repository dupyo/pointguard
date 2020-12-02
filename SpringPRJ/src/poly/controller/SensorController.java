package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import poly.dto.SensorDTO;
import poly.dto.SensorInfoDTO;
import poly.service.ISensorService;
import poly.util.CmmUtil;

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
		
		//임시 습도 값
		double HmdData = 10;
		double HmdpData = 100;
		
		//임시 동일 가증치
		double co2_weight = 0.34;
		double temp_weight = 0.33;
		double hmd_weight = 0.33;
		
		/* 가중치를 조건을 주고 한 가지 상황에서만 작동하게 끔  ( 이것들은 사실 아두이노에서 같이 보내야할 데이터니까 나중에 아두이노로 옮기자)
		 * 
		 * 1. 제일 가운데에 있는 센서들
		 * >> 온도가 제일 중요하기 때문에 온도에 가중치를 높게 설정
		 *  double co2_weight = 0.10;
			double temp_weight = 0.80;
			double hmd_weight = 0.10;
		 * 2. 바깥에 있는 센서들
		 * >> 온도보다는 이산화탄소, 습도 센서가 중요해서 가중치를 높게 설정
		 *  double co2_weight = 0.60;
			double temp_weight = 0.10;
			double hmd_weight = 0.30;
		 * 
		*/
		
		log.info(" jsonObj.get(\"CoData\").toString() : " + jsonObj.get("CoData").toString());
		

		
		//센서에 데이터를 넣을 DTO 생성
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
		
		
		//서비스로 넘기기
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
	@RequestMapping(value="sensor/mainpage")
	public String mainpage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		log.info(this.getClass());
		
		
		String [] Url = {"https://weather.naver.com/today","https://weather.naver.com/today/01110675","https://weather.naver.com/today/16111120","https://weather.naver.com/today/02113128","https://weather.naver.com/today/07110101",
							"https://weather.naver.com/today/06110101","https://weather.naver.com/today/05110101","https://weather.naver.com/today/12110152","https://weather.naver.com/today/10110101","https://weather.naver.com/today/08110580"
							,"https://weather.naver.com/today/14130116"};
		String [] a = {"서울","춘천","청주","수원","대전","대구","광주","목포","울산","부산","제주"};
		List<Elements> temp = new ArrayList<Elements>();
		List<Elements> humidity = new ArrayList<Elements>();
		List<Elements> wind = new ArrayList<Elements>();
		List<String> Loc = new ArrayList<String>();
		String warn_url = "https://www.weather.go.kr/weather/warning/status.jsp";
		Document weather_warn = Jsoup.connect(warn_url).get();
		Elements weather_img = weather_warn.select(".content_weather .special_report_list2 dd p:nth-child(1) img");
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
		log.info(weather_img);
		model.addAttribute("weather_img", weather_img);
		model.addAttribute("temp", temp);
		model.addAttribute("humidity", humidity);
		model.addAttribute("wind", wind);
		model.addAttribute("loc", Loc);
		
		
		
		return "/sensor/mainpage";
	}
	
	@RequestMapping(value="sensor/detailpage")
	public String detailpage(HttpServletRequest request,HttpServletResponse response, ModelMap model) throws Exception {
		log.info(this.getClass());
		
		String M_Name = request.getParameter("value");
		
		SensorInfoDTO pDTO = new SensorInfoDTO();
		//산 위치 데이터 가져오가
		log.info(this.getClass().getName() + " value : " + M_Name);
		log.info(this.getClass().getName() + " setMt_name : " + pDTO.getMt_name());
		log.info(this.getClass().getName() + "start service logic");
		pDTO.setMt_name(M_Name);
		List<SensorInfoDTO> pList = sensorService.getMLocList(pDTO);
		
		//센서 위치 가져오기
		SensorInfoDTO rDTO = new SensorInfoDTO();
		rDTO.setMt_name(M_Name);
		List<SensorInfoDTO> sList = sensorService.getSSinfoList(rDTO);
		
		log.info(this.getClass().getName() + " rList.get(0).getMt_name() : " + sList.get(0).getMt_loc_x());
		
		log.info(this.getClass().getName() + "start service end");
		log.info(M_Name);
		log.info(pList.get(0).getMt_loc_x());
		log.info(pList.get(0).getMt_loc_y());
		log.info(pList.get(0).getMt_seq());
		log.info(sList.get(0).getSs_loc_x());
		log.info(sList.get(0).getSs_loc_y());
		log.info(sList.get(0).getSs_id());
		model.addAttribute("sList", sList);
		model.addAttribute("M_Name", M_Name);
		model.addAttribute("SS_Loc_x", sList.get(0).getSs_loc_x());
		model.addAttribute("SS_ID", sList.get(0).getSs_id());
		model.addAttribute("SS_Loc_y",sList.get(0).getSs_loc_y());
		model.addAttribute("M_Loc_x",pList.get(0).getMt_loc_x());
		model.addAttribute("M_Loc_y",pList.get(0).getMt_loc_y());
		model.addAttribute("M_Seq",pList.get(0).getMt_seq());
		
		
		
		return "/sensor/detailpage";
	}
	@RequestMapping(value="/sensor/sensorDataList")
	public @ResponseBody List<SensorInfoDTO> mlocsearchList(HttpServletRequest request)throws Exception{
		
		log.info(this.getClass()+ " start");
		String name = CmmUtil.nvl(request.getParameter("name"));
		log.info("name : " + name);
		SensorInfoDTO pDTO = new SensorInfoDTO();
		pDTO.setSs_id(name);
		List<SensorInfoDTO> rList = sensorService.getSsValList(pDTO);


		for(int i=0; i<rList.size(); i++) {
			log.info(rList.get(i).getSs_val_co2_val());
			log.info(rList.get(i).getSs_val_co2_val());
			log.info(rList.get(i).getSs_val_co2_val());
			log.info(rList.get(i).getSs_val_co2_val());
		}
		
		log.info(this.getClass()+ "end");
		return rList;
		
	}
	
	@RequestMapping(value="sensor/receiveSensorData")
	   @ResponseBody
	   public double reveiveSensorData(HttpServletRequest request) throws Exception { 
	      log.info(this.getClass().getName() + ".sensor/receiveSensorData start !!");
	      log.info("ss_name : "+ request.getParameter("ss_id"));
	      log.info("seq : " + request.getParameter("ss_val_seq"));
	      
	      String ss_id = request.getParameter("ss_id");
	      String ss_val_seq = request.getParameter("ss_val_seq");
	      
	      SensorDTO sDTO = new SensorDTO();
	      sDTO.setSs_id(ss_id);
	      sDTO.setSs_val_seq(ss_val_seq);
	      
	      SensorDTO pDTO = sensorService.receiveSensorData(sDTO);
	      log.info("g_val : " + pDTO.getSs_val_g_val());
	            
	      return pDTO.getSs_val_g_val();
	   }
	
	

}
