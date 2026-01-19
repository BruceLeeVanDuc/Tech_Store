-- ============================================
-- Script kiểm tra dữ liệu đã insert
-- ============================================

-- Kiểm tra số lượng Users
SELECT 'Users' as table_name, COUNT(*) as count FROM "User";

-- Kiểm tra số lượng Stores
SELECT 'Stores' as table_name, COUNT(*) as count FROM "Store";

-- Kiểm tra số lượng Products
SELECT 'Products' as table_name, COUNT(*) as count FROM "Product";

-- Kiểm tra số lượng Product Images
SELECT 'Product Images' as table_name, COUNT(*) as count FROM product_images;

-- Xem danh sách Stores
SELECT id, name, username, status, "isActive" 
FROM "Store" 
ORDER BY name;

-- Xem danh sách Products theo Store
SELECT 
    s.name as store_name,
    p.name as product_name,
    p.category,
    p.price,
    COUNT(pi.image) as image_count
FROM "Product" p
JOIN "Store" s ON p."storeId" = s.id
LEFT JOIN product_images pi ON p.id = pi.product_id
GROUP BY s.name, p.name, p.category, p.price
ORDER BY s.name, p.name;

-- Đếm products theo store
SELECT 
    s.name as store_name,
    COUNT(p.id) as product_count
FROM "Store" s
LEFT JOIN "Product" p ON s.id = p."storeId"
GROUP BY s.name
ORDER BY s.name;

