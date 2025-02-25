# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and yarn.lock files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the Astro project (creates static files in the 'dist' folder)
RUN yarn build

# Install serve globally to serve static files
RUN yarn global add serve

# Expose port 80 (default for web traffic)
EXPOSE 80

# Start the app in production mode using serve
CMD ["serve", "-s", "dist", "-l", "80"]
