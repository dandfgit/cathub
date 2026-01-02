# 🐱 CatHub Fluent Build System

## Quick Start

### Step 1: Install Aftman (Package Manager)
```powershell
# Install aftman (run PowerShell as Administrator)
irm "https://github.com/LPGhatguy/aftman/releases/latest/download/aftman-windows-x86_64.zip" -OutFile aftman.zip
Expand-Archive aftman.zip -DestinationPath "$env:USERPROFILE\.aftman"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:USERPROFILE\.aftman\bin", "User")
```

Or download manually from: https://github.com/LPGhatguy/aftman/releases

### Step 2: Install Build Tools
```bash
cd e:\CatHub\cathub_src\Fluent-master
aftman install
```

This installs:
- **Rojo** - Lua bundler for Roblox
- **Darklua** - Lua minifier
- **Lune** - Lua runtime for build scripts

### Step 3: Build
```bash
.\build.bat
```

---

## What Happens During Build

```
┌─────────────┐    ┌──────────┐    ┌─────────────┐    ┌──────────┐
│ src/*.lua   │───►│   Rojo   │───►│ main.rbxm   │───►│  Lune    │
│ (readable)  │    │ (bundle) │    │ (binary)    │    │ (codegen)│
└─────────────┘    └──────────┘    └─────────────┘    └──────────┘
                                                            │
                                                            ▼
                                                     ┌──────────┐
                                                     │ Darklua  │
                                                     │ (minify) │
                                                     └──────────┘
                                                            │
                                                            ▼
                                                     ┌──────────┐
                                                     │ main.lua │
                                                     │ (output) │
                                                     └──────────┘
```

---

## File Locations

| To Edit | File |
|---------|------|
| Window/Sidebar | `src/Components/Window.lua` |
| Section Headers | `src/Components/Section.lua` |
| Background | `src/Acrylic/AcrylicPaint.lua` |
| Themes | `src/Themes/*.lua` |
| Elements | `src/Elements/*.lua` |

---

## Current UI Customizations

These changes are already applied:

- ✅ **Background Transparency**: 0.35 (more see-through)
- ✅ **Sidebar**: Fully transparent (no dark background)
- ✅ **Section Headers**: Hidden (saves vertical space)
- ✅ **Tab Display ("Main")**: Hidden (cleaner look)

---

## After Build

Push to GitHub to deploy:
```bash
git add .
git commit -m "build: update main.lua"
git push
```
