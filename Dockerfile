# Sử dụng một image Node.js chính thức
FROM node:18

# Thiết lập thư mục làm việc trong container
WORKDIR /usr/src/app

# Sao chép file package.json và package-lock.json
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install

# Sao chép toàn bộ mã nguồn của ứng dụng vào container
COPY . .

# Mở cổng 80
EXPOSE 80

# Lệnh để chạy ứng dụng
CMD ["node", "src/index.js"]
