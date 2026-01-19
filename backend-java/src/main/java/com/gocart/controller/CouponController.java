package com.gocart.controller;

import com.gocart.model.Coupon;
import com.gocart.service.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/coupons")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class CouponController {
    private final CouponService couponService;

    @GetMapping
    public ResponseEntity<List<Coupon>> getAllCoupons() {
        return ResponseEntity.ok(couponService.getAllCoupons());
    }

    @GetMapping("/public")
    public ResponseEntity<List<Coupon>> getPublicCoupons() {
        return ResponseEntity.ok(couponService.getPublicCoupons());
    }

    @GetMapping("/code/{code}")
    public ResponseEntity<Coupon> getCouponByCode(@PathVariable String code) {
        return couponService.getCouponByCode(code)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Coupon> createCoupon(@RequestBody Coupon coupon) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(couponService.createCoupon(coupon));
    }

    @PutMapping("/{code}")
    public ResponseEntity<Coupon> updateCoupon(@PathVariable String code, @RequestBody Coupon coupon) {
        try {
            return ResponseEntity.ok(couponService.updateCoupon(code, coupon));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{code}")
    public ResponseEntity<Void> deleteCoupon(@PathVariable String code) {
        couponService.deleteCoupon(code);
        return ResponseEntity.noContent().build();
    }
}

