package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.SensorDTO;
import poly.dto.SensorInfoDTO;
import poly.persistance.mapper.ISensorMapper;
import poly.service.ISensorService;

@Service("SensorService")
public class SensorService implements ISensorService {
	
	static double past_g = 0;
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "SensorMapper")
	private ISensorMapper sensorMapper;


	@Override
	   public int putSensorData(SensorDTO sDTO) throws Exception {
	      log.info(this.getClass().getName() + ".putSensorData start !");
	      
	      //임계값 구하기 Iw = 최대변화량 * 비례상수 * 가중치
	      double i_warning = 0;
	      double i_danger = 0;
	      
	      i_warning += sDTO.getCo2_maxchg() * sDTO.getCo2_pptcn() * sDTO.getCo2_weight();
	      log.info("첫번째 i_wraning : " + i_warning);
	   
	      i_warning += sDTO.getTemp_maxchg() * sDTO.getTemp_pptcn() * sDTO.getTemp_weight();
	      log.info("두번째 i_wraning : " + i_warning);
	      
	      i_warning += sDTO.getHmd_maxchg() * sDTO.getHmd_pptcn() * sDTO.getHmd_weight();
	      log.info("세번째 i_wraning : " + i_warning);
	      
	      i_warning = Math.round(i_warning*100)/100.0;
	      i_danger = Math.round(i_warning*100)/100.0*2;
	      log.info("i_warning : " + i_warning);
	      log.info("i_danger : " + i_danger);
	      
	      sDTO.setI_warning(i_warning);
	      sDTO.setI_danger(i_danger);
	      
	      //G값 구하기 G = (전센서데이터 - 현재센서데이터)의 절댓값 * 비레상수 * 가중치 
	      double g = 0;
	      
	      g += Math.abs(sDTO.getCo2_nowval()-sDTO.getCo2_pastval()) * sDTO.getCo2_weight() * sDTO.getCo2_pptcn();
	      log.info("첫번째 g : " + g);
	      
	      g += Math.abs(sDTO.getTemp_nowval()-sDTO.getTemp_pastval()) * sDTO.getTemp_weight() * sDTO.getTemp_pptcn();
	      log.info("두번째 g : " + g);
	      
	      g += Math.abs(sDTO.getHmd_nowval()-sDTO.getHmd_pastval()) * sDTO.getHmd_weight() * sDTO.getHmd_pptcn();
	      log.info("세번째 g : " + g);
	      
	      g = Math.round(g*100)/100.0;
	      
	      double minus = sDTO.getTemp_nowval()-sDTO.getTemp_pastval();
	      log.info("온도 변화량 : " + minus);
	      
	      if(g >= 0.5 || past_g >= 3.6) { 
	         past_g = sDTO.getSs_val_g_val();
	         sDTO.setSs_val_g_val(3.6);
	         if(sDTO.getTemp_nowval()-sDTO.getTemp_pastval() < 0) { 
	            past_g = 0;
	         }
	      } else { 
	         sDTO.setSs_val_g_val(g);
	      }
	      log.info("g : " + sDTO.getSs_val_g_val());
	      //sensorMapper.putSensorData(sDTO);
	      log.info(this.getClass().getName() + ".putSensorData end !");
	      return sensorMapper.putSensorData(sDTO);
	   }

	@Override
	public List<SensorInfoDTO> getMLocList(SensorInfoDTO pDTO) throws Exception{
		log.info(this.getClass().getName() + ".getMLocList start !!");
		log.info(this.getClass().getName() + " setMt_name : " + pDTO.getMt_name());
		return sensorMapper.getMLocList(pDTO);
	}
	@Override
	public List<SensorInfoDTO> getSsValList(SensorInfoDTO pDTO) throws Exception{
		return sensorMapper.getSsValList(pDTO);
	}
	@Override
	public List<SensorInfoDTO> getSSinfoList(SensorInfoDTO rDTO) throws Exception{
		return sensorMapper.getSSinfoList(rDTO);
	}
	//ajax 센서데이터 넣기 메소드 서비스 부분
	   @Override
	   public SensorDTO receiveSensorData(SensorDTO sDTO) throws Exception {
	      
	      log.info(this.getClass().getName() + ".receiveSensorData service start !!");
	      log.info("ss_id : " + sDTO.getSs_id());
	      log.info(this.getClass().getName() + ".receiveSensorData service end !!");

	      return sensorMapper.receiveSensorData(sDTO);
	   }


}
