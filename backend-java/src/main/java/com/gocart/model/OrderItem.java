package com.gocart.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "OrderItem")
@IdClass(OrderItemId.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItem {
    @Id
    private String orderId;
    
    @Id
    private String productId;
    
    private Integer quantity;
    private Double price;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orderId", insertable = false, updatable = false)
    private Order order;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    private Product product;
}

