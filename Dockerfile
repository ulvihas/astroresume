FROM node:18-slim

# Install dependencies for Playwright
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libnspr4 \
    libssl3 \
    libfuse2 \
    wget

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy project files
COPY . .

# Build the project
RUN yarn build

# Expose port
EXPOSE 80

# Start the application
CMD ["yarn", "start"]
