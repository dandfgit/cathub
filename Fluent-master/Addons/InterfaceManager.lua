local httpService = game:GetService("HttpService")

local InterfaceManager = {} do
	InterfaceManager.Folder = "CatHub"
    InterfaceManager.Settings = {
        Theme = "Dark",
        Acrylic = true,
        Transparency = true,
        MenuKeybind = "RightControl"
    }

    function InterfaceManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

    function InterfaceManager:SetLibrary(library)
		self.Library = library
	end

    function InterfaceManager:BuildFolderTree()
		local paths = {}

		local parts = self.Folder:split("/")
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, "/", 1, idx)
		end

		table.insert(paths, self.Folder)
		table.insert(paths, self.Folder .. "/settings")

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

    function InterfaceManager:SaveSettings()
        writefile(self.Folder .. "/options.json", httpService:JSONEncode(InterfaceManager.Settings))
    end

    function InterfaceManager:LoadSettings()
        local path = self.Folder .. "/options.json"
        if isfile(path) then
            local data = readfile(path)
            local success, decoded = pcall(httpService.JSONDecode, httpService, data)

            if success then
                for i, v in next, decoded do
                    InterfaceManager.Settings[i] = v
                end
            end
        end
    end

    function InterfaceManager:BuildInterfaceSection(tab)
        assert(self.Library, "Must set InterfaceManager.Library")
		local Library = self.Library
        local Settings = InterfaceManager.Settings

        InterfaceManager:LoadSettings()

		-- Modern, Clean Interface Section
		local section = tab:AddSection("Interface")
		
		-- Welcome Info
		section:AddParagraph({
			Title = "Interface Settings",
			Content = "Customize your CatHub experience"
		})

		-- Theme Selector - Modern Design
		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Choose your preferred color theme",
			Values = Library.Themes,
			Default = Settings.Theme or "CatHub",
			Callback = function(Value)
				Library:SetTheme(Value)
                Settings.Theme = Value
                InterfaceManager:SaveSettings()
                
				-- Notify theme change
				Library:Notify({
					Title = "CatHub",
					Content = "Theme changed to " .. Value,
					Duration = 3
				})
			end
		})

        InterfaceTheme:SetValue(Settings.Theme or "CatHub")
	
		-- Acrylic Toggle - Clean Design
		if Library.UseAcrylic then
			section:AddToggle("AcrylicToggle", {
				Title = "Acrylic Effect",
				Description = "Enable blurred background effect (Requires Graphics Quality 8+)",
				Default = Settings.Acrylic,
				Callback = function(Value)
					Library:ToggleAcrylic(Value)
                    Settings.Acrylic = Value
                    InterfaceManager:SaveSettings()
					
					Library:Notify({
						Title = "CatHub",
						Content = Value and "Acrylic enabled" or "Acrylic disabled",
						Duration = 2
					})
				end
			})
		end
	
		-- Transparency Toggle - Modern Design
		section:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Enable interface transparency for a modern look",
			Default = Settings.Transparency,
			Callback = function(Value)
				Library:ToggleTransparency(Value)
				Settings.Transparency = Value
                InterfaceManager:SaveSettings()
				
				Library:Notify({
					Title = "CatHub",
					Content = Value and "Transparency enabled" or "Transparency disabled",
					Duration = 2
				})
			end
		})
	
		-- Minimize Keybind - Clean Design
		local MenuKeybind = section:AddKeybind("MenuKeybind", {
			Title = "Minimize Keybind",
			Description = "Press to toggle UI visibility",
			Default = Settings.MenuKeybind or "RightControl",
			Mode = "Toggle"
		})
		
		MenuKeybind:OnChanged(function()
			Settings.MenuKeybind = MenuKeybind.Value
            InterfaceManager:SaveSettings()
			
			Library:Notify({
				Title = "CatHub",
				Content = "Minimize keybind set to " .. MenuKeybind.Value,
				Duration = 2
			})
		end)
		
		Library.MinimizeKeybind = MenuKeybind
		
		-- Reset Settings Button - Modern Addition
		section:AddButton({
			Title = "Reset Interface Settings",
			Description = "Restore default interface settings",
			Callback = function()
				Window:Dialog({
					Title = "Reset Settings",
					Content = "Are you sure you want to reset all interface settings to default?",
					Buttons = {
						{
							Title = "Reset",
							Callback = function()
								InterfaceManager.Settings = {
									Theme = "CatHub",
									Acrylic = true,
									Transparency = true,
									MenuKeybind = "RightControl"
								}
								InterfaceManager:SaveSettings()
								Library:SetTheme("CatHub")
								InterfaceTheme:SetValue("CatHub")
								MenuKeybind:SetValue("RightControl", "Toggle")
								
								Library:Notify({
									Title = "CatHub",
									Content = "Interface settings reset successfully",
									Duration = 3
								})
							end
						},
						{
							Title = "Cancel",
							Callback = function() end
						}
					}
				})
			end
		})
    end
end

return InterfaceManager