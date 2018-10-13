package com.example.kursach.repos;

import com.example.kursach.domain.LikeComment;
import org.springframework.data.repository.CrudRepository;

public interface LikeRepo extends CrudRepository<LikeComment, Long> {

}
