---
description: How to build Fluent source files to main.lua
---

# Build Fluent Library

This workflow compiles all source files in `src/` to a single minified `main.lua`.

## Prerequisites
Install the required tools using aftman:
```bash
cd Fluent-master
aftman install
```

This installs:
- Rojo (v7.3.0) - builds Lua to .rbxm
- Darklua (v0.9.0) - minifies Lua code
- Lune (v0.7.6) - runs build scripts

## Build Steps

// turbo-all

### 1. Navigate to Fluent directory
```bash
cd e:\CatHub\cathub_src\Fluent-master
```

### 2. Run the build script
```bash
.\build.bat
```

Or manually:
```bash
# Step 1: Build .rbxm with Rojo
mkdir dist 2>nul
rojo build -o dist/main.rbxm

# Step 2: Run Lune builder
lune build

# Step 3: Copy result
copy dist\main.lua main.lua
```

## File Structure

```
Fluent-master/
├── src/                    ← SOURCE (edit this!)
│   ├── Components/
│   │   ├── Window.lua      ← TabDisplay, Sidebar
│   │   ├── Section.lua     ← Section headers
│   │   └── ...
│   ├── Acrylic/
│   │   └── AcrylicPaint.lua ← Background transparency
│   └── Themes/
│       └── *.lua           ← Color themes
├── build/                  ← Build scripts
├── dist/                   ← Build output
└── main.lua               ← FINAL OUTPUT (auto-generated)
```

## After Building

Push to GitHub to update the online version:
```bash
git add main.lua
git commit -m "build: update main.lua from source"
git push
```
