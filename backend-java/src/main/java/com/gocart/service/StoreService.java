package com.gocart.service;

import com.gocart.model.Store;
import com.gocart.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class StoreService {
    private final StoreRepository storeRepository;

    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }

    public List<Store> getActiveStores() {
        return storeRepository.findByIsActiveTrue();
    }

    public List<Store> getStoresByStatus(String status) {
        return storeRepository.findByStatus(status);
    }

    public Optional<Store> getStoreById(String id) {
        return storeRepository.findById(id);
    }

    public Optional<Store> getStoreByUsername(String username) {
        return storeRepository.findByUsername(username);
    }

    public Optional<Store> getStoreByUserId(String userId) {
        return storeRepository.findByUserId(userId);
    }

    public Store createStore(Store store) {
        return storeRepository.save(store);
    }

    public Store updateStore(String id, Store store) {
        Store existingStore = storeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Store not found"));
        
        existingStore.setName(store.getName());
        existingStore.setDescription(store.getDescription());
        existingStore.setAddress(store.getAddress());
        existingStore.setLogo(store.getLogo());
        existingStore.setEmail(store.getEmail());
        existingStore.setContact(store.getContact());
        existingStore.setStatus(store.getStatus());
        existingStore.setIsActive(store.getIsActive());
        
        return storeRepository.save(existingStore);
    }

    public void deleteStore(String id) {
        storeRepository.deleteById(id);
    }

    /**
     * Toggle isActive status của store
     */
    public Store toggleStoreStatus(String id) {
        Store store = storeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Store not found"));
        store.setIsActive(!store.getIsActive());
        return storeRepository.save(store);
    }

    /**
     * Approve/Reject store (update status)
     */
    public Store updateStoreStatus(String id, String status) {
        Store store = storeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Store not found"));
        store.setStatus(status);
        if ("active".equals(status) || "approved".equals(status)) {
            store.setIsActive(true);
        } else {
            store.setIsActive(false);
        }
        return storeRepository.save(store);
    }
}

