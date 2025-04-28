# Use Node.js 23 Alpine image as base
FROM node:23-alpine3.20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json first (and package-lock.json if you have it)
COPY package.json /app
# If you have package-lock.json, also copy it
# COPY package-lock.json /app

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . /app

# Expose the port the app runs on
EXPOSE 3000

# Run the app
CMD ["npm", "start"]