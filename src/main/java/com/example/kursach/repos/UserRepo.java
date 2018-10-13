package com.example.kursach.repos;

import com.example.kursach.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User,Long> {
    User findByUsername(String username);
    User findBySocialId(String social_id);

    User findByActivationCode(String code);
}
