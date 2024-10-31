# Bước 1: Build backend với Node.js
FROM node:18-alpine AS builder

# Tạo thư mục cho ứng dụng và sao chép code vào
WORKDIR /app
COPY package*.json ./
COPY src/ ./src
COPY public ./public

# Cài đặt các package và build ứng dụng
RUN npm install
RUN npm run build

# Bước 2: Cấu hình Nginx để deploy
FROM nginx:alpine

# Copy file cấu hình Nginx tùy chỉnh
COPY nginx.conf /etc/nginx/nginx.conf

# Copy thư mục public (chứa index.html và CSS) từ bước build vào thư mục của Nginx
COPY --from=builder /app/public /usr/share/nginx/html

# Chạy ứng dụng
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
