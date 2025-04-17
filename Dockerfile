# Stage 1: Build React app
FROM node:18-alpine as builder

WORKDIR /app
COPY . .

# Install dependencies and build
RUN npm install
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:stable-alpine

# Copy build output to nginx's html directory
COPY --from=builder /app/build /usr/share/nginx/html

# Remove default nginx config and add custom one if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf  # Optional

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
