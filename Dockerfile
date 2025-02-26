# Use a base image with Debian (instead of Alpine) for better compatibility
FROM node:18-bullseye

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies first (for better caching)
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Install missing system utilities
RUN apt-get update && apt-get install -y \
    procps \
    curl \
    fonts-liberation \
    libasound2 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxrender1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the project files
COPY . .

# Run build step
RUN yarn build --verbose

# Expose the port for the app
EXPOSE 80

# Start the application
CMD ["yarn", "start"]
