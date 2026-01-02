-- CatHub - Modern, Lightweight UI Library
-- Optimized & Redesigned for Performance

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub Window Configuration - Modern, Solid, Box Design
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 Premium Script Hub",
    TabWidth = 70, -- Compact sidebar for icon-only navigation
    Size = UDim2.fromOffset(750, 550), -- Optimal size for modern layout
    Acrylic = true, -- Transparent blur background
    Theme = "CatHub", -- Custom CatHub theme - Modern, Solid, Box
    MinimizeKey = Enum.KeyCode.RightControl
})

-- CatHub Tabs - Icon-only sidebar navigation (like image 2)
local Tabs = {
    Main = Window:AddTab({ Title = "", Icon = "home" }), -- Icon only, no text
    Scripts = Window:AddTab({ Title = "", Icon = "code" }),
    Settings = Window:AddTab({ Title = "", Icon = "settings" }),
    Config = Window:AddTab({ Title = "", Icon = "folder" }),
    Info = Window:AddTab({ Title = "", Icon = "info" })
}

local Options = Fluent.Options

-- CatHub Welcome Notification - Fresh New UI!
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Fresh New UI Loaded!",
    SubContent = "Orange/Yellow cat-themed colors activated",
    Duration = 5
})

-- Force apply CatHub theme immediately
task.wait(0.2)
Fluent:SetTheme("CatHub")

-- Main Tab Content - Modern Solid Design
do
    local MainSection = Tabs.Main:AddSection("Main")
    
    MainSection:AddParagraph({
        Title = "Welcome",
        Content = "Modern, solid, and optimized UI design"
    })



    -- Modern Toggles
    local EnableFeature = MainSection:AddToggle("EnableFeature", {
        Title = "Enable Feature",
        Description = "Activate main feature",
        Default = true
    })
    
    local AutoSave = MainSection:AddToggle("AutoSave", {
        Title = "Auto Save",
        Description = "Automatically save configurations",
        Default = true
    })



    -- Keybind
    local QuickToggle = MainSection:AddKeybind("QuickToggle", {
        Title = "Quick Toggle",
        Description = "Toggle UI visibility",
        Default = "RightControl",
        Mode = "Toggle"
    })

    -- Performance Slider
    local Performance = MainSection:AddSlider("Performance", {
        Title = "Performance",
        Description = "Adjust performance level",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })



    -- Accent Color (Cat-themed Orange/Yellow)
    local AccentColor = MainSection:AddColorpicker("AccentColor", {
        Title = "Accent Color",
        Description = "Customize UI accent color (Cat-themed orange/yellow)",
        Default = Color3.fromRGB(255, 165, 0) -- Warm orange like ginger cat
    })

    -- Category Selector
    local Category = MainSection:AddDropdown("Category", {
        Title = "Category",
        Description = "Select script category",
        Values = {"Combat", "Utility", "ESP", "Auto Farm", "Teleport", "Other"},
        Default = 1
    })

    -- Multi Selection
    local Features = MainSection:AddDropdown("Features", {
        Title = "Features",
        Description = "Select multiple features",
        Values = {"Feature 1", "Feature 2", "Feature 3", "Feature 4"},
        Multi = true,
        Default = {1, 2}
    })

    -- Execute Button
    MainSection:AddButton({
        Title = "Execute",
        Description = "Run selected script",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Script executed successfully!",
                Duration = 3
            })
        end
    })
end

-- Scripts Tab - Script Library
do
    local ScriptsSection = Tabs.Scripts:AddSection("Scripts")
    
    ScriptsSection:AddParagraph({
        Title = "Script Library",
        Content = "Browse and manage your scripts"
    })
    
    -- Script Search
    local ScriptSearch = ScriptsSection:AddInput("ScriptSearch", {
        Title = "Search",
        Description = "Search for scripts",
        Default = "",
        Placeholder = "Type to search..."
    })
    
    -- Script Options
    local AutoLoad = ScriptsSection:AddToggle("AutoLoad", {
        Title = "Auto Load",
        Description = "Automatically load scripts on start",
        Default = false
    })
    
    local ShowHidden = ScriptsSection:AddToggle("ShowHidden", {
        Title = "Show Hidden",
        Description = "Display hidden scripts",
        Default = false
    })
    
    -- Script List
    local ScriptList = ScriptsSection:AddDropdown("ScriptList", {
        Title = "Script List",
        Description = "Select a script",
        Values = {"Script 1", "Script 2", "Script 3", "Script 4"},
        Default = 1
    })
    
    -- Load Script Button
    ScriptsSection:AddButton({
        Title = "Load Script",
        Description = "Load selected script",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Script loaded!",
                Duration = 2
            })
        end
    })
end

-- Config Tab
do
    local ConfigSection = Tabs.Config:AddSection("Configuration")
    ConfigSection:AddParagraph({
        Title = "Config Manager",
        Content = "Manage your configurations here"
    })
end

-- Info Tab
do
    local InfoSection = Tabs.Info:AddSection("Information")
    InfoSection:AddParagraph({
        Title = "CatHub",
        Content = "Premium Script Hub\nModern, lightweight, and optimized 🐱"
    })
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- FORCE CatHub Theme - Fresh New UI with Orange/Yellow Colors
Fluent:SetTheme("CatHub")
InterfaceManager.Settings.Theme = "CatHub"

-- Ignore keys that are used by ThemeManager.
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- CatHub Folder Configuration
InterfaceManager:SetFolder("CatHub")
SaveManager:SetFolder("CatHub/configs")

-- Build Interface Section with CatHub theme
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- Force apply CatHub theme again after sections are built
task.wait(0.1)
Fluent:SetTheme("CatHub")


-- Select Main Tab
Window:SelectTab(1)

-- Final Welcome Notification - Confirm Theme Applied
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Fresh UI Ready!",
    SubContent = "Orange/Yellow theme active | Press RightControl to toggle",
    Duration = 6
})

-- Final theme enforcement
task.wait(0.1)
Fluent:SetTheme("CatHub")
print("🎨 CatHub Theme Applied: Orange/Yellow Cat Colors")

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()