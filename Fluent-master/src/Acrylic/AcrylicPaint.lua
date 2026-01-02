-- More Transparent AcrylicPaint with Orange Accents
local Creator = require(script.Parent.Parent.Creator)
local AcrylicBlur = require(script.Parent.AcrylicBlur)

local New = Creator.New

return function(props)
	local AcrylicPaint = {}

	AcrylicPaint.Frame = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 0.95,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	}, {
		-- Shadow
		New("ImageLabel", {
			Image = "rbxassetid://8992230677",
			ScaleType = "Slice",
			SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 120, 1, 116),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundTransparency = 1,
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.5,
		}),

		New("UICorner", {
			CornerRadius = UDim.new(0, 0),
		}),

		-- Main dark background - more transparent
		New("Frame", {
			BackgroundTransparency = 0.25,
			Size = UDim2.fromScale(1, 1),
			Name = "Background",
			ThemeTag = {
				BackgroundColor3 = "AcrylicMain",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),
		}),

		-- Subtle gradient overlay
		New("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.6,
			Size = UDim2.fromScale(1, 1),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),

			New("UIGradient", {
				Rotation = 90,
				ThemeTag = {
					Color = "AcrylicGradient",
				},
			}),
		}),

		-- Very subtle noise
		New("ImageLabel", {
			Image = "rbxassetid://9968344105",
			ImageTransparency = 0.98,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),
		}),

		New("ImageLabel", {
			Image = "rbxassetid://9968344227",
			ImageTransparency = 0.96,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ThemeTag = {
				ImageTransparency = "AcrylicNoise",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),
		}),

		-- Border with subtle orange hint
		New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 0),
			}),
			New("UIStroke", {
				Transparency = 0.6,
				Thickness = 1,
				ThemeTag = {
					Color = "AcrylicBorder",
				},
			}),
		}),
	})

	local Blur

	if require(script.Parent.Parent).UseAcrylic then
		Blur = AcrylicBlur()
		Blur.Frame.Parent = AcrylicPaint.Frame
		AcrylicPaint.Model = Blur.Model
		AcrylicPaint.AddParent = Blur.AddParent
		AcrylicPaint.SetVisibility = Blur.SetVisibility
	end

	return AcrylicPaint
end
