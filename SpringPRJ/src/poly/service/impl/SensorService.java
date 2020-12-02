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

	
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name = "SensorMapper")
	private ISensorMapper sensorMapper;


	@Override
	public int putSensorData(SensorDTO sDTO) throws Exception {
		log.info(this.getClass().getName() + ".putSensorData start !");
		
		//임계값 구하기 Iw = 최대변화량 * 비례상수 * 가중치의 합
		double i_warning = 0;
		double i_danger = 0;
		
		i_warning += sDTO.getCo2_maxchg() * sDTO.getCo2_pptcn() * sDTO.getCo2_weight();
		log.info("첫번째 i_wraning : " + i_warning);
	
		i_warning += sDTO.getTemp_maxchg() * sDTO.getTemp_pptcn() * sDTO.getTemp_weight();
		log.info("두번째 i_wraning : " + i_warning);
		
		i_warning += sDTO.getHmd_maxchg() * sDTO.getHmd_pptcn() * sDTO.getHmd_weight();
		log.info("세번째 i_wraning : " + i_warning);
		
		i_warning = Math.round(i_warning*100)/100.0;
		i_danger = Math.round(i_warning*100)/100.0;
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
		
		g = Math.round(g/3*100)/100.0;
		log.info("g : " + g);
		
		sDTO.setG(g);
		
		//sensorMapper.putSensorData(sDTO);
		
/*		
		화점 찾는 알고리즘 하자~~~~~~ 머리가 깨질거같아요
		
		초기 센서 위치가지고 있는변수
		
		//sensor 1
		double x1 = 0;
		double y1 = 0;
		
		//sensor 2
		double x2 = 3;
		double y2 = 3;
		
		화점 좌표 변수선언
		double xs;
		double yx;
		
		두 점 사이의 거리 변수
		double dist;
		
		화점과 센서 사이의 거리 변수
		double firedist;
		
		1. 두 센서 사이의 거리 구하기
		dist = Math.sqrt(Math.pow(x1-x2,2)-Math.pow(y1-y2,2));
		
		1.1 온도 변화량을 이용한 거리비 구하기
		if(seonsor1.sDTO.getTemp_nowval() - sensor1.sDTO.getTemp_pastval() > 0 ) { 
			dist = dist/(seonsor1.sDTO.getTemp_nowval() + sensor1.sDTO.getTemp_pastval() + seonsor2.sDTO.getTemp_nowval() + sensor2.sDTO.getTemp_pastval());
			// 온도 1:2라면 거리는 2:1이기 때문에
			firedist = dist * (seonsor2.sDTO.getTemp_nowval() - sensor2.sDTO.getTemp_pastval());
			
			xs = Math.abs(x1-(firedist/Math.sqrt(2)));
			ys = Math.abs(y1-(firedist/Math.sqrt(2)));
			
		}
		
*/		
		
		log.info(this.getClass().getName() + ".putSensorData end !");
		return 0;
	}
	/*
	 * @Override public List<sensorInfoDTO> getMLocList(sensorInfoDTO pDTO) throws
	 * Exception { log.info(this.getClass().getName() + ".getMLocList start !!");
	 * log.info(this.getClass().getName() + " setMt_name : " + pDTO.getMt_name());
	 * return mlocMapper.getMLocList(pDTO); }
	 * 
	 * @Override public List<sensorInfoDTO> getssvalList(sensorInfoDTO pDTO) throws
	 * Exception { return mlocMapper.getssvalList(pDTO); }
	 * 
	 * @Override public List<sensorInfoDTO> getSSinfoList(sensorInfoDTO rDTO) throws
	 * Exception { return mlocMapper.getSSinfoList(rDTO); }
	 */

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
	@Override
	public SensorDTO receiveSensorData(SensorDTO sDTO) throws Exception {
	      
	      log.info(this.getClass().getName() + ".receiveSensorData service start !!");
	      log.info("ss_id : " + sDTO.getSs_id());
	      
	      log.info(this.getClass().getName() + ".receiveSensorData service end !!");

	      return sensorMapper.receiveSensorData(sDTO);
	   }

}
