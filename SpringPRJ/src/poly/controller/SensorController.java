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

}
