local httpService = game:GetService("HttpService")

local InterfaceManager = {} do
	InterfaceManager.Folder = "CatHub"
    InterfaceManager.Settings = {
        Theme = "CatHub", -- Default to CatHub theme (Orange/Yellow)
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
                -- Force CatHub theme if saved theme doesn't exist or is old
                if not decoded.Theme or decoded.Theme == "Dark" then
                    InterfaceManager.Settings.Theme = "CatHub"
                end
            end
        end
    end
    
    function InterfaceManager:ResetSettings()
        -- Delete settings file to reset to default
        local path = self.Folder .. "/options.json"
        if isfile(path) then
            delfile(path)
        end
        -- Reset to default
        InterfaceManager.Settings = {
            Theme = "CatHub",
            Acrylic = true,
            Transparency = true,
            MenuKeybind = "RightControl"
        }
        InterfaceManager:SaveSettings()
    end

    function InterfaceManager:BuildInterfaceSection(tab)
        assert(self.Library, "Must set InterfaceManager.Library")
		local Library = self.Library
        local Settings = InterfaceManager.Settings

        InterfaceManager:LoadSettings()

		local section = tab:AddSection("Interface")

		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = Library.Themes,
			Default = Settings.Theme,
			Callback = function(Value)
				Library:SetTheme(Value)
                Settings.Theme = Value
                InterfaceManager:SaveSettings()
			end
		})

        InterfaceTheme:SetValue(Settings.Theme)
	
		if Library.UseAcrylic then
			section:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = Settings.Acrylic,
				Callback = function(Value)
					Library:ToggleAcrylic(Value)
                    Settings.Acrylic = Value
                    InterfaceManager:SaveSettings()
				end
			})
		end
	
		section:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = Settings.Transparency,
			Callback = function(Value)
				Library:ToggleTransparency(Value)
				Settings.Transparency = Value
                InterfaceManager:SaveSettings()
			end
		})
	
		local MenuKeybind = section:AddKeybind("MenuKeybind", { 
			Title = "Minimize Bind", 
			Description = "Keybind to toggle UI visibility",
			Default = Settings.MenuKeybind or "RightControl"
		})
		MenuKeybind:OnChanged(function()
			Settings.MenuKeybind = MenuKeybind.Value
            InterfaceManager:SaveSettings()
		end)
		Library.MinimizeKeybind = MenuKeybind
		
		-- Reset Settings Button
		section:AddButton({
			Title = "Reset to Default",
			Description = "Reset all interface settings to default (CatHub theme)",
			Callback = function()
				Window:Dialog({
					Title = "Reset Settings",
					Content = "Are you sure you want to reset all interface settings to default?\nThis will apply CatHub theme (Orange/Yellow colors).",
					Buttons = {
						{
							Title = "Reset",
							Callback = function()
								InterfaceManager:ResetSettings()
								Library:SetTheme("CatHub")
								InterfaceTheme:SetValue("CatHub")
								MenuKeybind:SetValue("RightControl", "Toggle")
								
								Library:Notify({
									Title = "CatHub",
									Content = "Settings reset! CatHub theme (Orange/Yellow) applied",
									Duration = 4
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