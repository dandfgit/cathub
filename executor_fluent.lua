local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub - Modern Boxy UI Design
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 Premium Script Hub",
    TabWidth = 80, -- Compact sidebar for modern navigation
    Size = UDim2.fromOffset(700, 550), -- Optimal size for modern boxy layout
    Acrylic = true, -- Transparent blur background
    Theme = "CatHub", -- Modern boxy theme with orange/yellow
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Modern Icon-Only Navigation (Boxy Style)
local Tabs = {
    Main = Window:AddTab({ Title = "", Icon = "home" }), -- Icon only for modern look
    Scripts = Window:AddTab({ Title = "", Icon = "code" }),
    Settings = Window:AddTab({ Title = "", Icon = "settings" }),
    Config = Window:AddTab({ Title = "", Icon = "folder" })
}

local Options = Fluent.Options

-- CatHub Welcome
Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Modern Boxy UI Loaded!",
    SubContent = "Orange/Yellow cat-themed colors",
    Duration = 4
})

-- Main Tab - Modern Boxy Design
do
    local MainSection = Tabs.Main:AddSection("Section")
    
    MainSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will be saved to the config!"
    })



    -- Modern Toggles (Boxy Style)
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



    -- Keybind (Boxy Style)
    local Keybind = MainSection:AddKeybind("Keybind", {
        Title = "Keybind",
        Description = "Set keybind for quick action",
        Default = "LAlt",
        Mode = "Toggle"
    })

    -- Slider (Boxy Style)
    local Slider = MainSection:AddSlider("Slider", {
        Title = "Slider",
        Description = "Adjust slider value",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })



    -- ColorPicker (Boxy Style)
    local ColorPicker = MainSection:AddColorpicker("ColorPicker", {
        Title = "ColorPicker",
        Description = "Pick your favorite color",
        Default = Color3.fromRGB(0, 255, 150) -- Bright green
    })

    -- Single Dropdown (Boxy Style)
    local SingleDropdown = MainSection:AddDropdown("SingleDropdown", {
        Title = "Single Dropdown",
        Description = "Select single option",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })

    -- Multi Dropdown (Boxy Style)
    local MultiDropdown = MainSection:AddDropdown("MultiDropdown", {
        Title = "Multi Dropdown",
        Description = "Select multiple options",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })



    -- Button (Boxy Style with Accent)
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

-- Scripts Tab - Second Panel (Boxy Style)
do
    local ScriptsSection = Tabs.Scripts:AddSection("Section")
    
    ScriptsSection:AddParagraph({
        Title = "Very cool paragraph",
        Content = "All elements in this section will not be saved to the config"
    })
    
    -- Duplicate elements for second panel
    local Toggle3 = ScriptsSection:AddToggle("Toggle3", {
        Title = "Toggle",
        Description = "Toggle with gear icon",
        Default = true
    })

    local Keybind2 = ScriptsSection:AddKeybind("Keybind2", {
        Title = "Keybind",
        Description = "Set keybind",
        Default = "LAlt"
    })

    local Slider2 = ScriptsSection:AddSlider("Slider2", {
        Title = "Slider",
        Description = "Adjust value",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 0
    })

    local ColorPicker2 = ScriptsSection:AddColorpicker("ColorPicker2", {
        Title = "ColorPicker",
        Description = "Pick color",
        Default = Color3.fromRGB(0, 255, 150)
    })

    local SingleDropdown2 = ScriptsSection:AddDropdown("SingleDropdown2", {
        Title = "Single Dropdown",
        Description = "Select option",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = 1
    })

    local MultiDropdown2 = ScriptsSection:AddDropdown("MultiDropdown2", {
        Title = "Multi Dropdown",
        Description = "Select multiple",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Multi = true,
        Default = {1}
    })

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
    
    ScriptsSection:AddParagraph({
        Title = "Paragraph",
        Content = "Very cool paragraph\nAll elements in this section will not be saved to the config"
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


-- Force apply CatHub theme
Fluent:SetTheme("CatHub")
InterfaceManager.Settings.Theme = "CatHub"

Window:SelectTab(1)

Fluent:Notify({
    Title = "CatHub 🐱",
    Content = "Modern Boxy UI Ready!",
    SubContent = "Orange/Yellow theme active | Press RightControl to toggle",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()