package com.example.kursach.repos;

import com.example.kursach.domain.Comment;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CommentRepo extends CrudRepository<Comment, Long> {
        List<Comment> findByText(String text);
        List<Comment> findByOrderByLikecDesc();
}