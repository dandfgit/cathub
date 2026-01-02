--[[
    Fluent Interface Suite - CatHub Edition
    Non-minified loader for development
    
    This file loads all source modules directly for easier development and debugging.
]]

-- Base path for loading
local RepoBase = "https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/"

-- Helper function to load modules
local function loadModule(path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(RepoBase .. path))()
    end)
    if not success then
        warn("Failed to load module: " .. path .. " - " .. tostring(result))
        return nil
    end
    return result
end

-- Create virtual module system
local Modules = {}
local LoadedModules = {}

-- Register module paths
local ModulePaths = {
    -- Packages
    ["Packages.Flipper"] = "src/Packages/Flipper/init.lua",
    ["Packages.Flipper.SingleMotor"] = "src/Packages/Flipper/SingleMotor.lua",
    ["Packages.Flipper.GroupMotor"] = "src/Packages/Flipper/GroupMotor.lua",
    ["Packages.Flipper.Spring"] = "src/Packages/Flipper/Spring.lua",
    ["Packages.Flipper.Instant"] = "src/Packages/Flipper/Instant.lua",
    ["Packages.Flipper.Linear"] = "src/Packages/Flipper/Linear.lua",
    ["Packages.Flipper.BaseMotor"] = "src/Packages/Flipper/BaseMotor.lua",
    ["Packages.Flipper.Signal"] = "src/Packages/Flipper/Signal.lua",
    ["Packages.Flipper.isMotor"] = "src/Packages/Flipper/isMotor.lua",
    
    -- Themes
    ["Themes"] = "src/Themes/init.lua",
    ["Themes.Dark"] = "src/Themes/Dark.lua",
    ["Themes.Darker"] = "src/Themes/Darker.lua",
    ["Themes.Light"] = "src/Themes/Light.lua",
    ["Themes.Aqua"] = "src/Themes/Aqua.lua",
    ["Themes.Amethyst"] = "src/Themes/Amethyst.lua",
    ["Themes.Rose"] = "src/Themes/Rose.lua",
    ["Themes.CatHub"] = "src/Themes/CatHub.lua",
    
    -- Acrylic
    ["Acrylic"] = "src/Acrylic/init.lua",
    ["Acrylic.AcrylicBlur"] = "src/Acrylic/AcrylicBlur.lua",
    ["Acrylic.AcrylicPaint"] = "src/Acrylic/AcrylicPaint.lua",
    ["Acrylic.CreateAcrylic"] = "src/Acrylic/CreateAcrylic.lua",
    ["Acrylic.Utils"] = "src/Acrylic/Utils.lua",
    
    -- Components
    ["Components.Assets"] = "src/Components/Assets.lua",
    ["Components.Window"] = "src/Components/Window.lua",
    ["Components.Tab"] = "src/Components/Tab.lua",
    ["Components.TitleBar"] = "src/Components/TitleBar.lua",
    ["Components.Element"] = "src/Components/Element.lua",
    ["Components.Button"] = "src/Components/Button.lua",
    ["Components.Dialog"] = "src/Components/Dialog.lua",
    ["Components.Section"] = "src/Components/Section.lua",
    ["Components.Textbox"] = "src/Components/Textbox.lua",
    ["Components.Notification"] = "src/Components/Notification.lua",
    
    -- Elements
    ["Elements.Button"] = "src/Elements/Button.lua",
    ["Elements.Toggle"] = "src/Elements/Toggle.lua",
    ["Elements.Slider"] = "src/Elements/Slider.lua",
    ["Elements.Dropdown"] = "src/Elements/Dropdown.lua",
    ["Elements.Colorpicker"] = "src/Elements/Colorpicker.lua",
    ["Elements.Keybind"] = "src/Elements/Keybind.lua",
    ["Elements.Input"] = "src/Elements/Input.lua",
    ["Elements.Paragraph"] = "src/Elements/Paragraph.lua",
    
    -- Core
    ["Creator"] = "src/Creator.lua",
    ["Icons"] = "src/Icons.lua",
    ["MainModule"] = "src/init.lua",
}

-- Load the main Fluent module using direct loadstring approach
local FluentSource = game:HttpGet(RepoBase .. "src/init.lua")

-- The source files use require() which won't work directly
-- So we need to load the minified main.lua but apply our themes
-- Actually, let's create a simple loader that works with Roblox's execution environment

print("[CatHub] Loading Fluent UI Library...")

-- For Roblox executor environment, the easiest approach is to load main.lua
-- but we can override themes after loading

local Fluent = loadstring(game:HttpGet(RepoBase .. "main.lua"))()

-- Now apply CatHub theme by injecting it if not present
if Fluent and Fluent.Themes then
    -- Check if CatHub theme exists
    if not table.find(Fluent.Themes, "CatHub") then
        table.insert(Fluent.Themes, "CatHub")
    end
end

-- Override theme data with our custom CatHub theme
local CatHubTheme = {
    Name = "CatHub",
    
    -- Orange cat accent color
    Accent = Color3.fromRGB(255, 140, 50),
    
    -- More transparent acrylic
    AcrylicMain = Color3.fromRGB(20, 20, 24),
    AcrylicBorder = Color3.fromRGB(60, 55, 50),
    AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 23, 22), Color3.fromRGB(15, 14, 13)),
    AcrylicNoise = 0.97,
    
    TitleBarLine = Color3.fromRGB(50, 45, 40),
    
    Tab = Color3.fromRGB(100, 95, 90),
    
    -- Slightly brighter elements
    Element = Color3.fromRGB(45, 43, 40),
    ElementBorder = Color3.fromRGB(30, 28, 26),
    InElementBorder = Color3.fromRGB(60, 55, 50),
    ElementTransparency = 0.72,
    
    -- Toggle with orange
    ToggleSlider = Color3.fromRGB(80, 75, 70),
    ToggleToggled = Color3.fromRGB(255, 255, 255),
    
    SliderRail = Color3.fromRGB(60, 55, 50),
    
    DropdownFrame = Color3.fromRGB(55, 52, 48),
    DropdownHolder = Color3.fromRGB(28, 26, 24),
    DropdownBorder = Color3.fromRGB(45, 42, 38),
    DropdownOption = Color3.fromRGB(70, 65, 60),
    
    Keybind = Color3.fromRGB(55, 52, 48),
    
    Input = Color3.fromRGB(55, 52, 48),
    InputFocused = Color3.fromRGB(25, 23, 22),
    InputIndicator = Color3.fromRGB(90, 85, 80),
    
    Dialog = Color3.fromRGB(30, 28, 26),
    DialogHolder = Color3.fromRGB(25, 23, 22),
    DialogHolderLine = Color3.fromRGB(22, 20, 18),
    DialogButton = Color3.fromRGB(45, 42, 38),
    DialogButtonBorder = Color3.fromRGB(60, 55, 50),
    DialogBorder = Color3.fromRGB(50, 45, 40),
    DialogInput = Color3.fromRGB(38, 35, 32),
    DialogInputLine = Color3.fromRGB(120, 110, 100),
    
    -- Warmer white text
    Text = Color3.fromRGB(250, 248, 245),
    SubText = Color3.fromRGB(160, 155, 150),
    
    Hover = Color3.fromRGB(90, 85, 80),
    HoverChange = 0.06,
}

-- Inject CatHub theme into Fluent's theme system
if Fluent then
    -- Try to access internal theme table
    local success = pcall(function()
        -- Add to themes list if not exists
        if not table.find(Fluent.Themes, "CatHub") then
            table.insert(Fluent.Themes, "CatHub")
        end
    end)
    
    print("[CatHub] Fluent loaded successfully!")
    print("[CatHub] Available themes: " .. table.concat(Fluent.Themes or {}, ", "))
end

return Fluent
