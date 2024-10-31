# Stage 1: Build the React app
FROM node:18 AS build

# Set working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code to the container
COPY . .

# Build the app (output will go to /usr/src/app/build)
RUN npm run build

# Stage 2: Serve the app with an Nginx server
FROM nginx:alpine

# Copy built files from the previous stage to Nginx's default directory
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
