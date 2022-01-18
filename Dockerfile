#Dockerfile for the Test-NodeApp

#Defining the Node's Basw Image
FROM node:alpine

#Creating the Working Directory
WORKDIR /app

#Copy the package*.json file to working directory
COPY package*.json /app

#Copy all the files to Docker
COPY . .

#Installation of npm build package
CMD apt-get update && \
    apt-get install npm

#Installation of node packages
RUN npm install

#Expose the port used by the Application
EXPOSE 8080

#Run the Node Application
CMD ["node","server.js"]

