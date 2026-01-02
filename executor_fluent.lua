-- CatHub - Modern, Lightweight UI Library
-- Optimized & Redesigned for Performance

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub Window Configuration - Modern Style (Like Image)
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 Premium Script Hub",
    TabWidth = 60, -- Narrow sidebar for icon-only navigation (like image)
    Size = UDim2.fromOffset(800, 600), -- Larger size for modern two-panel layout
    Acrylic = true, -- Transparent blur background
    Theme = "CatHub", -- Custom CatHub theme with Orange/Yellow
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

-- Main Tab Content - Modern Style (Like Image)
do
    local MainSection = Tabs.Main:AddSection("Section")
    
    -- Modern Paragraph
    MainSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will be saved to the config!"
    })

    -- Modern Toggles with Clean Style
    local Toggle1 = MainSection:AddToggle("Toggle1", {
        Title = "Toggle",
        Description = "Toggle with info icon",
        Default = true
    })
    
    local Toggle2 = MainSection:AddToggle("Toggle2", {
        Title = "Toggle",
        Description = "Toggle with gear icon",
        Default = true
    })
    
    local RiskyToggle = MainSection:AddToggle("RiskyToggle", {
        Title = "Risky Feature",
        Description = "Enable risky features",
        Default = true
    })

    -- Keybind - Modern Style
    local Keybind = MainSection:AddKeybind("Keybind", {
        Title = "Keybind",
        Description = "Set keybind for quick action",
        Default = "LAlt",
        Mode = "Toggle"
    })

    -- Slider - Modern Style
    local Slider = MainSection:AddSlider("Slider", {
        Title = "Slider",
        Description = "Adjust slider value",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })

    -- ColorPicker - Modern Style
    local ColorPicker = MainSection:AddColorpicker("ColorPicker", {
        Title = "ColorPicker",
        Description = "Pick your favorite color",
        Default = Color3.fromRGB(0, 255, 150) -- Bright green like image
    })

    -- Single Dropdown - Modern Style
    local SingleDropdown = MainSection:AddDropdown("SingleDropdown", {
        Title = "Single Dropdown",
        Description = "Select single option",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })

    -- Multi Dropdown - Modern Style
    local MultiDropdown = MainSection:AddDropdown("MultiDropdown", {
        Title = "Multi Dropdown",
        Description = "Select multiple options",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })

    -- Button - Modern Style
    MainSection:AddButton({
        Title = "Button",
        Description = "Click to execute action",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Button clicked!",
                Duration = 2
            })
        end
    })
end

-- Scripts Tab - Modern Style (Second Panel Like Image)
do
    local ScriptsSection = Tabs.Scripts:AddSection("Section")
    
    -- Modern Paragraph
    ScriptsSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will not be saved to the config"
    })
    
    -- Modern Toggle
    local Toggle3 = ScriptsSection:AddToggle("Toggle3", {
        Title = "Toggle",
        Description = "Toggle with gear icon",
        Default = true
    })

    -- Keybind - Modern Style
    local Keybind2 = ScriptsSection:AddKeybind("Keybind2", {
        Title = "Keybind",
        Description = "Set keybind",
        Default = "LAlt",
        Mode = "Toggle"
    })

    -- Slider - Modern Style
    local Slider2 = ScriptsSection:AddSlider("Slider2", {
        Title = "Slider",
        Description = "Adjust value",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })

    -- ColorPicker - Modern Style
    local ColorPicker2 = ScriptsSection:AddColorpicker("ColorPicker2", {
        Title = "ColorPicker",
        Description = "Pick color",
        Default = Color3.fromRGB(0, 255, 150) -- Bright green
    })

    -- Single Dropdown - Modern Style
    local SingleDropdown2 = ScriptsSection:AddDropdown("SingleDropdown2", {
        Title = "Single Dropdown",
        Description = "Select option",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })

    -- Multi Dropdown - Modern Style
    local MultiDropdown2 = ScriptsSection:AddDropdown("MultiDropdown2", {
        Title = "Multi Dropdown",
        Description = "Select multiple",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })

    -- Button - Modern Style with Accent
    ScriptsSection:AddButton({
        Title = "Button",
        Description = "Execute action",
        Callback = function()
            Fluent:Notify({
                Title = "CatHub",
                Content = "Button clicked!",
                Duration = 2
            })
        end
    })
    
    -- Paragraph - Modern Style
    ScriptsSection:AddParagraph({
        Title = "Paragraph",
        Content = "Very cool paragraph\nAll elements in this section will not be saved to the config"
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