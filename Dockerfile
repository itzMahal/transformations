# Build stage
FROM node:18-alpine AS builder   # use a lightweight Node image
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build   # produce production build in e.g. /app/build or similar

# Production stage
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
