-- Lệnh SQL để INSERT Product vào PostgreSQL
-- Lưu ý: Thay YOUR_STORE_ID bằng storeId thật từ bảng stores

-- Cách 1: INSERT với storeId cụ thể (dùng storeId đã có)
INSERT INTO products (
    id,
    name,
    description,
    mrp,
    price,
    category,
    in_stock,
    store_id,
    created_at,
    updated_at
) VALUES (
    gen_random_uuid()::text,  -- Tự động generate UUID
    'Tai nghe Sony WH-1000XM4',
    'Tai nghe chống ồn chủ động với công nghệ Noise Cancelling tiên tiến, pin 30 giờ, chất lượng âm thanh Hi-Res Audio.',
    6000000.0,  -- Giá gốc (MRP)
    5000000.0,  -- Giá bán
    'Headphones',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật của bạn
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Sau đó INSERT images vào bảng product_images
-- Lấy product_id vừa tạo (hoặc dùng id cụ thể)
INSERT INTO product_images (product_id, image)
SELECT id, 'https://example.com/headphone1.jpg'
FROM products
WHERE name = 'Tai nghe Sony WH-1000XM4'
ORDER BY created_at DESC
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT id, 'https://example.com/headphone2.jpg'
FROM products
WHERE name = 'Tai nghe Sony WH-1000XM4'
ORDER BY created_at DESC
LIMIT 1;

-- ============================================
-- Cách 2: INSERT nhiều products cùng lúc
-- ============================================

-- Product 1: Tai nghe
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
VALUES (
    gen_random_uuid()::text,
    'Tai nghe Sony WH-1000XM4',
    'Tai nghe chống ồn chủ động với công nghệ Noise Cancelling tiên tiến',
    6000000.0,
    5000000.0,
    'Headphones',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Product 2: Đồng hồ thông minh
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
VALUES (
    gen_random_uuid()::text,
    'Apple Watch Series 9',
    'Đồng hồ thông minh với màn hình Always-On Retina, theo dõi sức khỏe 24/7',
    12000000.0,
    10000000.0,
    'Watch',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Product 3: Loa Bluetooth
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
VALUES (
    gen_random_uuid()::text,
    'JBL Flip 6 - Loa Bluetooth',
    'Loa Bluetooth di động với âm bass mạnh mẽ, chống nước IPX7, pin 12 giờ',
    3500000.0,
    2800000.0,
    'Speakers',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Product 4: Tai nghe True Wireless
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
VALUES (
    gen_random_uuid()::text,
    'AirPods Pro 2',
    'Tai nghe True Wireless với chống ồn chủ động, chống nước IPX4, pin 6 giờ',
    7000000.0,
    5500000.0,
    'Earbuds',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Product 5: Chuột gaming
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
VALUES (
    gen_random_uuid()::text,
    'Logitech G Pro X Superlight',
    'Chuột gaming không dây siêu nhẹ 63g, sensor HERO 25K, pin 70 giờ',
    3500000.0,
    2800000.0,
    'Mouse',
    true,
    '4f8c1858-f11c-4c94-8055-7a92290c1058',  -- ← Thay bằng storeId thật
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- ============================================
-- Sau khi INSERT products, thêm images
-- ============================================

-- Lấy product_id và thêm images (ví dụ cho product đầu tiên)
-- Thay 'PRODUCT_ID_HERE' bằng id thật của product vừa tạo

INSERT INTO product_images (product_id, image) VALUES
('PRODUCT_ID_HERE', 'https://example.com/product1.jpg'),
('PRODUCT_ID_HERE', 'https://example.com/product2.jpg'),
('PRODUCT_ID_HERE', 'https://example.com/product3.jpg');

-- ============================================
-- Hoặc dùng query để tự động lấy product_id mới nhất
-- ============================================

INSERT INTO product_images (product_id, image)
SELECT id, 'https://example.com/headphone1.jpg'
FROM products
WHERE name = 'Tai nghe Sony WH-1000XM4'
ORDER BY created_at DESC
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT id, 'https://example.com/headphone2.jpg'
FROM products
WHERE name = 'Tai nghe Sony WH-1000XM4'
ORDER BY created_at DESC
LIMIT 1;

