package poly.service;

import java.util.List;

import poly.dto.SensorDTO;
import poly.dto.SensorInfoDTO;

public interface ISensorService {

	int putSensorData(SensorDTO sDTO) throws Exception;
	
	List<SensorInfoDTO> getMLocList(SensorInfoDTO pDTO)throws Exception;


	List<SensorInfoDTO> getSSinfoList(SensorInfoDTO rDTO) throws Exception;


	List<SensorInfoDTO> getSsValList(SensorInfoDTO pDTO)throws Exception;

	SensorDTO receiveSensorData(SensorDTO sDTO) throws Exception;
	

}
