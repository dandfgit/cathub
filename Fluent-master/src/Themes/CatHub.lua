return {
	Name = "CatHub",
	-- 🐱 CAT-THEMED ORANGE/YELLOW COLORS - PERFECT HARMONY 🐱
	-- Primary Accent: Bright Orange (Ginger Cat Color)
	Accent = Color3.fromRGB(255, 140, 0), -- Vibrant orange - main accent color
	
	-- Modern Dark Background with Orange Warmth
	AcrylicMain = Color3.fromRGB(22, 20, 18), -- Deep warm dark
	AcrylicBorder = Color3.fromRGB(60, 50, 40), -- Warm orange-tinted border
	AcrylicGradient = ColorSequence.new(
		Color3.fromRGB(25, 22, 18), -- Warm dark with orange hint
		Color3.fromRGB(18, 16, 14)  -- Deeper warm dark
	),
	AcrylicNoise = 0.85, -- Very clean look

	TitleBarLine = Color3.fromRGB(80, 65, 50), -- Orange-tinted separator
	Tab = Color3.fromRGB(90, 75, 60), -- Warm orange-tinted tab

	-- Solid Elements with Orange Warmth
	Element = Color3.fromRGB(35, 30, 25), -- Warm dark element with orange hint
	ElementBorder = Color3.fromRGB(70, 55, 40), -- Orange-tinted border
	InElementBorder = Color3.fromRGB(90, 70, 50), -- Bright orange-tinted inner border
	ElementTransparency = 0.65, -- More solid, boxy appearance

	-- 🟠 ORANGE/YELLOW TOGGLE (Cat-themed)
	ToggleSlider = Color3.fromRGB(60, 50, 40), -- Warm toggle base
	ToggleToggled = Color3.fromRGB(255, 140, 0), -- VIBRANT ORANGE when on

	-- 🟡 SLIDER with Orange/Yellow Accent
	SliderRail = Color3.fromRGB(40, 35, 30), -- Warm rail
	SliderFill = Color3.fromRGB(255, 165, 0), -- BRIGHT YELLOW-ORANGE fill

	-- Dropdown with Orange Warmth
	DropdownFrame = Color3.fromRGB(35, 30, 25), -- Warm dropdown
	DropdownHolder = Color3.fromRGB(25, 22, 18), -- Dark warm holder
	DropdownBorder = Color3.fromRGB(70, 55, 40), -- Orange-tinted border
	DropdownOption = Color3.fromRGB(45, 38, 30), -- Warm options

	-- Keybind with Orange Accent
	Keybind = Color3.fromRGB(35, 30, 25), -- Warm keybind
	KeybindBorder = Color3.fromRGB(70, 55, 40), -- Orange-tinted border

	-- Input with BRIGHT ORANGE Indicator
	Input = Color3.fromRGB(30, 26, 22), -- Warm input
	InputFocused = Color3.fromRGB(45, 38, 30), -- Warm focused
	InputIndicator = Color3.fromRGB(255, 140, 0), -- BRIGHT ORANGE indicator
	InputBorder = Color3.fromRGB(70, 55, 40), -- Orange-tinted border

	-- Dialog with Orange Accents
	Dialog = Color3.fromRGB(25, 22, 18), -- Warm dialog
	DialogHolder = Color3.fromRGB(20, 18, 15), -- Dark warm holder
	DialogHolderLine = Color3.fromRGB(80, 65, 50), -- Orange-tinted line
	DialogButton = Color3.fromRGB(35, 30, 25), -- Warm button
	DialogButtonBorder = Color3.fromRGB(90, 70, 50), -- Orange-tinted border
	DialogBorder = Color3.fromRGB(70, 55, 40), -- Orange-tinted border
	DialogInput = Color3.fromRGB(30, 26, 22), -- Warm input
	DialogInputLine = Color3.fromRGB(255, 140, 0), -- BRIGHT ORANGE line

	-- Text Colors (Perfect Contrast with Orange Theme)
	Text = Color3.fromRGB(255, 248, 240), -- Warm white text
	SubText = Color3.fromRGB(220, 200, 180), -- Warm light gray with orange hint
	Hover = Color3.fromRGB(80, 65, 50), -- Orange-tinted hover
	HoverChange = 0.15, -- Strong hover effect for visibility
}

