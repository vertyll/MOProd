# Use the Node.js image as the base
ARG FRONTEND_TAG
FROM node:${FRONTEND_TAG}

# Set the working directory inside the container
WORKDIR /usr/src/app

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
      "development") \
        echo "Skipping build for development environment" ;; \
      *) \
        echo "Unknown NODE_ENV: $NODE_ENV" && exit 1 ;; \
    esac

# Expose the application port
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 CMD curl --fail http://localhost:3000 || exit 1

# Command to run the application based on environment
CMD case "$NODE_ENV" in \
      "development") \
        npm run dev ;; \
      "production") \
        npm run start ;; \
      *) \
        echo "Unknown NODE_ENV: $NODE_ENV" && exit 1 ;; \
    esac
