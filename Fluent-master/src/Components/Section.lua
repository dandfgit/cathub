-- Modern Minimal Section (headers removed for cleaner UI)
local Root = script.Parent.Parent
local Creator = require(Root.Creator)

local New = Creator.New

return function(Title, Parent)
	local Section = {}

	Section.Layout = New("UIListLayout", {
		Padding = UDim.new(0, 3),
	})

	-- Container starts at position 0 (no header space needed)
	Section.Container = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.fromOffset(0, 0), -- No offset for header
		BackgroundTransparency = 1,
	}, {
		Section.Layout,
	})

	-- Root without the TextLabel header
	Section.Root = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), -- Zero initial size
		LayoutOrder = 7,
		Parent = Parent,
	}, {
		-- TextLabel removed to hide section headers
		Section.Container,
	})

	Creator.AddSignal(Section.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		Section.Container.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y)
		Section.Root.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y) -- No extra height for header
	end)

	return Section
end

