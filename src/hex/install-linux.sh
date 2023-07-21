#!/bin/bash
echo "=== Setup PM2 and HEX ==="

echo "Setup PM2"
sudo npm run setup

echo "setup http-server"
npm install -g http-server

echo "Add HEX-API Server service"
cd ../PLC-Studio-API-Server
sudo pm2 start node --name hex-api --restart-delay=10000 -- dist-min/server.js

echo "Add HEX-HMI Server service"
cd ../PLC-Studio-HMI
sudo pm2 start node --name hex-hmi -- $(which http-server) dist -p 4200 -P http://localhost:3000

echo "Save PM2 configuration"
sudo pm2 save

echo "=== PM2 & HEX setup complete ==="
