#!/bin/sh
set -e

cd /app

# Check if package.json exists and sync npm dependencies
if [ -f package.json ]; then
  # Quick check: if node_modules exists and package.json hasn't changed, skip install
  STAMP_FILE="/app/data/.npm_install_stamp"
  CURRENT_HASH=$(md5sum package.json 2>/dev/null | cut -d' ' -f1)
  STORED_HASH=""
  if [ -f "$STAMP_FILE" ]; then
    STORED_HASH=$(cat "$STAMP_FILE" 2>/dev/null)
  fi

  if [ "$CURRENT_HASH" != "$STORED_HASH" ] || [ ! -d /app/node_modules ]; then
    echo "[Startup] package.json changed or node_modules missing, running npm install..."
    npm install --omit=dev 2>&1 || echo "[Startup] npm install had warnings (non-fatal)"
    mkdir -p /app/data
    echo "$CURRENT_HASH" > "$STAMP_FILE"
    echo "[Startup] npm install completed"
  else
    echo "[Startup] node_modules up to date, skipping npm install"
  fi
fi

# Start the application
echo "[Startup] Starting application..."
exec node --import tsx src/index.ts
