-- Tab with Orange Cat Accent
local Root = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Creator)

local New = Creator.New
local Spring = Flipper.Spring.new
local Instant = Flipper.Instant.new
local Components = Root.Components

local TabModule = {
	Window = nil,
	Tabs = {},
	Containers = {},
	SelectedTab = 0,
	TabCount = 0,
}

function TabModule:Init(Window)
	TabModule.Window = Window
	return TabModule
end

function TabModule:GetCurrentTabPos()
	local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
	local TabPos = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y

	return TabPos - TabHolderPos
end

function TabModule:New(Title, Icon, Parent)
	local Library = require(Root)
	local Window = TabModule.Window
	local Elements = Library.Elements

	TabModule.TabCount = TabModule.TabCount + 1
	local TabIndex = TabModule.TabCount

	local Tab = {
		Selected = false,
		Name = Title,
		Type = "Tab",
	}

	if Library:GetIcon(Icon) then
		Icon = Library:GetIcon(Icon)
	end

	if Icon == "" or nil then
		Icon = nil
	end

	-- Orange selection indicator
	local Indicator = New("Frame", {
		Size = UDim2.new(0, 3, 0, 20),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(255, 140, 50), -- Orange
		Name = "Indicator",
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 0),
		}),
	})

	-- Tab button
	Tab.Frame = New("TextButton", {
		Size = UDim2.new(1, 0, 0, 38),
		BackgroundTransparency = 1,
		Parent = Parent,
		ThemeTag = {
			BackgroundColor3 = "Tab",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 0),
		}),
		-- Icon
		New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.new(0, 14, 0.5, 0),
			BackgroundTransparency = 1,
			Image = Icon and Icon or nil,
			Name = "Icon",
			ThemeTag = {
				ImageColor3 = "Text",
			},
		}),
		-- Tab name
		New("TextLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 38, 0.5, 0),
			Text = Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.Regular,
				Enum.FontStyle.Normal
			),
			TextSize = 12,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -44, 1, 0),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		}),
		Indicator,
	})

	local ContainerLayout = New("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	Tab.ContainerFrame = New("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Parent = Window.ContainerHolder,
		Visible = false,
		BottomImage = "rbxassetid://6889812791",
		MidImage = "rbxassetid://6889812721",
		TopImage = "rbxassetid://6276641225",
		ScrollBarImageColor3 = Color3.fromRGB(255, 140, 50), -- Orange scrollbar
		ScrollBarImageTransparency = 0.7,
		ScrollBarThickness = 2,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromScale(0, 0),
		ScrollingDirection = Enum.ScrollingDirection.Y,
	}, {
		ContainerLayout,
		New("UIPadding", {
			PaddingRight = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 0),
			PaddingTop = UDim.new(0, 0),
			PaddingBottom = UDim.new(0, 0),
		}),
	})

	Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		Tab.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
	end)

	Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(1, Tab.Frame, "BackgroundTransparency")

	Creator.AddSignal(Tab.Frame.MouseEnter, function()
		Tab.SetTransparency(Tab.Selected and 0.85 or 0.92)
	end)
	Creator.AddSignal(Tab.Frame.MouseLeave, function()
		Tab.SetTransparency(Tab.Selected and 0.88 or 1)
	end)
	Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
		Tab.SetTransparency(0.85)
	end)
	Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
		Tab.SetTransparency(Tab.Selected and 0.85 or 0.92)
	end)
	Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
		TabModule:SelectTab(TabIndex)
	end)

	TabModule.Containers[TabIndex] = Tab.ContainerFrame
	TabModule.Tabs[TabIndex] = Tab

	Tab.Container = Tab.ContainerFrame
	Tab.ScrollFrame = Tab.Container

	function Tab:AddSection(SectionTitle)
		local Section = { Type = "Section" }

		local SectionFrame = require(Components.Section)(SectionTitle, Tab.Container)
		Section.Container = SectionFrame.Container
		Section.ScrollFrame = Tab.Container

		setmetatable(Section, Elements)
		return Section
	end

	setmetatable(Tab, Elements)
	return Tab
end

function TabModule:SelectTab(Tab)
	local Window = TabModule.Window

	TabModule.SelectedTab = Tab

	for _, TabObject in next, TabModule.Tabs do
		TabObject.SetTransparency(1)
		TabObject.Selected = false
		local Indicator = TabObject.Frame:FindFirstChild("Indicator")
		if Indicator then
			Indicator.BackgroundTransparency = 1
		end
		-- Reset icon color
		local Icon = TabObject.Frame:FindFirstChild("Icon")
		if Icon then
			Creator.OverrideTag(Icon, { ImageColor3 = "SubText" })
		end
	end
	
	TabModule.Tabs[Tab].SetTransparency(0.88)
	TabModule.Tabs[Tab].Selected = true
	
	-- Show orange indicator
	local SelectedIndicator = TabModule.Tabs[Tab].Frame:FindFirstChild("Indicator")
	if SelectedIndicator then
		SelectedIndicator.BackgroundTransparency = 0
	end
	
	-- Highlight icon with accent
	local SelectedIcon = TabModule.Tabs[Tab].Frame:FindFirstChild("Icon")
	if SelectedIcon then
		Creator.OverrideTag(SelectedIcon, { ImageColor3 = "Accent" })
	end

	Window.TabDisplay.Text = TabModule.Tabs[Tab].Name
	Window.SelectorPosMotor:setGoal(Spring(TabModule:GetCurrentTabPos(), { frequency = 6 }))

	task.spawn(function()
		Window.ContainerHolder.Parent = Window.ContainerAnim
		
		Window.ContainerPosMotor:setGoal(Spring(12, { frequency = 10 }))
		Window.ContainerBackMotor:setGoal(Spring(1, { frequency = 10 }))
		task.wait(0.08)
		for _, Container in next, TabModule.Containers do
			Container.Visible = false
		end
		TabModule.Containers[Tab].Visible = true
		Window.ContainerPosMotor:setGoal(Spring(0, { frequency = 5 }))
		Window.ContainerBackMotor:setGoal(Spring(0, { frequency = 8 }))
		task.wait(0.08)
		Window.ContainerHolder.Parent = Window.ContainerCanvas
	end)
end

return TabModule
