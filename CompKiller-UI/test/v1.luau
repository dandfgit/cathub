local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

task.wait(1)

Compkiller:Loader(nil , 1).yield()

local FileWatcher = Compkiller:ConfigManager({
	Directory = "Compkiller",
	Config = "Example-Configs"	
});

local Window = Compkiller.new({
	Keybind = "LeftAlt",
});

--Compkiller:ChangeHighlightColor(Color3.fromRGB(0, 195, 255))

local watermark = Window:Watermark();

watermark:AddText({
	Icon = "user",
	Text = "Battleye"
})


local vim = watermark:AddText({
	Icon = "clock",
	Text = Compkiller:GetTimeNow()
})

task.spawn(function()
	while true do task.wait()
		vim:SetText(Compkiller:GetTimeNow())
		
		Window.Username =  "Tester"
	end;
end)

Window:Update({
	ExpireDate = Compkiller:GetDate(tick() + 84000)
})

watermark:AddText({
	Icon = "server",
	Text = "Owner"
})

local Rage = Window:DrawTab({
	Icon = "skull",
	Name = "Ragebot",
	Type = "Double"
});

local Legit = Window:DrawTab({
	Icon = "mouse-2",
	Name = "Legitbot"
});

Window:DrawCategory({
	Name = "Visual"
})

local Entities = Window:DrawContainerTab({
	Icon = "eye",
	Name = "Entities"
});

local Tap1 = Entities:DrawTab({
	Icon = "skull",
	Name = "Example 1"
})

local Tap2 = Entities:DrawTab({
	Icon = "mouse-2",
	Name = "Example 2"
})

local World = Window:DrawTab({
	Icon = "triangle",
	Name = "World"
});

local Misc = Window:DrawTab({
	Icon = "box",
	Name = "Misc"
});

local Inventory = Window:DrawTab({
	Icon = "backpack",
	Name = "Inventory"
});

Window:DrawCategory({
	Name = "Misc"
})

local General = Window:DrawTab({
	Name = "General",
	Icon = "settings-3",
	Type = 'Single'
});

local Configs = Window:DrawConfig({
	Name = "Configs",
	Icon = "folder",
	Config = FileWatcher
});

Configs:Init();

do
	local general = Rage:DrawSection({
		Name = "General",
		Position = 'LEFT'
	});
	
	local WeaponSelection = Rage:DrawSection({
		Name = "Weapon Selection",
		Position = 'right'
	});
	
	local Other = Rage:DrawSection({
		Name = "",
		Position = 'right'
	});
	
	local general_enabled = general:AddToggle({
		Name = "Enabled",
		Flag = "s222sdad",
		Callback = print
	});
	
	local slientAim = general:AddToggle({
		Name = "Slient Aim",
		Flag = "dsadwafgwgfas",
		Callback = print
	});
	
	local option = general_enabled.Link:AddOption();
	
	option:AddToggle({
		Name = "Target Team",
		Flag = "TargetTeam"
	})
	
	option:AddToggle({
		Name = "Target Enemy",
		Flag = "EnemyTeam",
	})
	
	local option = slientAim.Link:AddOption();
	
	option:AddToggle({
		Name = "Hide Shots",
		Flag = "dwasd",
		Risky = true
	})
	
	general:AddToggle({
		Name = "Auto Scope",
		Flag = "scope",
		Callback = print
	});
	
	general:AddToggle({
		Name = "Compensate Spread",
		Risky = true,
		Flag = "spread",
		Callback = print
	});
	
	general:AddToggle({
		Name = "Double Tap",
		Risky = true,
		Flag = "dt",
		Callback = print
	});
	
	general:AddToggle({
		Name = "Limit FOV",
		Flag = "wasdgas",
		Callback = print
	}).Link:AddHelper({
		Text = "this feature will tap you enemy\nVERY OP!"
	});
	
	general:AddToggle({
		Name = "Min. Dmg. Override",
		Flag = "hg4rwedfg",
		Callback = print
	}).Link:AddHelper({
		Text = "this feature will rape you enemy"
	});
	
	general:AddToggle({
		Name = "Disable Penetration",
		Flag = "grsert2",
		Callback = print
	});
	
	local opt = general:AddToggle({
		Name = "Override Hitboxes",
		Flag = "feafgetg34",
		Callback = print
	}).Link:AddOption()
		
	opt:AddToggle({
		Flag = "feagdfae",
		Name = "skbidi"
	});
	
	opt:AddToggle({
		Flag = "hgr5teh345y3",
		Name = "skbidi"
	});
	
	opt:AddToggle({
		Flag = "1231251",
		Name = "skbidi"
	});
	
	
	opt:AddToggle({
		Flag = "jky5tj654",
		Name = "skbidi"
	});
	
	opt:AddToggle({
		Flag = "i75ythq",
		Name = "skbidi"
	});
	
	WeaponSelection:AddDropdown({
		Name = "",
		Flag = "njytrgn",
		Values = {"General","R8","USP","SSG","AWP","M4A4-S","M4A4"},
		Default = "General"
	})
	
	general:AddParagraph({
		Title = "Information",
		Content = "Compkiller UI\nby skbidi sigma\nbrainrot user"
	})
	
	Other:AddToggle({
		Name = "Enabled",
		Flag = "jy7trghn3",
		Callback = print
	})

	Other:AddToggle({
		Name = "Auto Stop",
		Flag = "ht4rh453",
		Callback = print
	}).Link:AddOption();
	
	Other:AddSlider({
		Name = "Minimum Damage",
		Min = 0,
		Flag = "32trefb45t",
		Max = 100,
		Default = 50
	})
	
	Other:AddSlider({
		Name = "Hitchance",
		Min = 0,
		Max = 100,
		Flag = "yh54hgtrh",
		Type = "%",
		Default = 50
	})
	
	Other:AddDropdown({
		Name = "Target Hitboxes",
		Values = {"Head","Chest","Pelvis","Arms","Legs"},
		Default = {"Head"},
		Flag = "dfsgfvew5y3456",
		Multi = true
	})
	
	Other:AddDropdown({
		Name = "Multipointed Hitboxes",
		Values = {"Head","Chest","Pelvis","Arms","Legs"},
		Default = {"Head"},
		Flag = "hntberh6754",
		Multi = true
	}).Link:AddOption();
	
	Other:AddButton({
		Name = "Make",
		Callback = function()
			print(Compkiller:GetConfig())
		end,
	})
end;

local Example = function(Tab)
	local left = Tab:DrawSection({
		Name = "Example",
		Position = "left"
	})
	
	local right = Tab:DrawSection({
		Name = "Example",
		Position = "right"
	})
	
	local load = function(section)
		section:AddToggle({
			Name = "Toggle",
			Callback = print
		}).Link:AddKeybind({
			Name = "Keybind",
			Default = nil,
			Callback = print
		});
		
		section:AddSlider({
			Name = "Slider",
			Min = 0,
			Max = 100,
			Round = 1,
			Type = "%",
			Default = 50,
			Callback = print
		})
		
		section:AddDropdown({
			Name = "Single Dropdown",
			Values = {"Head","Chest","Pelvis","Arms","Legs"},
			Default = "Head",
			Multi = false,
			Callback = print
		})
		
		section:AddDropdown({
			Name = "Multi Dropdown",
			Values = {"Head","Chest","Pelvis","Arms","Legs"},
			Default = {"Head"},
			Multi = true,
			Callback = print
		})
		
		section:AddColorPicker({
			Name = "ColorPicker",
			Default = Color3.fromRGB(107, 255, 28),
			Flag = tostring(math.random(1,1000))..tostring(math.random(1,1000))..tostring(math.random(1,1000))..tostring(math.random(1,1000)),
			Callback = print
		});
		
		section:AddKeybind({
			Name = "Keybind",
			Default = nil,
			Callback = print
		});
		
		section:AddColorPicker({
			Name = "Double ColorPicker",
			Default = Color3.fromRGB(107, 255, 28),
			Callback = print
		}).Link:AddColorPicker({
			Name = "Double ColorPicker",
			Default = Color3.fromRGB(255, 0, 4),
			Callback = print
		});
	end;
	
	load(left)
	load(right)
end;

Example(Legit)
Example(Tap1);
Example(Tap2)

local main = General:DrawSection({
	Name = "UI Settings"
});

local ml = main:AddColorPicker({
	Name = 'Highlight',
	Default = Compkiller.Colors.Highlight,
	Flag = "hntbdhg43",
	Callback = function(v)
		Compkiller:ChangeHighlightColor(v)
	end,
}).Link:AddOption();

ml:AddToggle({
	Name = "Rainbow",
	Flag = "vdsfg34w33434",
	Default = false,
	Callback = function(v)
		_G.RAINBOW = v
	end,
})


main:AddToggle({
	Name = "Alway Show Tab",
	Default = Window.AlwayShowTab,
	Flag = "jyrtuj65467",
	Callback = function(v)
		Window.AlwayShowTab = v;
	end,
})

ml:AddSlider({
	Name = "Speed",
	Min = 0.01,
	Max = 1,
	Round = 2,
	Default = 0.1,
	Flag = "hngrh13241",
	Callback = function(v)
		_G.RAINBOW_SPEED = v;
	end,
})

task.spawn(function()
	local x = 0

	while true do task.wait(_G.RAINBOW_SPEED or 0.1)
		
		if _G.RAINBOW then
			Compkiller:ChangeHighlightColor(Color3.fromHSV(x,1,1))

			x = x + 2/255

			if x >= 1 then
				x = 0
			end
		end;
	end
end)
