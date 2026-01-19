-- SQL Script để tạo database schema trong PostgreSQL
-- Chạy script này trong pgAdmin để tạo tất cả các bảng và quan hệ

-- Tạo các ENUM types
CREATE TYPE "OrderStatus" AS ENUM ('ORDER_PLACED', 'PROCESSING', 'SHIPPED', 'DELIVERED');
CREATE TYPE "PaymentMethod" AS ENUM ('COD', 'STRIPE');

-- Tạo bảng User
CREATE TABLE "User" (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    image TEXT NOT NULL,
    cart JSONB DEFAULT '{}'::jsonb
);

-- Tạo bảng Store
CREATE TABLE "Store" (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    "userId" TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    address TEXT NOT NULL,
    status TEXT DEFAULT 'pending',
    "isActive" BOOLEAN DEFAULT false,
    logo TEXT NOT NULL,
    email TEXT NOT NULL,
    contact TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Store_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tạo bảng Product
CREATE TABLE "Product" (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    mrp DOUBLE PRECISION NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    images TEXT[] NOT NULL,
    category TEXT NOT NULL,
    "inStock" BOOLEAN DEFAULT true,
    "storeId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Product_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng Address
CREATE TABLE "Address" (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    "userId" TEXT NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip TEXT NOT NULL,
    country TEXT NOT NULL,
    phone TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng Order
CREATE TABLE "Order" (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    total DOUBLE PRECISION NOT NULL,
    status "OrderStatus" DEFAULT 'ORDER_PLACED',
    "userId" TEXT NOT NULL,
    "storeId" TEXT NOT NULL,
    "addressId" TEXT NOT NULL,
    "isPaid" BOOLEAN DEFAULT false,
    "paymentMethod" "PaymentMethod" NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "isCouponUsed" BOOLEAN DEFAULT false,
    coupon JSONB DEFAULT '{}'::jsonb,
    CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Order_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Order_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tạo bảng OrderItem
CREATE TABLE "OrderItem" (
    "orderId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    PRIMARY KEY ("orderId", "productId"),
    CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tạo bảng Rating
CREATE TABLE "Rating" (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    rating INTEGER NOT NULL,
    review TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Rating_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Rating_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Rating_userId_productId_orderId_key" UNIQUE ("userId", "productId", "orderId")
);

-- Tạo bảng Coupon
CREATE TABLE "Coupon" (
    code TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    discount DOUBLE PRECISION NOT NULL,
    "forNewUser" BOOLEAN NOT NULL,
    "forMember" BOOLEAN DEFAULT false,
    "isPublic" BOOLEAN NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP
);

-- Tạo indexes để tối ưu hiệu suất (tùy chọn)
CREATE INDEX IF NOT EXISTS "Product_storeId_idx" ON "Product"("storeId");
CREATE INDEX IF NOT EXISTS "Order_userId_idx" ON "Order"("userId");
CREATE INDEX IF NOT EXISTS "Order_storeId_idx" ON "Order"("storeId");
CREATE INDEX IF NOT EXISTS "Order_addressId_idx" ON "Order"("addressId");
CREATE INDEX IF NOT EXISTS "Address_userId_idx" ON "Address"("userId");
CREATE INDEX IF NOT EXISTS "Rating_userId_idx" ON "Rating"("userId");
CREATE INDEX IF NOT EXISTS "Rating_productId_idx" ON "Rating"("productId");
CREATE INDEX IF NOT EXISTS "Store_userId_idx" ON "Store"("userId");

