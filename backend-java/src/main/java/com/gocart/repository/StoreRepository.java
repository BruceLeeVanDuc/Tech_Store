package com.gocart.repository;

import com.gocart.model.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StoreRepository extends JpaRepository<Store, String> {
    Optional<Store> findByUsername(String username);
    Optional<Store> findByUserId(String userId);
    List<Store> findByStatus(String status);
    List<Store> findByIsActiveTrue();
}

