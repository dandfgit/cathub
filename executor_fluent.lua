--[[
    CatHub 🐱 - Modern Minimalist Script Hub
    Theme: Black Transparent + Orange Accent
    Design: Compact, Clean, User-Friendly
]]

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub - Modern Compact UI
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 v1.0",
    TabWidth = 70, -- Compact sidebar
    Size = UDim2.fromOffset(520, 420), -- Smaller, more compact size
    Acrylic = true, -- Transparent blur background
    Theme = "CatHub", -- Custom CatHub theme (black + orange)
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Compact Navigation Tabs
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
    Content = "Welcome to CatHub!",
    SubContent = "Press RightControl to toggle UI",
    Duration = 3
})

-- ═══════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════
do
    local MainSection = Tabs.Main:AddSection("Quick Actions")
    
    MainSection:AddParagraph({
        Title = "🐱 CatHub",
        Content = "Modern & Lightweight Script Hub"
    })

    MainSection:AddButton({
        Title = "🚀 Execute Script",
        Description = "Run your custom script",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Script executed!",
                Duration = 2
            })
        end
    })

    local AutoFarmToggle = MainSection:AddToggle("AutoFarm", {
        Title = "⚡ Auto Farm",
        Description = "Automatically farm resources",
        Default = false
    })
    
    AutoFarmToggle:OnChanged(function(value)
        Fluent:Notify({
            Title = "Auto Farm",
            Content = value and "Enabled" or "Disabled",
            Duration = 1.5
        })
    end)

    local SpeedSlider = MainSection:AddSlider("Speed", {
        Title = "🏃 Walk Speed",
        Description = "Adjust your movement speed",
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
        Title = "🦘 Infinite Jump",
        Description = "Jump unlimited times",
        Default = false
    })

    local NoClipToggle = PlayerSection:AddToggle("NoClip", {
        Title = "👻 NoClip",
        Description = "Walk through walls",
        Default = false
    })

    local JumpPowerSlider = PlayerSection:AddSlider("JumpPower", {
        Title = "⬆️ Jump Power",
        Description = "Adjust jump height",
        Default = 50,
        Min = 50,
        Max = 200,
        Rounding = 0
    })

    local GravitySlider = PlayerSection:AddSlider("Gravity", {
        Title = "🌍 Gravity",
        Description = "Adjust world gravity",
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
    local CombatSection = Tabs.Combat:AddSection("Combat Features")
    
    local AimbotToggle = CombatSection:AddToggle("Aimbot", {
        Title = "🎯 Aimbot",
        Description = "Auto aim at enemies",
        Default = false
    })

    local AimbotKey = CombatSection:AddKeybind("AimbotKey", {
        Title = "🔑 Aimbot Key",
        Description = "Keybind to activate aimbot",
        Default = "E",
        Mode = "Hold"
    })

    local TargetPart = CombatSection:AddDropdown("TargetPart", {
        Title = "🎯 Target Part",
        Description = "Which body part to aim at",
        Values = {"Head", "HumanoidRootPart", "Torso"},
        Default = 1
    })

    local FOVSlider = CombatSection:AddSlider("FOV", {
        Title = "📐 FOV Radius",
        Description = "Aimbot field of view",
        Default = 100,
        Min = 50,
        Max = 500,
        Rounding = 0
    })

    local ESPToggle = CombatSection:AddToggle("ESP", {
        Title = "👁️ ESP",
        Description = "See players through walls",
        Default = false
    })
end

-- ═══════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════
do
    local VisualsSection = Tabs.Visuals:AddSection("Visual Settings")
    
    local FullbrightToggle = VisualsSection:AddToggle("Fullbright", {
        Title = "☀️ Fullbright",
        Description = "Remove darkness/shadows",
        Default = false
    })

    local NoFogToggle = VisualsSection:AddToggle("NoFog", {
        Title = "🌫️ Remove Fog",
        Description = "Disable fog effects",
        Default = false
    })

    local ESPColor = VisualsSection:AddColorpicker("ESPColor", {
        Title = "🎨 ESP Color",
        Description = "Choose ESP highlight color",
        Default = Color3.fromRGB(255, 170, 0) -- Orange accent
    })

    local FOVCircle = VisualsSection:AddToggle("FOVCircle", {
        Title = "⭕ FOV Circle",
        Description = "Show FOV circle on screen",
        Default = false
    })
end

-- ═══════════════════════════════════════════
-- SETTINGS TAB
-- ═══════════════════════════════════════════
do
    -- Hand over to addon managers
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    -- Ignore theme settings in config
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    -- CatHub folder for configs
    InterfaceManager:SetFolder("CatHub")
    SaveManager:SetFolder("CatHub/configs")

    -- Build interface and config sections
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end

-- Force CatHub theme
Fluent:SetTheme("CatHub")
InterfaceManager.Settings.Theme = "CatHub"

-- Select first tab
Window:SelectTab(1)

-- Final notification
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "UI Loaded Successfully!",
    SubContent = "Compact • Modern • Powerful",
    Duration = 4
})

-- Load auto-saved config
SaveManager:LoadAutoloadConfig()