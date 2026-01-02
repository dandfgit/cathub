--[[
    CatHub 🌊 - Escape The Tsunami Script
    Theme: Aqua
    Features: Auto Win, Fly, Speed Modifications
]]

-- ═══════════════════════════════════════════
-- LOAD LIBRARIES
-- ═══════════════════════════════════════════
local Fluent, SaveManager, InterfaceManager

local loadComplete = 0
local totalLoads = 3

task.spawn(function()
    Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/main.lua"))()
    loadComplete = loadComplete + 1
end)

task.spawn(function()
    SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/SaveManager.lua"))()
    loadComplete = loadComplete + 1
end)

task.spawn(function()
    InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dandfgit/cathub/refs/heads/main/Fluent-master/Addons/InterfaceManager.lua"))()
    loadComplete = loadComplete + 1
end)

local startTime = tick()
while loadComplete < totalLoads and (tick() - startTime) < 10 do
    task.wait(0.05)
end

if not Fluent then
    warn("[CatHub] Failed to load Fluent UI")
    return
end

-- ═══════════════════════════════════════════
-- VARIABLES & FUNCTIONS
-- ═══════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local CurrentTween = nil

-- Config Movement
local MoveConfig = {
    Method = "Tween", -- "Tween" or "Teleport"
    Speed = 50
}

-- Helper untuk mendapatkan posisi dari Part atau Model
local function GetTargetInfo(target)
    if target:IsA("BasePart") then
        return target.CFrame, target.Position
    elseif target:IsA("Model") then
        local cf = target:GetPivot()
        return cf, cf.Position
    end
    return nil, nil
end

-- Smart Find Checkpoint/Win (Nearest Logic)
local function GetWinTarget()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local bestTarget = nil
    local minDistance = math.huge
    
    local searchRoot = Workspace:FindFirstChild("DynamicObjects", true) and Workspace.DynamicObjects:FindFirstChild("Worlds", true) or Workspace

    local function CheckCandidate(candidate)
        if candidate.Name == "WinPortal" or candidate.Name == "End" then
             local cf, pos = GetTargetInfo(candidate)
             if pos then
                local dist = (hrp.Position - pos).Magnitude
                if dist < minDistance then
                    minDistance = dist
                    bestTarget = candidate
                end
             end
        end
    end

    if searchRoot == Workspace then
        for _, descendant in pairs(Workspace:GetDescendants()) do
            CheckCandidate(descendant)
        end
    else
        for _, world in pairs(searchRoot:GetChildren()) do
            for _, child in pairs(world:GetChildren()) do
                CheckCandidate(child)
            end
        end
    end

    return bestTarget
end

-- Fly Logic
local FlyState = {
    Enabled = false,
    Speed = 50,
    BodyGyro = nil,
    BodyVelocity = nil,
    Connection = nil
}

local function StopFly()
    if FlyState.BodyGyro then FlyState.BodyGyro:Destroy() FlyState.BodyGyro = nil end
    if FlyState.BodyVelocity then FlyState.BodyVelocity:Destroy() FlyState.BodyVelocity = nil end
    if FlyState.Connection then FlyState.Connection:Disconnect() FlyState.Connection = nil end
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.PlatformStand = false
    end
end

local function StartFly()
    StopFly() -- Reset first
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    FlyState.BodyGyro = Instance.new("BodyGyro", hrp)
    FlyState.BodyGyro.P = 9e4
    FlyState.BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    FlyState.BodyGyro.cframe = hrp.CFrame

    FlyState.BodyVelocity = Instance.new("BodyVelocity", hrp)
    FlyState.BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    FlyState.BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    hum.PlatformStand = true

    FlyState.Connection = RunService.RenderStepped:Connect(function()
        if not FlyState.Enabled or not char or not hrp then StopFly() return end
        
        hum.PlatformStand = true
        local cam = Workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        local userInput = game:GetService("UserInputService")
        if userInput:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if userInput:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if userInput:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if userInput:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if userInput:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        
        FlyState.BodyGyro.cframe = cam.CFrame
        FlyState.BodyVelocity.velocity = moveDir * FlyState.Speed
    end)
end

-- Tween/Teleport Logic Reusable Function
local function StartTween(target)
    if not target then return end
    
    local targetCFrame, targetPos = GetTargetInfo(target)
    if not targetCFrame then
        Fluent:Notify({Title = "Error", Content = "Target tidak valid!", Duration = 3})
        return
    end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if CurrentTween then CurrentTween:Cancel() end

    -- TELEPORT METHOD
    if MoveConfig.Method == "Teleport" then
        hrp.CFrame = targetCFrame + Vector3.new(0, 5, 0)
        Fluent:Notify({Title = "Success", Content = "Teleported to " .. target.Name, Duration = 3})
        return
    end

    -- TWEEN METHOD
    local dist = (hrp.Position - targetPos).Magnitude
    local tweenSpeed = MoveConfig.Speed -- Use configurable speed
    local time = dist / tweenSpeed

    local info = TweenInfo.new(time, Enum.EasingStyle.Linear)
    
    -- Noclip Loop
    local noclipConn
    noclipConn = RunService.Stepped:Connect(function()
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
            end
        else
            if noclipConn then noclipConn:Disconnect() end
        end
    end)

    CurrentTween = TweenService:Create(hrp, info, {CFrame = targetCFrame + Vector3.new(0, 5, 0)})
    
    Fluent:Notify({Title = "Auto Win", Content = "Goal: " .. target.Name .. " (".. math.floor(time) .."s)", Duration = 3})
    
    CurrentTween:Play()
    CurrentTween.Completed:Connect(function()
        if noclipConn then noclipConn:Disconnect() end
        CurrentTween = nil
        Fluent:Notify({Title = "Success", Content = "Sampai di tujuan!", Duration = 3})
    end)
end

-- ═══════════════════════════════════════════
-- UI CREATION
-- ═══════════════════════════════════════════
local Window = Fluent:CreateWindow({
    Title = "🐱 <font color='rgb(255,165,80)'>Cat</font> <font color='rgb(255,255,255)'><b>Hub</b></font>",
    SubTitle = "<font color='rgb(120,120,120)'>•</font> <font color='rgb(255,165,80)'><b>v1.0</b></font>",
    TabWidth = 80,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "waves" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- ═══════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════

do
    -- ═══════════════════════════════════════════
    -- AUTO WIN (Smart & Manual)
    -- ═══════════════════════════════════════════
    local AutoSection = Tabs.Main:AddSection("Auto Win")


     -- Manual World Selection
    local worldsFolder = Workspace:FindFirstChild("DynamicObjects", true) and Workspace.DynamicObjects:FindFirstChild("Worlds", true)
    local worldList = {}
    
    if worldsFolder then
        for _, w in pairs(worldsFolder:GetChildren()) do
            table.insert(worldList, w.Name)
        end
    else
        -- Fallback list jika folder tidak ketemu saat init
        worldList = {"Rainbow", "Volcano", "Beach", "Frozen", "Space", "Candy"}
    end

    local WorldDropdown = AutoSection:AddDropdown("SelectedWorld", {
        Title = "Select World",
        Values = worldList,
        Multi = false,
        Default = 1,
    })

    local MethodDropdown = AutoSection:AddDropdown("Method", {
        Title = "Movement Method",
        Values = {"Tween", "Teleport"},
        Multi = false,
        Default = 1,
    })

    MethodDropdown:OnChanged(function(Value)
        MoveConfig.Method = Value
    end)

    local TweenSpeedSlider = AutoSection:AddSlider("TweenSpeed", {
        Title = "Tween Speed",
        Description = "Kecepatan gerak (Studs/Sec)",
        Default = 200,
        Min = 20,
        Max = 500,
        Rounding = 0
    })

    TweenSpeedSlider:OnChanged(function(Value)
        MoveConfig.Speed = Value
    end)

    AutoSection:AddButton({
        Title = "Tween to Selected World Win",
        Description = "Teleport ke WinPortal world yang dipilih",
        Callback = function()
            local worldName = WorldDropdown.Value
            if not worldName then return end

            -- Cari World folder spesifik
            local targetWorld = worldsFolder and worldsFolder:FindFirstChild(worldName)
            
            if not targetWorld then
                -- Coba cari manual di Workspace jika path DynamicObjects berubah
                targetWorld = Workspace:FindFirstChild(worldName, true)
            end

            if not targetWorld then
                Fluent:Notify({Title = "Error", Content = "World '"..worldName.."' tidak ditemukan di map!", Duration = 3})
                return
            end

            -- Cari WinPortal di dalam world tersebut
            local winPart = targetWorld:FindFirstChild("WinPortal") or targetWorld:FindFirstChild("End")
            
            if not winPart then
                Fluent:Notify({Title = "Error", Content = "WinPortal tidak ketemu di "..worldName, Duration = 3})
                return
            end

            StartTween(winPart)
        end
    })

    AutoSection:AddButton({
        Title = "Stop Tween",
        Description = "Hentikan pergerakan",
        Callback = function()
            if CurrentTween then
                CurrentTween:Cancel()
                CurrentTween = nil
                Fluent:Notify({Title = "Stopped", Content = "Tween dibatalkan", Duration = 2})
            end
        end
    })

    local MovementSection = Tabs.Main:AddSection("Movement Mods")

    local SpeedSlider = MovementSection:AddSlider("WalkSpeed", {
        Title = "Walk Speed",
        Description = "Kecepatan lari",
        Default = 16,
        Min = 16,
        Max = 200,
        Rounding = 0
    })

    local SpeedActive = false
    SpeedSlider:OnChanged(function(value)
        SpeedActive = true
        task.spawn(function()
            while SpeedActive and task.wait() do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = value
                end
            end
        end)
    end)

    local FlyToggle = MovementSection:AddToggle("FlyMode", {
        Title = "Fly Mode",
        Description = "Aktifkan terbang",
        Default = false
    })

    local FlySpeedSlider = MovementSection:AddSlider("FlySpeed", {
        Title = "Fly Speed",
        Description = "Kecepatan terbang",
        Default = 50,
        Min = 10,
        Max = 200,
        Rounding = 0
    })

    FlyToggle:OnChanged(function(state)
        FlyState.Enabled = state
        if state then
            StartFly()
        else
            StopFly()
        end
    end)

    FlySpeedSlider:OnChanged(function(value)
        FlyState.Speed = value
    end)
    
    local InfJumpToggle = MovementSection:AddToggle("InfJump", {
        Title = "Infinite Jump",
        Default = false
    })
    
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfJumpToggle.Value then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end
    end)
end

-- ═══════════════════════════════════════════
-- SETTINGS
-- ═══════════════════════════════════════════
do
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("CatHub")
    SaveManager:SetFolder("CatHub/configs")
    -- InterfaceManager:BuildInterfaceSection(Tabs.Settings) -- Dihapus agar tidak ada opsi Themes
    SaveManager:BuildConfigSection(Tabs.Settings)
end

Window:SelectTab(1)

Fluent:Notify({
    Title = "CatHub Loaded",
    Content = "Escape Tsunami Script Ready!",
    Duration = 5
})

-- Load config in background (non-blocking) - MENYAMAKAN DENGAN EXECUTOR
task.defer(function()
    SaveManager:LoadAutoloadConfig()
end)

-- ═══════════════════════════════════════════
-- CATHUB TOGGLE BUTTON (Small Ball)
-- ═══════════════════════════════════════════
task.spawn(function()
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    
    -- Function to clean old buttons
    local function CleanOld()
        if CoreGui:FindFirstChild("CatHubToggle") then CoreGui.CatHubToggle:Destroy() end
        if PlayerGui and PlayerGui:FindFirstChild("CatHubToggle") then PlayerGui.CatHubToggle:Destroy() end
    end
    
    -- Clean on start (prevent duplicates on re-execute)
    CleanOld()
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CatHubToggle"
    
    -- Try CoreGui first, fallback to PlayerGui
    local parentSuccess, _ = pcall(function() ScreenGui.Parent = CoreGui end)
    if not parentSuccess or not ScreenGui.Parent then 
        ScreenGui.Parent = PlayerGui 
    end
    
    ScreenGui.DisplayOrder = 10000 
    
    -- Monitor Fluent UI existence using Window.Root directly
    if Window and Window.Root then
        Window.Root.AncestryChanged:Connect(function(_, parent)
            if not parent then
                -- UI Utama dihapus (Close X ditekan) -> Hapus Toggle
                if ScreenGui then ScreenGui:Destroy() end
            end
        end)
    end
    
    local StartDrag = nil
    local FrameDrag = nil
    
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "Toggle"
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.Size = UDim2.fromOffset(40, 40) -- Ukuran bola kecil
    ToggleBtn.Position = UDim2.new(0, 180, 0, 10) -- Posisi kiri atas
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Active = true
    ToggleBtn.Draggable = true 
    
    local Corner = Instance.new("UICorner", ToggleBtn)
    Corner.CornerRadius = UDim.new(1, 0) 
    
    local Stroke = Instance.new("UIStroke", ToggleBtn)
    Stroke.Color = Color3.fromRGB(255, 140, 50) 
    Stroke.Thickness = 2
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Icon Kucing
    local CatIcon = Instance.new("TextLabel", ToggleBtn)
    CatIcon.Size = UDim2.fromScale(1, 1)
    CatIcon.BackgroundTransparency = 1
    CatIcon.Text = "🐱" 
    CatIcon.TextSize = 15
    CatIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    CatIcon.TextYAlignment = Enum.TextYAlignment.Center
    CatIcon.TextXAlignment = Enum.TextXAlignment.Center

    -- Tooltip simple
    local Tooltip = Instance.new("TextLabel", ToggleBtn)
    Tooltip.Size = UDim2.fromOffset(80, 20)
    Tooltip.Position = UDim2.fromOffset(55, 12)
    Tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Tooltip.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tooltip.Text = "Click to Toggle"
    Tooltip.TextSize = 12
    Tooltip.Visible = false
    Tooltip.BackgroundTransparency = 0.5
    Instance.new("UICorner", Tooltip).CornerRadius = UDim.new(0, 4)

    ToggleBtn.MouseEnter:Connect(function() Tooltip.Visible = true end)
    ToggleBtn.MouseLeave:Connect(function() Tooltip.Visible = false end)

    -- Toggle Logic
    local Vim = game:GetService("VirtualInputManager")
    
    ToggleBtn.MouseButton1Click:Connect(function()
        pcall(function()
            Vim:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
            task.wait()
            Vim:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
        end)
    end)
    
    -- Custom Drag Logic
    local dragging, dragInput, dragStart, startPos
    
    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ToggleBtn.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    ToggleBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.05), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }):Play()
        end
    end)
end)