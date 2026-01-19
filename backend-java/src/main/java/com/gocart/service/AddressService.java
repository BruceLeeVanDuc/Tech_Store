package com.gocart.service;

import com.gocart.model.Address;
import com.gocart.repository.AddressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class AddressService {
    private final AddressRepository addressRepository;

    public List<Address> getAddressesByUser(String userId) {
        return addressRepository.findByUserId(userId);
    }

    public Optional<Address> getAddressById(String id) {
        return addressRepository.findById(id);
    }

    public Address createAddress(Address address) {
        return addressRepository.save(address);
    }

    public Address updateAddress(String id, Address address) {
        Address existingAddress = addressRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Address not found"));
        
        existingAddress.setName(address.getName());
        existingAddress.setEmail(address.getEmail());
        existingAddress.setStreet(address.getStreet());
        existingAddress.setCity(address.getCity());
        existingAddress.setState(address.getState());
        existingAddress.setZip(address.getZip());
        existingAddress.setCountry(address.getCountry());
        existingAddress.setPhone(address.getPhone());
        
        return addressRepository.save(existingAddress);
    }

    public void deleteAddress(String id) {
        addressRepository.deleteById(id);
    }
}

