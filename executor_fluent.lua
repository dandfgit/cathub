-- CatHub - Modern, Lightweight UI Library
-- Optimized & Redesigned for Performance

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub Window Configuration - Modern Sidebar Design (Like Image 2)
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 Premium Script Hub",
    TabWidth = 80, -- Narrow sidebar width for icon-only navigation
    Size = UDim2.fromOffset(700, 500), -- Larger size for better layout
    Acrylic = true, -- Transparent blur background
    Theme = "CatHub", -- Custom CatHub theme with cyan accent
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

-- CatHub Welcome Notification
Fluent:Notify({
    Title = "CatHub",
    Content = "Welcome to CatHub! 🐱",
    SubContent = "Premium script hub loaded successfully",
    Duration = 4
})

-- Main Tab Content
do
    -- Section with collapsible header
    local MainSection = Tabs.Main:AddSection("Section")
    
    -- Welcome Paragraph
    MainSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will be saved to the config!"
    })



    -- Toggle with info icon
    local Toggle1 = MainSection:AddToggle("Toggle1", {
        Title = "Toggle",
        Description = "Toggle with info icon",
        Default = true
    })
    
    -- Toggle with gear icon
    local Toggle2 = MainSection:AddToggle("Toggle2", {
        Title = "Toggle",
        Description = "Toggle with gear icon",
        Default = true
    })



    -- Keybind
    local Keybind = MainSection:AddKeybind("Keybind", {
        Title = "Keybind",
        Default = "LAlt",
        Mode = "Toggle"
    })

    -- Slider
    local Slider = MainSection:AddSlider("Slider", {
        Title = "Slider",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })



    -- ColorPicker (Cyan/Green like image)
    local ColorPicker = MainSection:AddColorpicker("ColorPicker", {
        Title = "ColorPicker",
        Default = Color3.fromRGB(0, 255, 150) -- Bright cyan/green
    })

    -- Single Dropdown
    local SingleDropdown = MainSection:AddDropdown("SingleDropdown", {
        Title = "Single Dropdown",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })

    -- Multi Dropdown
    local MultiDropdown = MainSection:AddDropdown("MultiDropdown", {
        Title = "Multi Dropdown",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })

    -- Button (Cyan accent)
    MainSection:AddButton({
        Title = "Button",
        Description = "Cyan accent button",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Button clicked!",
                Duration = 2
            })
        end
    })
end

-- Scripts Tab Content (Second Section - Not Saved to Config)
do
    local ScriptsSection = Tabs.Scripts:AddSection("Section")
    
    ScriptsSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will not be saved to the config"
    })
    
    -- Duplicate elements for second panel
    local Toggle3 = ScriptsSection:AddToggle("Toggle3", {
        Title = "Toggle",
        Default = true
    })
    
    local Toggle4 = ScriptsSection:AddToggle("Toggle4", {
        Title = "Toggle",
        Default = true
    })
    
    local Keybind2 = ScriptsSection:AddKeybind("Keybind2", {
        Title = "Keybind",
        Default = "LAlt"
    })
    
    local Slider2 = ScriptsSection:AddSlider("Slider2", {
        Title = "Slider",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })
    
    local ColorPicker2 = ScriptsSection:AddColorpicker("ColorPicker2", {
        Title = "ColorPicker",
        Default = Color3.fromRGB(0, 255, 150)
    })
    
    local SingleDropdown2 = ScriptsSection:AddDropdown("SingleDropdown2", {
        Title = "Single Dropdown",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })
    
    local MultiDropdown2 = ScriptsSection:AddDropdown("MultiDropdown2", {
        Title = "Multi Dropdown",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })
    
    ScriptsSection:AddButton({
        Title = "Button",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Button clicked!",
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

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- CatHub Folder Configuration
InterfaceManager:SetFolder("CatHub")
SaveManager:SetFolder("CatHub/configs")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


-- Select Main Tab
Window:SelectTab(1)

-- Final Welcome Notification
Fluent:Notify({
    Title = "CatHub",
    Content = "UI loaded successfully! 🐱",
    SubContent = "Press RightControl to toggle UI",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()