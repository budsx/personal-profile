# Stage 1: Build Tailwind CSS with Node.js
FROM node:18 AS build

WORKDIR /app

# Copy package.json and package-lock.json, then install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the project files
COPY . .

# Run the Tailwind CSS build
# Here, we assume your output.css is already generated in src, so we skip the build command
# If it needs to be built, use: RUN npx tailwindcss -i ./src/input.css -o ./src/output.css --minify
RUN npx tailwindcss -i ./src/input.css -o ./src/output.css --minify

# Stage 2: Production Environment
FROM nginx:alpine

# Copy the HTML and CSS files to Nginx's default web directory
COPY --from=build /app/src /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
