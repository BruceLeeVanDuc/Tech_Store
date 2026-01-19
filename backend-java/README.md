# GoCart Backend - Java Spring Boot

Backend API cho ứng dụng e-commerce GoCart được xây dựng bằng Java Spring Boot.

## Yêu cầu

- Java 17 hoặc cao hơn
- Maven 3.6+
- PostgreSQL database

## Cấu hình

1. Sao chép file `application.properties` và cấu hình database:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/gocart
spring.datasource.username=postgres
spring.datasource.password=postgres
```

Hoặc sử dụng biến môi trường:
- `DATABASE_URL`: JDBC URL cho PostgreSQL
- `DB_USERNAME`: Username database
- `DB_PASSWORD`: Password database
- `CORS_ORIGINS`: Các origin được phép cho CORS (mặc định: http://localhost:3000)

## Chạy ứng dụng

### Sử dụng Maven:

```bash
# Chạy ứng dụng
mvn spring-boot:run

# Build JAR file
mvn clean package

# Chạy JAR file
java -jar target/backend-1.0.0.jar
```

### Sử dụng IDE:

Chạy class `GoCartApplication.java` từ IDE của bạn.

## API Endpoints

### Products
- `GET /api/products` - Lấy tất cả sản phẩm
- `GET /api/products/{id}` - Lấy sản phẩm theo ID
- `GET /api/products/store/{storeId}` - Lấy sản phẩm theo cửa hàng
- `GET /api/products/category/{category}` - Lấy sản phẩm theo danh mục
- `GET /api/products/latest` - Lấy sản phẩm mới nhất
- `GET /api/products/search?keyword={keyword}` - Tìm kiếm sản phẩm
- `POST /api/products` - Tạo sản phẩm mới
- `PUT /api/products/{id}` - Cập nhật sản phẩm
- `DELETE /api/products/{id}` - Xóa sản phẩm

### Orders
- `GET /api/orders` - Lấy tất cả đơn hàng
- `GET /api/orders/{id}` - Lấy đơn hàng theo ID
- `GET /api/orders/user/{userId}` - Lấy đơn hàng theo người dùng
- `GET /api/orders/store/{storeId}` - Lấy đơn hàng theo cửa hàng
- `GET /api/orders/store/{storeId}/status/{status}` - Lấy đơn hàng theo cửa hàng và trạng thái
- `POST /api/orders` - Tạo đơn hàng mới
- `PATCH /api/orders/{id}/status` - Cập nhật trạng thái đơn hàng
- `DELETE /api/orders/{id}` - Xóa đơn hàng

### Stores
- `GET /api/stores` - Lấy tất cả cửa hàng
- `GET /api/stores/active` - Lấy các cửa hàng đang hoạt động
- `GET /api/stores/status/{status}` - Lấy cửa hàng theo trạng thái
- `GET /api/stores/{id}` - Lấy cửa hàng theo ID
- `GET /api/stores/username/{username}` - Lấy cửa hàng theo username
- `GET /api/stores/user/{userId}` - Lấy cửa hàng theo user ID
- `POST /api/stores` - Tạo cửa hàng mới
- `PUT /api/stores/{id}` - Cập nhật cửa hàng
- `DELETE /api/stores/{id}` - Xóa cửa hàng

### Ratings
- `GET /api/ratings/product/{productId}` - Lấy đánh giá theo sản phẩm
- `GET /api/ratings/user/{userId}` - Lấy đánh giá theo người dùng
- `GET /api/ratings/user/{userId}/product/{productId}/order/{orderId}` - Lấy đánh giá cụ thể
- `POST /api/ratings` - Tạo/cập nhật đánh giá
- `DELETE /api/ratings/{id}` - Xóa đánh giá

### Addresses
- `GET /api/addresses/user/{userId}` - Lấy địa chỉ theo người dùng
- `GET /api/addresses/{id}` - Lấy địa chỉ theo ID
- `POST /api/addresses` - Tạo địa chỉ mới
- `PUT /api/addresses/{id}` - Cập nhật địa chỉ
- `DELETE /api/addresses/{id}` - Xóa địa chỉ

### Coupons
- `GET /api/coupons` - Lấy tất cả mã giảm giá
- `GET /api/coupons/public` - Lấy mã giảm giá công khai
- `GET /api/coupons/code/{code}` - Lấy mã giảm giá theo code
- `POST /api/coupons` - Tạo mã giảm giá mới
- `PUT /api/coupons/{code}` - Cập nhật mã giảm giá
- `DELETE /api/coupons/{code}` - Xóa mã giảm giá

### Users
- `GET /api/users` - Lấy tất cả người dùng
- `GET /api/users/{id}` - Lấy người dùng theo ID
- `GET /api/users/email/{email}` - Lấy người dùng theo email
- `POST /api/users` - Tạo người dùng mới
- `PUT /api/users/{id}` - Cập nhật người dùng
- `DELETE /api/users/{id}` - Xóa người dùng

## Cấu trúc dự án

```
backend-java/
├── src/
│   ├── main/
│   │   ├── java/com/gocart/
│   │   │   ├── config/          # Cấu hình (CORS, etc.)
│   │   │   ├── controller/      # REST Controllers
│   │   │   ├── model/           # Entity classes
│   │   │   ├── repository/      # JPA Repositories
│   │   │   ├── service/         # Business logic
│   │   │   └── GoCartApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
└── pom.xml
```

## Kết nối với Frontend Next.js

Backend chạy trên port 8080 (mặc định). Frontend Next.js có thể gọi API thông qua:

```javascript
const response = await fetch('http://localhost:8080/api/products');
const products = await response.json();
```

Đảm bảo CORS đã được cấu hình đúng trong `application.properties` hoặc `CorsConfig.java`.

## Ghi chú

- Database schema phải khớp với Prisma schema trong frontend
- JPA sẽ validate schema khi khởi động (ddl-auto=validate)
- Tất cả các endpoint đều hỗ trợ CORS cho frontend

