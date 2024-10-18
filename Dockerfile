FROM node:18
WORKDIR /app
COPY package*.json ./

RUN npm install

COPY . .

# Exposing port mà ứng dụng sẽ chạy (ví dụ: 3000)
EXPOSE 3000

# Khởi chạy ứng dụng
CMD [ "npm", "start" ]
