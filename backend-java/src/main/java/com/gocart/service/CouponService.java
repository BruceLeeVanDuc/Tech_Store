package com.gocart.service;

import com.gocart.model.Coupon;
import com.gocart.repository.CouponRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CouponService {
    private final CouponRepository couponRepository;

    public List<Coupon> getAllCoupons() {
        return couponRepository.findAll();
    }

    public List<Coupon> getPublicCoupons() {
        return couponRepository.findByIsPublicTrueAndExpiresAtAfter(LocalDateTime.now());
    }

    public Optional<Coupon> getCouponByCode(String code) {
        return couponRepository.findByCode(code);
    }

    public Coupon createCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    public Coupon updateCoupon(String code, Coupon coupon) {
        Coupon existingCoupon = couponRepository.findById(code)
                .orElseThrow(() -> new RuntimeException("Coupon not found"));
        
        existingCoupon.setDescription(coupon.getDescription());
        existingCoupon.setDiscount(coupon.getDiscount());
        existingCoupon.setForNewUser(coupon.getForNewUser());
        existingCoupon.setForMember(coupon.getForMember());
        existingCoupon.setIsPublic(coupon.getIsPublic());
        existingCoupon.setExpiresAt(coupon.getExpiresAt());
        
        return couponRepository.save(existingCoupon);
    }

    public void deleteCoupon(String code) {
        couponRepository.deleteById(code);
    }
}

