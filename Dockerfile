# Stage 1: Build frontend
FROM node:16 AS build-stage

# Set working directory
WORKDIR /app

# Copy public folder
COPY public ./public

# Install any necessary packages if needed (like a build tool)
# RUN npm install <dependencies>

# Optionally build the frontend if needed
# RUN npm run build 

# Stage 2: Setup the backend and Nginx
FROM node:16 AS production-stage

# Set working directory
WORKDIR /app

# Copy the src folder
COPY src ./src

# Copy only necessary files from the previous stage
COPY --from=build-stage /app/public ./public

# Install backend dependencies
RUN npm install --production

# Expose the port that the app runs on
EXPOSE 3000

# Start the Node.js server
CMD ["node", "src/server.js"]

# Stage 3: Setup Nginx to serve the frontend
FROM nginx:alpine

# Copy the built frontend files to Nginx
COPY --from=build-stage /app/public /usr/share/nginx/html

# Copy default Nginx configuration if you have one (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port that Nginx runs on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]



