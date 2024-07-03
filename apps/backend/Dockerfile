# Use the official Node.js image as the base
ARG BACKEND_TAG
FROM node:${BACKEND_TAG}

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies based on environment
RUN case "$NODE_ENV" in \
      "development") \
        npm install ;; \
      "production") \
        npm install --only=production ;; \
      *) \
        echo "Unknown NODE_ENV: $NODE_ENV" && exit 1 ;; \
    esac

# Copy the rest of the application files to the working directory
COPY . .

# Build the application in production
RUN case "$NODE_ENV" in \
      "production") \
        npm run build ;; \
      "development" | *) \
        echo "Skipping build for $NODE_ENV" ;; \
    esac

# Copy wait-for-it script
COPY docker/wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Copy entrypoint script based on environment
RUN case "$NODE_ENV" in \
      "development") \
        cp docker/entrypoint.dev.sh /usr/local/bin/entrypoint.sh ;; \
      "production") \
        cp docker/entrypoint.prod.sh /usr/local/bin/entrypoint.sh ;; \
      *) \
        echo "Unknown NODE_ENV: $NODE_ENV" && exit 1 ;; \
    esac
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the port the application will run on
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 CMD curl --fail http://localhost:3000 || exit 1

# Start the application using the entrypoint script based on environment
ENTRYPOINT ["sh", "-c", "case \"$NODE_ENV\" in development) /usr/local/bin/entrypoint.dev.sh ;; production) /usr/local/bin/entrypoint.prod.sh ;; *) echo \"Unknown NODE_ENV: $NODE_ENV\" && exit 1 ;; esac"]
