package poly.persistance.mapper;


import java.util.List;

import config.Mapper;
import poly.dto.SensorDTO;
import poly.dto.SensorInfoDTO;

@Mapper("SensorMapper")
public interface ISensorMapper {



	List<SensorInfoDTO> getSSinfoList(SensorInfoDTO rDTO)throws Exception;

	List<SensorInfoDTO> getMLocList(SensorInfoDTO pDTO) throws Exception;

	List<SensorInfoDTO> getSsValList(SensorInfoDTO pDTO) throws Exception;

	SensorDTO receiveSensorData(SensorDTO sDTO) throws Exception;
}
