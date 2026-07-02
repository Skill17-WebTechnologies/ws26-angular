FROM node:24.1.0-bookworm
RUN npm install -g npm@11.5.0
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 4200
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--port", "4200"]
