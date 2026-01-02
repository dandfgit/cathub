@echo off
REM ═══════════════════════════════════════════
REM   CatHub Fluent Builder
REM   Builds source files to main.lua
REM ═══════════════════════════════════════════

echo.
echo  🐱 CatHub Fluent Builder
echo  ═══════════════════════════
echo.

REM Check if tools are installed
where rojo >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] Rojo not found. Installing via aftman...
    aftman install
)

where darklua >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] Darklua not found. Installing via aftman...
    aftman install
)

where lune >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] Lune not found. Installing via aftman...
    aftman install
)

echo [1/3] Building with Rojo...
if not exist "dist" mkdir dist
rojo build -o dist/main.rbxm

echo [2/3] Running Lune builder...
lune build

echo [3/3] Copying to main.lua...
if exist "dist\main.lua" (
    copy /Y "dist\main.lua" "main.lua" >nul
    echo.
    echo  ✅ Build complete! main.lua updated.
    echo.
) else (
    echo.
    echo  ❌ Build failed - dist/main.lua not found
    echo.
)

pause
