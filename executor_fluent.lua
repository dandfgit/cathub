--[[
    CatHub 🐱 - Modern Minimalist Script Hub
    Theme: Dark Minimal + Blue Accent
    Design: Ultra Compact, Clean, Professional
]]

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub - Modern Minimal UI
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "v1.0",
    TabWidth = 50, -- Ultra compact icon-only sidebar
    Size = UDim2.fromOffset(480, 360), -- Compact size
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Navigation Tabs (icons only)
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
        Default = Color3.fromRGB(80, 160, 220)
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

-- Apply theme
Fluent:SetTheme("Darker")
InterfaceManager.Settings.Theme = "Darker"

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