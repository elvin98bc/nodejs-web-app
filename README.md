# Build the Docker image
docker build -t nodejs-web-app .

# Run the Docker container
docker run -p 3000:3000 nodejs-web-app# nodejs-web-app
