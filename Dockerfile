# Stage 1: Pruning
FROM node:20.15.0 AS pruner
WORKDIR /app
RUN npm install -g pnpm@9.5.0
COPY . .
RUN pnpm dlx turbo prune --scope=frontend --scope=backend --docker

# Stage 2: Installing dependencies
FROM node:20.15.0 AS installer
WORKDIR /app
RUN npm install -g pnpm@9.5.0
COPY --from=pruner /app/out/json/ .
COPY --from=pruner /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "production" ]; then \
      pnpm install --prod; \
    else \
      pnpm install; \
    fi

# Stage 3: Building
FROM node:20.15.0 AS builder
WORKDIR /app
RUN npm install -g pnpm@9.5.0
COPY --from=installer /app/ .
COPY --from=pruner /app/out/full/ .
COPY turbo.json turbo.json
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "production" ]; then \
      pnpm run build; \
    else \
      echo "Skipping build for development environment"; \
    fi

# Stage 4: Running
FROM node:20.15.0 AS runner
WORKDIR /app
RUN npm install -g pnpm@9.5.0

# Copy built files and dependencies
COPY --from=builder /app/package.json .
COPY --from=builder /app/pnpm-lock.yaml .
COPY --from=builder /app/apps ./apps
COPY --from=builder /app/node_modules ./node_modules

# Copy scripts
COPY apps/backend/docker/wait-for-it.sh /usr/local/bin/wait-for-it.sh
COPY apps/backend/docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh /usr/local/bin/entrypoint.sh

# Set environment variables
ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV
RUN echo "NODE_ENV: $NODE_ENV"

# Expose ports
EXPOSE 3000 3200

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000 && \
      wget --no-verbose --tries=1 --spider http://localhost:3200 || exit 1

# Declare entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Command to run the applications based on environment
CMD if [ "$NODE_ENV" = "production" ]; then \
      pnpm start; \
    else \
      pnpm dev; \
    fi
