-- LocalScript: StarterPlayerScripts > LocalScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Starter = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local moduleInstance
if ReplicatedStorage:FindFirstChild("CompKiller") then
    moduleInstance = require(ReplicatedStorage:FindFirstChild("CompKiller"))
elseif Starter:FindFirstChild("CompKiller") then
    moduleInstance = require(Starter:FindFirstChild("CompKiller"))
else
    warn("CompKiller module not found in ReplicatedStorage or StarterPlayerScripts")
    return
end

-- Buat window (mini UI / full API tergantung module yang Anda paste)
local win = moduleInstance.new("My UI", "rbxassetid://120245531583106")

-- Tambah contoh kontrol (periksa dulu apakah method ada)
if win.AddToggle then
    win:AddToggle("Example Toggle", false, function(val)
        print("Toggle value:", val)
    end)
end

if win.AddSlider then
    win:AddSlider({
        Name = "Example Slider",
        Min = 0,
        Max = 100,
        Default = 50,
        Callback = function(v) print("Slider:", v) end
    })
end

if win.AddColorPicker then
    win:AddColorPicker({
        Name = "Accent",
        Default = Color3.fromRGB(17,238,253),
        Transparency = 0,
        Callback = function(c,t) print("Color:", c, "Trans:", t) end
    })
end

if win.AddDropdown then
    win:AddDropdown({
        Name = "Single Dropdown",
        Default = "Head",
        Values = {"Head","Torso","Legs"},
        Multi = false,
        Callback = function(val) print("Dropdown:", val) end
    })
end

if win.AddButton then
    win:AddButton("Button", function()
        print("Button pressed")
    end)
end