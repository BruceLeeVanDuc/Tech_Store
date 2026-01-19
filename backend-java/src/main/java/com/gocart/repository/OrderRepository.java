package com.gocart.repository;

import com.gocart.model.Order;
import com.gocart.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    List<Order> findByUserId(String userId);
    List<Order> findByStoreId(String storeId);
    List<Order> findByStoreIdAndStatus(String storeId, OrderStatus status);
    List<Order> findByIsPaidTrue();
}

