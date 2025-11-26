# Use the official Node.js LTS image
FROM node:20

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json if available
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Expose port 3000 (to match your app)
EXPOSE 3000

# Command to run your app
CMD ["node", "app.js"]
