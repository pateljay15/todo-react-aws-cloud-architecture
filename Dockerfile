# Step 1: Build the React app with Vite
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the source code and build the app
COPY . ./
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the build output from the first stage to Nginx’s public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
