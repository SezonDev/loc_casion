@echo off
title Restart Loc'casion Backend
color 0B

echo ================================================
echo     🚀 Restarting Loc'casion Backend...
echo ================================================
echo.

REM --- CONFIG ---
set BACKEND_PATH=C:\Users\Alexis-PC\Loc'casion-nestJs\loccasion-backend
set PORT=3000

echo 📁 Moving to backend folder...
cd /d "%BACKEND_PATH%"

echo.
echo 📦 Killing old Node processes...
taskkill /IM node.exe /F >nul 2>nul

echo.
echo 🧪 Checking Node version...
node -v

echo.
echo 🔄 Installing dependencies (npm install)...
call npm install

echo.
echo 🔄 Generating Prisma Client...
call npx prisma generate

echo.
echo 🧪 Checking database connection...
call npx prisma db pull

echo.
echo 🔥 Starting NestJS (npm run start:dev) in new window...
start cmd /k "cd /d %BACKEND_PATH% && npm run start:dev"

echo.
echo 🌐 Backend should be available at:
echo     http://localhost:%PORT%

echo.
echo 🔍 Testing /auth/health...
curl http://localhost:%PORT%/auth/health

echo.
echo ✨ Backend restarted successfully!
echo.
pause