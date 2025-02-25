# Use a slim Node.js image as the base
FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy only package.json and yarn.lock to leverage Docker caching and avoid unnecessary installs
COPY package.json yarn.lock ./

# Install dependencies using yarn
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Run yarn build and output verbose logs for troubleshooting
RUN yarn build --verbose

# Expose the port the app will run on
EXPOSE 80

# Set the command to run your app
CMD ["yarn", "start"]
