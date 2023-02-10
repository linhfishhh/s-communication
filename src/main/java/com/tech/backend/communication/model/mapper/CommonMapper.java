package com.tech.backend.communication.model.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.sql.Timestamp;

/**
 * @author nguyen.tam.thi at 16:12 2020-04-21
 */
@Mapper
public interface CommonMapper {

    CommonMapper INSTANCE = Mappers.getMapper(CommonMapper.class);

    default Timestamp timeStampToLong(Long date) {
        return date == null ? null : new Timestamp(date);
    }

    default Long longToTimestamp(Timestamp timestamp) {
        return timestamp == null ? null : timestamp.getTime();
    }

}
