# Build stage using Node.js LTS
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
ENV DISABLE_ESLINT_PLUGIN=true
RUN npm run build

# Production stage using lightweight Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80