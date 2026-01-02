-- Toggle with Orange Cat Theme
local TweenService = game:GetService("TweenService")
local Root = script.Parent.Parent
local Creator = require(Root.Creator)

local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Toggle"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Title, "Toggle - Missing Title")

	local Toggle = {
		Value = Config.Default or false,
		Callback = Config.Callback or function(Value) end,
		Type = "Toggle",
	}

	local ToggleFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, true)
	ToggleFrame.DescLabel.Size = UDim2.new(1, -52, 0, 14)

	Toggle.SetTitle = ToggleFrame.SetTitle
	Toggle.SetDesc = ToggleFrame.SetDesc

	-- Circle indicator with orange theme
	local ToggleCircle = New("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(0, 3, 0.5, 0),
		BackgroundColor3 = Color3.fromRGB(150, 145, 140), -- Warm gray when off
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),
	})

	local ToggleBorder = New("UIStroke", {
		Transparency = 0.5,
		Thickness = 1,
		Color = Color3.fromRGB(100, 95, 90),
	})

	-- Pill track
	local ToggleSlider = New("Frame", {
		Size = UDim2.fromOffset(38, 20),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Parent = ToggleFrame.Frame,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(255, 140, 50), -- Orange when on
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),
		ToggleBorder,
		ToggleCircle,
	})

	function Toggle:OnChanged(Func)
		Toggle.Changed = Func
		Func(Toggle.Value)
	end

	function Toggle:SetValue(Value)
		Value = not not Value
		Toggle.Value = Value

		-- Update colors based on state
		if Toggle.Value then
			ToggleBorder.Color = Color3.fromRGB(255, 140, 50) -- Orange
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 140, 50) -- Orange circle
		else
			ToggleBorder.Color = Color3.fromRGB(100, 95, 90)
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(150, 145, 140)
		end
		
		-- Animation
		TweenService:Create(
			ToggleCircle,
			TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Position = UDim2.new(0, Toggle.Value and 21 or 3, 0.5, 0) }
		):Play()
		TweenService:Create(
			ToggleSlider,
			TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ BackgroundTransparency = Toggle.Value and 0.35 or 1 }
		):Play()

		Library:SafeCallback(Toggle.Callback, Toggle.Value)
		Library:SafeCallback(Toggle.Changed, Toggle.Value)
	end

	function Toggle:Destroy()
		ToggleFrame:Destroy()
		Library.Options[Idx] = nil
	end

	Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
		Toggle:SetValue(not Toggle.Value)
	end)

	Toggle:SetValue(Toggle.Value)

	Library.Options[Idx] = Toggle
	return Toggle
end

return Element
