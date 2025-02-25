# Use an official Node.js runtime as a parent image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and yarn.lock files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the Astro project
RUN yarn build

# Expose port 80 (default for web traffic)
EXPOSE 80

# Command to start the app (you may need to modify if using other start commands)
CMD ["yarn", "start"]
