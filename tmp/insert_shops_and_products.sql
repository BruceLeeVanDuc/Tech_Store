-- ============================================
-- SQL Script: Tạo Shops và Products cho GoCart
-- Shop đồ công nghệ: Tai nghe, Đồng hồ, Loa, Chuột, v.v.
-- Tên bảng: users, stores, products (lowercase, plural)
-- ============================================

-- ============================================
-- BƯỚC 1: TẠO USERS (Người dùng/Sellers)
-- ============================================

-- User 1: Tech Store Owner
INSERT INTO users (id, name, email, image, cart)
VALUES (
    gen_random_uuid()::text,
    'Nguyễn Văn Tech',
    'techstore@example.com',
    'https://i.pravatar.cc/150?img=1',
    '{}'::jsonb
)
ON CONFLICT (id) DO NOTHING;

-- User 2: Audio Shop Owner
INSERT INTO users (id, name, email, image, cart)
VALUES (
    gen_random_uuid()::text,
    'Trần Thị Audio',
    'audioshop@example.com',
    'https://i.pravatar.cc/150?img=2',
    '{}'::jsonb
)
ON CONFLICT (id) DO NOTHING;

-- User 3: Watch Store Owner
INSERT INTO users (id, name, email, image, cart)
VALUES (
    gen_random_uuid()::text,
    'Lê Văn Watch',
    'watchstore@example.com',
    'https://i.pravatar.cc/150?img=3',
    '{}'::jsonb
)
ON CONFLICT (id) DO NOTHING;

-- User 4: Gaming Gear Owner
INSERT INTO users (id, name, email, image, cart)
VALUES (
    gen_random_uuid()::text,
    'Phạm Gaming',
    'gaminggear@example.com',
    'https://i.pravatar.cc/150?img=4',
    '{}'::jsonb
)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- BƯỚC 2: TẠO STORES (Cửa hàng)
-- ============================================

-- Store 1: Tech Store - Chuyên tai nghe, loa
INSERT INTO stores (
    id,
    user_id,
    name,
    description,
    username,
    address,
    status,
    is_active,
    logo,
    email,
    contact,
    created_at,
    updated_at
)
SELECT 
    gen_random_uuid()::text,
    u.id,
    'Tech Store',
    'Cửa hàng chuyên bán tai nghe, loa Bluetooth và phụ kiện âm thanh chính hãng. Cam kết chất lượng và giá tốt nhất thị trường.',
    'techstore',
    '123 Đường Nguyễn Huệ, Quận 1, TP.HCM',
    'active',
    true,
    'https://i.pravatar.cc/200?img=11',
    'techstore@example.com',
    '0901234567',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'techstore@example.com'
LIMIT 1
ON CONFLICT (id) DO NOTHING;

-- Store 2: Audio Shop - Chuyên loa, tai nghe cao cấp
INSERT INTO stores (
    id,
    user_id,
    name,
    description,
    username,
    address,
    status,
    is_active,
    logo,
    email,
    contact,
    created_at,
    updated_at
)
SELECT 
    gen_random_uuid()::text,
    u.id,
    'Audio Shop',
    'Chuyên cung cấp thiết bị âm thanh cao cấp: loa Bluetooth, tai nghe chống ồn, dàn âm thanh. Sản phẩm nhập khẩu chính hãng.',
    'audioshop',
    '456 Đường Lê Lợi, Quận 3, TP.HCM',
    'active',
    true,
    'https://i.pravatar.cc/200?img=12',
    'audioshop@example.com',
    '0902345678',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'audioshop@example.com'
LIMIT 1
ON CONFLICT (id) DO NOTHING;

-- Store 3: Watch Store - Chuyên đồng hồ thông minh
INSERT INTO stores (
    id,
    user_id,
    name,
    description,
    username,
    address,
    status,
    is_active,
    logo,
    email,
    contact,
    created_at,
    updated_at
)
SELECT 
    gen_random_uuid()::text,
    u.id,
    'Watch Store',
    'Cửa hàng đồng hồ thông minh hàng đầu. Chuyên Apple Watch, Samsung Galaxy Watch, Garmin và các thương hiệu nổi tiếng khác.',
    'watchstore',
    '789 Đường Điện Biên Phủ, Quận Bình Thạnh, TP.HCM',
    'active',
    true,
    'https://i.pravatar.cc/200?img=13',
    'watchstore@example.com',
    '0903456789',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'watchstore@example.com'
LIMIT 1
ON CONFLICT (id) DO NOTHING;

-- Store 4: Gaming Gear - Chuyên chuột, bàn phím gaming
INSERT INTO stores (
    id,
    user_id,
    name,
    description,
    username,
    address,
    status,
    is_active,
    logo,
    email,
    contact,
    created_at,
    updated_at
)
SELECT 
    gen_random_uuid()::text,
    u.id,
    'Gaming Gear',
    'Thiết bị gaming chuyên nghiệp: chuột gaming, bàn phím cơ, tai nghe gaming, webcam. Hàng chính hãng, bảo hành đầy đủ.',
    'gaminggear',
    '321 Đường Cách Mạng Tháng 8, Quận 10, TP.HCM',
    'active',
    true,
    'https://i.pravatar.cc/200?img=14',
    'gaminggear@example.com',
    '0904567890',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'gaminggear@example.com'
LIMIT 1
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- BƯỚC 3: TẠO PRODUCTS (Sản phẩm)
-- ============================================

-- ===== STORE 1: TECH STORE =====

-- Product 1: Tai nghe Sony WH-1000XM4
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Tai nghe Sony WH-1000XM4',
    'Tai nghe chống ồn chủ động với công nghệ Noise Cancelling tiên tiến, pin 30 giờ, chất lượng âm thanh Hi-Res Audio. Phù hợp cho công việc và giải trí.',
    6000000.0,
    5000000.0,
    'Headphones',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'techstore'
LIMIT 1;

-- Images cho Product 1
INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'
FROM products p
WHERE p.name = 'Tai nghe Sony WH-1000XM4'
ORDER BY p.created_at DESC
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=500'
FROM products p
WHERE p.name = 'Tai nghe Sony WH-1000XM4'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 2: Loa JBL Flip 6
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Loa JBL Flip 6 - Bluetooth Portable',
    'Loa Bluetooth di động với âm bass mạnh mẽ, chống nước IPX7, pin 12 giờ. Thiết kế gọn nhẹ, dễ mang theo mọi nơi.',
    3500000.0,
    2800000.0,
    'Speakers',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'techstore'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500'
FROM products p
WHERE p.name = 'Loa JBL Flip 6 - Bluetooth Portable'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 3: AirPods Pro 2
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'AirPods Pro 2 - True Wireless',
    'Tai nghe True Wireless với chống ồn chủ động, chống nước IPX4, pin 6 giờ + case 24 giờ. Tương thích hoàn hảo với iPhone và iPad.',
    7000000.0,
    5500000.0,
    'Earbuds',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'techstore'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=500'
FROM products p
WHERE p.name = 'AirPods Pro 2 - True Wireless'
ORDER BY p.created_at DESC
LIMIT 1;

-- ===== STORE 2: AUDIO SHOP =====

-- Product 4: Loa Sonos Move
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Loa Sonos Move - Smart Speaker',
    'Loa thông minh di động với Wi-Fi và Bluetooth, chống nước, pin 10 giờ. Âm thanh 360 độ, tích hợp Alexa và Google Assistant.',
    12000000.0,
    9500000.0,
    'Speakers',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'audioshop'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500'
FROM products p
WHERE p.name = 'Loa Sonos Move - Smart Speaker'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 5: Bose QuietComfort 45
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Bose QuietComfort 45',
    'Tai nghe chống ồn hàng đầu với công nghệ Acoustic Noise Cancelling, pin 24 giờ, chất lượng âm thanh cao cấp. Thoải mái đeo cả ngày.',
    8000000.0,
    6500000.0,
    'Headphones',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'audioshop'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'
FROM products p
WHERE p.name = 'Bose QuietComfort 45'
ORDER BY p.created_at DESC
LIMIT 1;

-- ===== STORE 3: WATCH STORE =====

-- Product 6: Apple Watch Series 9
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Apple Watch Series 9',
    'Đồng hồ thông minh với màn hình Always-On Retina, theo dõi sức khỏe 24/7, đo nhịp tim, SpO2. Pin 18 giờ, chống nước 50m.',
    12000000.0,
    10000000.0,
    'Watch',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'watchstore'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'
FROM products p
WHERE p.name = 'Apple Watch Series 9'
ORDER BY p.created_at DESC
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=500'
FROM products p
WHERE p.name = 'Apple Watch Series 9'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 7: Samsung Galaxy Watch 6
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Samsung Galaxy Watch 6',
    'Đồng hồ thông minh Android với màn hình AMOLED, theo dõi sức khỏe, đo huyết áp, SpO2. Pin 40 giờ, chống nước 5ATM.',
    9000000.0,
    7500000.0,
    'Watch',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'watchstore'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'
FROM products p
WHERE p.name = 'Samsung Galaxy Watch 6'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 8: Garmin Forerunner 255
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Garmin Forerunner 255 - Running Watch',
    'Đồng hồ chạy bộ chuyên nghiệp với GPS chính xác, theo dõi nhịp tim, phân tích hiệu suất. Pin 14 ngày, chống nước 5ATM.',
    8500000.0,
    7000000.0,
    'Watch',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'watchstore'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'
FROM products p
WHERE p.name = 'Garmin Forerunner 255 - Running Watch'
ORDER BY p.created_at DESC
LIMIT 1;

-- ===== STORE 4: GAMING GEAR =====

-- Product 9: Logitech G Pro X Superlight
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Logitech G Pro X Superlight',
    'Chuột gaming không dây siêu nhẹ 63g, sensor HERO 25K, pin 70 giờ. Được các game thủ chuyên nghiệp tin dùng.',
    3500000.0,
    2800000.0,
    'Mouse',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'gaminggear'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500'
FROM products p
WHERE p.name = 'Logitech G Pro X Superlight'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 10: Razer DeathAdder V3 Pro
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Razer DeathAdder V3 Pro',
    'Chuột gaming không dây với sensor Focus Pro 30K, thiết kế ergonomic, pin 90 giờ. Phù hợp cho FPS và MOBA games.',
    4000000.0,
    3200000.0,
    'Mouse',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'gaminggear'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500'
FROM products p
WHERE p.name = 'Razer DeathAdder V3 Pro'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 11: Keychron K8 Pro
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'Keychron K8 Pro - Mechanical Keyboard',
    'Bàn phím cơ không dây với switch Gateron, layout 87 keys, pin 400 giờ. Hỗ trợ QMK/VIA, tương thích Mac/Windows.',
    4500000.0,
    3800000.0,
    'Keyboard',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'gaminggear'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500'
FROM products p
WHERE p.name = 'Keychron K8 Pro - Mechanical Keyboard'
ORDER BY p.created_at DESC
LIMIT 1;

-- Product 12: HyperX Cloud Alpha
INSERT INTO products (id, name, description, mrp, price, category, in_stock, store_id, created_at, updated_at)
SELECT 
    gen_random_uuid()::text,
    'HyperX Cloud Alpha - Gaming Headset',
    'Tai nghe gaming với driver kép 50mm, mic detachable, dây cáp dài 1.3m. Âm thanh rõ ràng, bass mạnh cho gaming.',
    3500000.0,
    2800000.0,
    'Headphones',
    true,
    s.id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM stores s
WHERE s.username = 'gaminggear'
LIMIT 1;

INSERT INTO product_images (product_id, image)
SELECT p.id, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'
FROM products p
WHERE p.name = 'HyperX Cloud Alpha - Gaming Headset'
ORDER BY p.created_at DESC
LIMIT 1;

-- ============================================
-- KIỂM TRA KẾT QUẢ
-- ============================================

-- Xem tất cả stores
SELECT id, name, username, status, is_active FROM stores;

-- Xem tất cả products
SELECT p.id, p.name, p.category, p.price, s.name as store_name
FROM products p
JOIN stores s ON p.store_id = s.id
ORDER BY s.name, p.name;

-- Đếm products theo store
SELECT s.name as store_name, COUNT(p.id) as product_count
FROM stores s
LEFT JOIN products p ON s.id = p.store_id
GROUP BY s.name;
