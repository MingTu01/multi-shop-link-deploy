FROM node:20-bookworm-slim

WORKDIR /app

# Install build tools for native modules (better-sqlite3)
RUN apt-get update && \
    apt-get install -y python3 make g++ --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy and install dependencies
COPY package.json ./
RUN npm install --omit=dev && npm cache clean --force

# Keep build tools for runtime npm install via entrypoint.sh

# Copy server source
COPY src ./src/
COPY tsconfig.json ./

# Copy frontend build to /app/public/web-dist
COPY public ./public/

# Also symlink to /public/web-dist for path resolution
RUN mkdir -p /public && ln -s /app/public/web-dist /public/web-dist

# Create persistent directories
RUN mkdir -p data uploads backups

# Copy startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set timezone
ENV TZ=Asia/Shanghai

ENV NODE_ENV=production
ENV PORT=3001

EXPOSE 3001

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://localhost:3001/api/health').then(r=>{if(!r.ok)process.exit(1)}).catch(()=>process.exit(1))" || exit 1

ENTRYPOINT ["/entrypoint.sh"]