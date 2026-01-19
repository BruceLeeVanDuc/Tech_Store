-- Kiểm tra tên bảng thực tế trong database
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

