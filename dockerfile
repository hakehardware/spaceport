# Use an official Node.js runtime as a parent image
FROM node:20.12.2

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

COPY prisma ./prisma/

RUN npx prisma generate
# Bundle app source inside the Docker image
COPY . .

# Build your Next.js application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]