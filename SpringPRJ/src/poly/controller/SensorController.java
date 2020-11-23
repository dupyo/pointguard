package poly.controller;

import java.util.HashMap;
import java.util.Map;

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

@Controller
public class SensorController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "sensor/getSensorData", method = RequestMethod.POST, produces = {"application/json; charset=UTF-8"})
	public void getSensorData(@RequestBody String info) throws Exception{ 
		
		log.info(this.getClass().getName() + ".getSonsorData start !");
	      
	      JSONParser parser = new JSONParser();
	      Object obj = parser.parse(info);
	      JSONObject jsonObj = (JSONObject) obj;
	      
	      log.info("info : " + info);
	      
	      
	      log.info("parsing result CoData : " + jsonObj.get("CoData"));
	      log.info("parsing result TempData : " + jsonObj.get("TempData"));
		
		
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
