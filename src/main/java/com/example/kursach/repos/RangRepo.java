package com.example.kursach.repos;

import com.example.kursach.domain.RangMessage;
import org.springframework.data.repository.CrudRepository;

public interface RangRepo extends CrudRepository<RangMessage, Long> {

}
