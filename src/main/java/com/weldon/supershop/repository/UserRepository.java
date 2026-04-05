package com.weldon.supershop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.weldon.supershop.model.User;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);

}