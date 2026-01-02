-- TitleBar with Orange Cat Accents
local Root = script.Parent.Parent
local Assets = require(script.Parent.Assets)
local Creator = require(Root.Creator)
local Flipper = require(Root.Packages.Flipper)

local New = Creator.New
local AddSignal = Creator.AddSignal

return function(Config)
	local TitleBar = {}

	local Library = require(Root)

	local function BarButton(Icon, Pos, Parent, Callback)
		local Button = {
			Callback = Callback or function() end,
		}

		Button.Frame = New("TextButton", {
			Size = UDim2.new(0, 28, 0, 28),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Parent = Parent,
			Position = Pos,
			Text = "",
			ThemeTag = {
				BackgroundColor3 = "Text",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),
			New("ImageLabel", {
				Image = Icon,
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Name = "Icon",
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		local Motor, SetTransparency = Creator.SpringMotor(1, Button.Frame, "BackgroundTransparency")

		AddSignal(Button.Frame.MouseEnter, function()
			SetTransparency(0.92)
			-- Orange tint on hover
			Button.Frame.Icon.ImageColor3 = Color3.fromRGB(255, 160, 80)
		end)
		AddSignal(Button.Frame.MouseLeave, function()
			SetTransparency(1, true)
			Creator.OverrideTag(Button.Frame.Icon, { ImageColor3 = "Text" })
		end)
		AddSignal(Button.Frame.MouseButton1Down, function()
			SetTransparency(0.88)
		end)
		AddSignal(Button.Frame.MouseButton1Up, function()
			SetTransparency(0.92)
		end)
		AddSignal(Button.Frame.MouseButton1Click, Button.Callback)

		Button.SetCallback = function(Func)
			Button.Callback = Func
		end

		return Button
	end

	-- Cat emoji as branding
	local CatBrand = New("TextLabel", {
		Text = "🐱",
		TextSize = 14,
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
	})

	TitleBar.Frame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 36),
		BackgroundTransparency = 1,
		Parent = Config.Parent,
	}, {
		New("Frame", {
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 12, 0, 0),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 6),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			-- Title with orange accent
			New("TextLabel", {
				RichText = true,
				Text = Config.Title,
				FontFace = Font.new(
					"rbxasset://fonts/families/GothamSSm.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				),
				TextSize = 14,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.fromScale(0, 1),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255, 160, 80), -- Orange title
			}),
			New("TextLabel", {
				RichText = true,
				Text = Config.SubTitle,
				TextTransparency = 0.4,
				FontFace = Font.new(
					"rbxasset://fonts/families/GothamSSm.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				),
				TextSize = 11,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.fromScale(0, 1),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			}),
		}),
		-- Bottom line with subtle orange gradient
		New("Frame", {
			BackgroundTransparency = 0.5,
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			ThemeTag = {
				BackgroundColor3 = "TitleBarLine",
			},
		}, {
			New("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 50)),
					ColorSequenceKeypoint.new(0.3, Color3.fromRGB(80, 75, 70)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 48, 45)),
				}),
			}),
		}),
	})

	TitleBar.CloseButton = BarButton(Assets.Close, UDim2.new(1, -4, 0.5, 0), TitleBar.Frame, function()
		Library.Window:Dialog({
			Title = "Close CatHub 🐱",
			Content = "Are you sure you want to close?",
			Buttons = {
				{
					Title = "Yes",
					Callback = function()
						Library:Destroy()
					end,
				},
				{
					Title = "No",
				},
			},
		})
	end)
	TitleBar.MaxButton = BarButton(Assets.Max, UDim2.new(1, -34, 0.5, 0), TitleBar.Frame, function()
		Config.Window.Maximize(not Config.Window.Maximized)
	end)
	TitleBar.MinButton = BarButton(Assets.Min, UDim2.new(1, -64, 0.5, 0), TitleBar.Frame, function()
		Library.Window:Minimize()
	end)

	return TitleBar
end
