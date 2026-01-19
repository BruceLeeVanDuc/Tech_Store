package com.gocart.controller;

import com.gocart.model.Rating;
import com.gocart.service.RatingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ratings")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class RatingController {
    private final RatingService ratingService;

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<Rating>> getRatingsByProduct(@PathVariable String productId) {
        return ResponseEntity.ok(ratingService.getRatingsByProduct(productId));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Rating>> getRatingsByUser(@PathVariable String userId) {
        return ResponseEntity.ok(ratingService.getRatingsByUser(userId));
    }

    @GetMapping("/user/{userId}/product/{productId}/order/{orderId}")
    public ResponseEntity<Rating> getRating(
            @PathVariable String userId,
            @PathVariable String productId,
            @PathVariable String orderId) {
        return ratingService.getRating(userId, productId, orderId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Rating> createRating(@RequestBody Rating rating) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ratingService.createRating(rating));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRating(@PathVariable String id) {
        ratingService.deleteRating(id);
        return ResponseEntity.noContent().build();
    }
}

