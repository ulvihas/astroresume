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
    libssl1.1 \
    libfuse2 \
    wget

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Install Playwright and necessary browsers
RUN npx playwright install

# Copy project files
COPY . .

# Build the project
RUN yarn build

# Serve the static files
RUN yarn global add serve
CMD ["serve", "-s", "dist"]
