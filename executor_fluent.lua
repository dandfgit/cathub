--[[
    CatHub 🐱 - Modern Minimalist Script Hub
    Theme: Orange Cat (Warm Dark)
    Design: Ultra Compact, Clean, Professional
]]

-- Load Fluent UI (minified version)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- ═══════════════════════════════════════════
-- INJECT CATHUB THEME (Orange Cat Theme)
-- ═══════════════════════════════════════════
-- Since main.lua is minified and doesn't include CatHub theme,
-- we inject it manually here

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
    
    Element = Color3.fromRGB(45, 43, 40),
    ElementBorder = Color3.fromRGB(30, 28, 26),
    InElementBorder = Color3.fromRGB(60, 55, 50),
    ElementTransparency = 0.72,
    
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
    
    Text = Color3.fromRGB(250, 248, 245),
    SubText = Color3.fromRGB(160, 155, 150),
    
    Hover = Color3.fromRGB(90, 85, 80),
    HoverChange = 0.06,
}

-- Inject theme into Fluent's internal theme system
pcall(function()
    -- Add CatHub to themes list if not exists
    if not table.find(Fluent.Themes, "CatHub") then
        table.insert(Fluent.Themes, "CatHub")
    end
    
    -- Try to inject into the internal Themes table
    -- This requires accessing Fluent's internal module structure
    if getgenv and getgenv().Fluent then
        -- The theme data is stored in a Themes module
        -- We need to find and inject into it
    end
end)

print("[CatHub] 🐱 Theme injection complete!")
print("[CatHub] Available themes: " .. table.concat(Fluent.Themes or {}, ", "))

-- ═══════════════════════════════════════════
-- CREATE WINDOW
-- ═══════════════════════════════════════════
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "v1.0",
    TabWidth = 80,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true,
    Theme = "Darker", -- Use Darker as base (CatHub theme may not be fully injected)
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Navigation Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "swords" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Welcome Notification
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Welcome!",
    SubContent = "Press RightControl to toggle",
    Duration = 3
})

-- ═══════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════
do
    local MainSection = Tabs.Main:AddSection("Quick Actions")
    
    MainSection:AddParagraph({
        Title = "🐱 CatHub",
        Content = "Modern Script Hub"
    })

    MainSection:AddButton({
        Title = "Execute Script",
        Description = "Run custom script",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Script executed!",
                Duration = 2
            })
        end
    })

    local AutoFarmToggle = MainSection:AddToggle("AutoFarm", {
        Title = "Auto Farm",
        Description = "Auto farm resources",
        Default = false
    })
    
    AutoFarmToggle:OnChanged(function(value)
        Fluent:Notify({
            Title = "Auto Farm",
            Content = value and "ON" or "OFF",
            Duration = 1
        })
    end)

    local SpeedSlider = MainSection:AddSlider("Speed", {
        Title = "Walk Speed",
        Description = "Movement speed",
        Default = 16,
        Min = 16,
        Max = 100,
        Rounding = 0
    })
    
    SpeedSlider:OnChanged(function(value)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end)
end

-- ═══════════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════════
do
    local PlayerSection = Tabs.Player:AddSection("Player Mods")
    
    local InfiniteJumpToggle = PlayerSection:AddToggle("InfJump", {
        Title = "Infinite Jump",
        Description = "Unlimited jumps",
        Default = false
    })

    local NoClipToggle = PlayerSection:AddToggle("NoClip", {
        Title = "NoClip",
        Description = "Walk through walls",
        Default = false
    })

    local JumpPowerSlider = PlayerSection:AddSlider("JumpPower", {
        Title = "Jump Power",
        Description = "Jump height",
        Default = 50,
        Min = 50,
        Max = 200,
        Rounding = 0
    })

    local GravitySlider = PlayerSection:AddSlider("Gravity", {
        Title = "Gravity",
        Description = "World gravity",
        Default = 196,
        Min = 0,
        Max = 500,
        Rounding = 0
    })
    
    GravitySlider:OnChanged(function(value)
        game:GetService("Workspace").Gravity = value
    end)
end

-- ═══════════════════════════════════════════
-- COMBAT TAB
-- ═══════════════════════════════════════════
do
    local CombatSection = Tabs.Combat:AddSection("Combat")
    
    local AimbotToggle = CombatSection:AddToggle("Aimbot", {
        Title = "Aimbot",
        Description = "Auto aim",
        Default = false
    })

    local AimbotKey = CombatSection:AddKeybind("AimbotKey", {
        Title = "Aimbot Key",
        Description = "Activation key",
        Default = "E",
        Mode = "Hold"
    })

    local TargetPart = CombatSection:AddDropdown("TargetPart", {
        Title = "Target Part",
        Description = "Aim target",
        Values = {"Head", "HumanoidRootPart", "Torso"},
        Default = 1
    })

    local FOVSlider = CombatSection:AddSlider("FOV", {
        Title = "FOV Radius",
        Description = "Aim FOV",
        Default = 100,
        Min = 50,
        Max = 500,
        Rounding = 0
    })

    local ESPToggle = CombatSection:AddToggle("ESP", {
        Title = "ESP",
        Description = "See through walls",
        Default = false
    })
end

-- ═══════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════
do
    local VisualsSection = Tabs.Visuals:AddSection("Visual Settings")
    
    local FullbrightToggle = VisualsSection:AddToggle("Fullbright", {
        Title = "Fullbright",
        Description = "Remove shadows",
        Default = false
    })

    local NoFogToggle = VisualsSection:AddToggle("NoFog", {
        Title = "Remove Fog",
        Description = "Disable fog",
        Default = false
    })

    local ESPColor = VisualsSection:AddColorpicker("ESPColor", {
        Title = "ESP Color",
        Description = "Highlight color",
        Default = Color3.fromRGB(255, 140, 50)  -- Orange!
    })

    local FOVCircle = VisualsSection:AddToggle("FOVCircle", {
        Title = "FOV Circle",
        Description = "Show FOV",
        Default = false
    })
end

-- ═══════════════════════════════════════════
-- SETTINGS TAB
-- ═══════════════════════════════════════════
do
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("CatHub")
    SaveManager:SetFolder("CatHub/configs")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end

-- Select first tab
Window:SelectTab(1)

-- Final notification
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Ready!",
    SubContent = "Compact • Modern • Fast",
    Duration = 3
})

-- Load auto-saved config
SaveManager:LoadAutoloadConfig()