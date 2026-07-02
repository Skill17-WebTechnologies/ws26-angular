# --- build the production bundle ---
FROM node:24.1.0-bookworm AS build
RUN npm install -g npm@11.5.0
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# --- serve the static bundle with nginx (no dev-server host checks) ---
FROM nginx:alpine
COPY --from=build /app/dist/app/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
