-- CatHub - Modern, Lightweight UI Library
-- Optimized & Redesigned for Performance

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- CatHub Window Configuration - Compact & Modern Design
local Window = Fluent:CreateWindow({
    Title = "CatHub",
    SubTitle = "🐱 Premium Script Hub",
    TabWidth = 140, -- More compact tab width
    Size = UDim2.fromOffset(520, 420), -- Smaller, more compact size
    Acrylic = true, -- Transparent blur background
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Changed to RightControl for better UX
})

-- CatHub Tabs - Using cat-themed icons
local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" }), -- Home icon for main
    Scripts = Window:AddTab({ Title = "Scripts", Icon = "code" }), -- Code icon for scripts
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
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
    -- Welcome Section
    Tabs.Main:AddParagraph({
        Title = "Welcome to CatHub",
        Content = "Your premium script hub with modern design and optimized performance.\nCompact, lightweight, and purrfect! 🐾"
    })



    -- Quick Actions Section
    Tabs.Main:AddButton({
        Title = "Execute Script",
        Description = "Run your selected script",
        Callback = function()
            Window:Dialog({
                Title = "CatHub",
                Content = "Script execution dialog",
                Buttons = {
                    {
                        Title = "Execute",
                        Callback = function()
                            Fluent:Notify({
                                Title = "CatHub",
                                Content = "Script executed successfully!",
                                Duration = 3
                            })
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            -- Cancel action
                        end
                    }
                }
            })
        end
    })



    -- Feature Toggles
    local AutoExecute = Tabs.Main:AddToggle("AutoExecute", {
        Title = "Auto Execute",
        Description = "Automatically execute scripts on load",
        Default = false
    })

    AutoExecute:OnChanged(function()
        -- Auto execute logic here
    end)


    -- Performance Settings
    local PerformanceSlider = Tabs.Main:AddSlider("Performance", {
        Title = "Performance Level",
        Description = "Adjust script performance",
        Default = 5,
        Min = 1,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
            -- Performance adjustment logic
        end
    })


    -- Script Category Selector
    local CategoryDropdown = Tabs.Main:AddDropdown("Category", {
        Title = "Script Category",
        Values = {"Combat", "Utility", "ESP", "Auto Farm", "Teleport", "Other"},
        Multi = false,
        Default = 1,
    })

    CategoryDropdown:OnChanged(function(Value)
        -- Category filter logic
    end)



    -- Cat-themed Color Picker (Orange/Amber like a ginger cat)
    local AccentColor = Tabs.Main:AddColorpicker("AccentColor", {
        Title = "Accent Color",
        Description = "Customize your UI accent color",
        Default = Color3.fromRGB(255, 165, 0) -- Orange/Amber cat color
    })

    AccentColor:OnChanged(function()
        -- Color change logic
    end)


    -- Quick Toggle Keybind
    local QuickToggle = Tabs.Main:AddKeybind("QuickToggle", {
        Title = "Quick Toggle",
        Description = "Toggle UI visibility quickly",
        Mode = "Toggle",
        Default = "RightControl",
        Callback = function(Value)
            -- Toggle logic
        end
    })
end

-- Scripts Tab Content
do
    Tabs.Scripts:AddParagraph({
        Title = "Script Library",
        Content = "Browse and manage your scripts here"
    })

    -- Script Search
    local ScriptSearch = Tabs.Scripts:AddInput("ScriptSearch", {
        Title = "Search Scripts",
        Default = "",
        Placeholder = "Type to search...",
        Numeric = false,
        Finished = false,
        Callback = function(Value)
            -- Search logic
        end
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