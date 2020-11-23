package poly.persistance.mapper;

import config.Mapper;
import poly.dto.SensorDTO;

@Mapper("SensorMapper")
public interface SensorMapper {
	int putSensorData(SensorDTO sDTO) throws Exception;
}
