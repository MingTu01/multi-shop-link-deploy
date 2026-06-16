FROM node:20-alpine

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm install --production=false

# Copy application
COPY . .

# Create data directories
RUN mkdir -p data uploads backups public/reports public/web-dist

# Set timezone
ENV TZ=Asia/Shanghai

EXPOSE 3001

CMD ["node", "--import", "tsx", "src/index.ts"]
