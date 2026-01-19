package com.gocart.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "Coupon")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
    @Id
    private String code;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    private Double discount;
    private Boolean forNewUser;
    private Boolean forMember = false;
    private Boolean isPublic;
    
    @Column(nullable = false)
    private LocalDateTime expiresAt;
    
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}

