# ---- Base Node ----
FROM node:21.6.1-bullseye AS base
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# ---- Build ----
FROM base AS build
WORKDIR /app
RUN npm run build

# --- Release with Nginx ----
FROM nginx:1.21.1-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/build/ .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]