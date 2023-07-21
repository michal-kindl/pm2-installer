@echo off
echo "=== Setup PM2 and HEX ==="

echo "Configure npm"
call npm run configure

call refreshenv

echo "Setup PM2"
call npm run setup

call refreshenv

:: offline install pm2-logrotate
:: call pm2 install ../../pm2-logrotate-2.7.0.tar.gz

echo "Add HEX-API Server service"
cd ../../../PLC-Studio-API-Server
echo %cd%
call pm2 start node --name hex-api --restart-delay=10000 -- ./dist-min/server.js

echo "Add HEX-HMI Server service"
cd ../PLC-Studio-HMI
echo %cd%
call pm2 start node --name hex-hmi -- c:/ProgramData/npm/npm/node_modules/http-server/bin/http-server ./dist -p 80 -P http://localhost:3000

echo "Save PM2 configuration"
call pm2 save

echo "=== PM2 & HEX setup complete ==="
