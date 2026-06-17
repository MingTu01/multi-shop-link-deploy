FROM node:20-bookworm-slim

WORKDIR /app

# Install build tools for native modules (better-sqlite3)
RUN apt-get update && \
    apt-get install -y python3 make g++ --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy package files first (for layer caching)
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install --omit=dev && npm cache clean --force

# Remove build tools to reduce image size
RUN apt-get purge -y python3 make g++ && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Copy application
COPY . .

# Create data directories
RUN mkdir -p data uploads backups public/reports public/web-dist

# Set timezone
ENV TZ=Asia/Shanghai
ENV NODE_ENV=production

EXPOSE 3001

CMD ["node", "--import", "tsx", "src/index.ts"]
