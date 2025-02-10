local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/LeafGaming1/RobloxStuff/main/FleeTheFacility/Library.lua'))()

local TeleportService = cloneref(game:GetService("TeleportService"))
local PlaceId, JobId = game.PlaceId, game.JobId
local Players = cloneref(game:GetService("Players"))

local Window = Rayfield:CreateWindow({
    Name = "Flee The Game",
    LoadingTitle = "Use only at your own facility",
    LoadingSubtitle = "I MEAN IT",
    Icon = 0,
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisbaleBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "FleeTheFacility",
        FileName = "FleeTheFacilityHUB"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
	HWIDWhitelist = false,
	HWIDSite = {'https://raw.githubusercontent.com/LeafGaming1/RobloxStuff/main/FleeTheFacility/Whitelist.txt'},
	HWIDKickIfNotWhitelisted = false,
        Title = "Flee the key system!",
        Subtitle = "wait dont-",
        Note = "Hint: https://github.com/LeafGaming1/RobloxStuff/blob/main/FleeTheFacility/key",
        FileName = "FTFKey",
        SaveKey = false,
        GrabKeyFromSite = true,
        Key = "https://raw.githubusercontent.com/LeafGaming1/RobloxStuff/refs/heads/main/FleeTheFacility/key"
    }
})

-- Tabs
local Home = Window:CreateTab("Home", 13209388803)
local Esp = Window:CreateTab("Esp (EXPECT BUGS)", 13209481800)
local Beast = Window:CreateTab("Beast", 13209523447)
local NBeast = Window:CreateTab("Non-Beast", 13209387638)
local Player = Window:CreateTab("Player", 13209386618)

-- ESP Section
local EspSection = Esp:CreateSection("ESP")

-- Toggle: Player ESP
local PlayerESPToggle = Esp:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(state)
        local function clearOldESP()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local oldESP = player.Character:FindFirstChild(player.Name .. "'s ESP")
                    if oldESP then
                        oldESP:Destroy()
                    end
                end
            end
        end
        if state then
            

            clearOldESP()

            if getgenv().LoopPlayerESP then
                getgenv().LoopPlayerESP:Disconnect()
                getgenv().LoopPlayerESP = nil
            end

           getgenv().LoopPlayerESP = game:GetService("RunService").Stepped:Connect(function()
		    for _, player in pairs(game.Players:GetPlayers()) do
		        if player.Name ~= game.Players.LocalPlayer.Name and player.Character then
		            -- Ensure a folder exists for the player's ESP
		            local folder = player.Character:FindFirstChild(player.Name .. "'s ESP")
		            if not folder then
		                folder = Instance.new("Folder", player.Character)
		                folder.Name = player.Name .. "'s ESP"
		            end
		
		            -- Loop through all parts of the character
		            for _, part in ipairs(player.Character:GetChildren()) do
		                if part:IsA("BasePart") then
		                    -- Check if the adornment for this part already exists
		                    local adornment = folder:FindFirstChild(part.Name .. " ESP")
		                    if not adornment then
		                        -- Create a new BoxHandleAdornment for this part
		                        adornment = Instance.new("BoxHandleAdornment", folder)
		                        adornment.Name = part.Name .. " ESP"
		                        adornment.Adornee = part
		                        adornment.Size = part.Size
		                        adornment.Transparency = 0.5
		                        adornment.AlwaysOnTop = true
		                        adornment.ZIndex = 2
		                    end
		                    -- Update the color dynamically based on the IsBeast value
		                    adornment.Color3 = player:FindFirstChild("TempPlayerStatsModule") and
		                        player.TempPlayerStatsModule:FindFirstChild("IsBeast") and
		                        player.TempPlayerStatsModule.IsBeast.Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
		                end
		            end
		        end
		    end
		end)
	else
            if getgenv().LoopPlayerESP then
                clearOldESP()
                getgenv().LoopPlayerESP:Disconnect()
                getgenv().LoopPlayerESP = nil
            end
        end
    end
})

-- Add more toggle and button configurations for ESP, Beast, Non-Beast, and Player tabs here
-- Ensure all structures are properly closed with "end"


local Toggle = Esp:CreateToggle({
   Name = "Door Esp",
   CurrentValue = false,
   Flag = "DoorESP", -- Ensure every element has a different flag
   Callback = function(state)
      getgenv().DoorESP = state
      if state == true then
         task.spawn(function()
            while getgenv().DoorESP do
               task.wait(0.5) -- Add a delay to prevent excessive looping
               for _, v in pairs(workspace:GetDescendants()) do
                  if v.Name == "SingleDoor" then
                     pcall(function()
			for _, child in v:GetChildren() do
		           local doorPart = v:FindFirstChild("Door")
                           if doorPart then
			      if not doorPart:FindFirstChild("Highlight") then
	                         local ESP = Instance.new("Highlight")
	                         ESP.Name = "Highlight"
	                         ESP.Parent = doorPart
			      else
			         local actionSignValue = v:FindFirstChild("DoorTrigger") and v.DoorTrigger:FindFirstChild("ActionSign") and v.DoorTrigger.ActionSign.Value
                                 if actionSignValue == 11 then
                                    ESP.FillColor = Color3.new(0, 1, 0) -- Green for ActionSign value 11
                                 elseif actionSignValue == 10 then
                                    ESP.FillColor = Color3.new(1, 0, 0) -- Red for ActionSign value 10
				 end
                              end
                           end
			end
                     end)
		  elseif v.Name == "DoubleDoor" then
		     pcall(function()
			for _, child in v:GetChildren() do
		           local doorPart = v:FindFirstChild("DoorR")
                           if doorPart then
			      if not doorPart:FindFirstChild("Highlight") then
	                         local ESP = Instance.new("Highlight")
	                         ESP.Name = "Highlight"
	                         ESP.Parent = doorPart
			      else
			         local actionSignValue = v:FindFirstChild("DoorTrigger") and v.DoorTrigger:FindFirstChild("ActionSign") and v.DoorTrigger.ActionSign.Value
                                 if actionSignValue == 11 then
                                    ESP.FillColor = Color3.new(0, 1, 0) -- Green for ActionSign value 11
                                 elseif actionSignValue == 10 then
                                    ESP.FillColor = Color3.new(1, 0, 0) -- Red for ActionSign value 10
				 end
                              end
                           end
			   local doorPart2 = v:FindFirstChild("DoorL")
                           if doorPart2 then
			      if not doorPart2:FindFirstChild("Highlight") then
	                         local ESP = Instance.new("Highlight")
	                         ESP.Name = "Highlight"
	                         ESP.Parent = doorPart2
			      else
			         local actionSignValue = v:FindFirstChild("DoorTrigger") and v.DoorTrigger:FindFirstChild("ActionSign") and v.DoorTrigger.ActionSign.Value
                                 if actionSignValue == 11 then
                                    ESP.FillColor = Color3.new(0, 1, 0) -- Green for ActionSign value 11
                                 elseif actionSignValue == 10 then
                                    ESP.FillColor = Color3.new(1, 0, 0) -- Red for ActionSign value 10
				 end
                              end
                           end
			end
                     end)
		  end
               end
            end
         end)
      else
         for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "SingleDoor" or v.Name == "DoubleDoor" then
               pcall(function()
                  local doorPart = v:FindFirstChild("Door") or v:FindFirstChild("DoorL") or v:FindFirstChild("DoorR")
                  if doorPart then
                     local highlight = doorPart:FindFirstChild("Highlight")
                     if highlight then
                        highlight:Destroy()
                     end
                  end
               end)
            end
         end
      end
   end,
})

local Toggle = Esp:CreateToggle({
    Name = "Computer Esp",
    CurrentValue = false,
    Flag = "ComputerESP", -- A flag is the identifier for the configuration file, ensure unique flags for no overlap
    Callback = function(state)
        if state == true then
            getgenv().StopComputerESP = false
            

            task.spawn(function()
                while true do
		    for i, v in pairs(workspace:GetDescendants()) do 
	                if v.Name == "ComputerTable" then
	                    pcall(function()
			        if not v:FindFirstChild("Highlight") then
				    local ESP = Instance.new("Highlight")
		                    task.wait()
		                    ESP.Parent = v
				    
				end
				if v.Screen.BrickColor == BrickColor.new("Bright blue") then
	                            pcall(function()
	                                v:WaitForChild("Highlight", 10).FillColor = Color3.new(0, 0, 1)
	                            end)
	                        elseif v.Screen.BrickColor == BrickColor.new("Dark green") then
	                            pcall(function()
	                                v:WaitForChild("Highlight", 10).FillColor = Color3.new(0, 1, 0)
	                            end)
	                        end
	                    end)
	                end
	            end
                    if getgenv().StopComputerESP == true then
	                break
	            end
                    task.wait(1)
                end
            end)
        else
            getgenv().StopComputerESP = true
            for i, v in pairs(workspace:GetDescendants()) do 
                if v.Name == "ComputerTable" then
                    pcall(function()
                        v.Highlight:Destroy()
                    end)
                end
            end
        end
    end,
})


local Toggle = Esp:CreateToggle({
   Name = "Freeze Pod Esp",
   CurrentValue = false,
   Flag = "FreezePodESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(state)
   if state == true then
for i,v in pairs(workspace:GetDescendants()) do 
    if v.Name == "FreezePod" then
        pcall(function()
        local ESP = Instance.new("Highlight",v)
        end)
    end
end
else
for i,v in pairs(workspace:GetDescendants()) do 
    if v.Name == "FreezePod" then
        pcall(function()
        v.Highlight:Destroy()
        end)
    end
end
end
   end,
})

local Section = Beast:CreateSection("Beast")

local Button = Beast:CreateButton({
   Name = "Infinite Sprint",
   Callback = function()
if game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
game.UserInputService.InputBegan:Connect(function(key)
if key.KeyCode == Enum.KeyCode.Q then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
end
end)

game.UserInputService.InputEnded:Connect(function(key)
if key.KeyCode == Enum.KeyCode.Q then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end)

pcall(function()
game.Players.LocalPlayer.Character.PowersLocalScript:Destroy()    
end)
end
end,
})

local Button = Beast:CreateButton({
   Name = "No Slow",
   Callback = function()
if game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
pcall(function()
game.Players.LocalPlayer.Character.PowersLocalScript:Destroy()
end)
end
   end,
})

local Button = Beast:CreateButton({
   Name = "Enable Crawl",
   Callback = function()
if game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
game:GetService("Players").LocalPlayer.TempPlayerStatsModule.DisableCrawl.Value = false
end
end
})

local Button = Beast:CreateButton({
   Name = "Remove Sound And Glow",
   Callback = function()
if game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
for i,v in pairs(game.Players.LocalPlayer.Character.Hammer.Handle:GetChildren()) do
    if v:IsA("Sound") then
        pcall(function()
        v:Destroy()
        end)
    end
end

pcall(function()
game.Players.LocalPlayer.Character.Gemstone.Handle.PointLight:Destroy()
end)
end
end
})

local Button = Beast:CreateButton({
   Name = "Fix Camera",
   Callback = function()
local player = game.Players.LocalPlayer

	workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	player.CameraMinZoomDistance = 0.5
	player.CameraMaxZoomDistance = math.huge
	player.CameraMode = "Classic"
	player.Character.Head.Anchored = false
   end,
})

local Section = NBeast:CreateSection("Non-Beast",true)

local Button = NBeast:CreateButton({
   Name = "Q to Sprint",
   Callback = function()
game.UserInputService.InputBegan:Connect(function(key)
if key.KeyCode == Enum.KeyCode.Q then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
end
end)

game.UserInputService.InputEnded:Connect(function(key)
if key.KeyCode == Enum.KeyCode.Q then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end)

pcall(function()
game.Players.LocalPlayer.Character.PowersLocalScript:Destroy()    
end)
end,
})

local Button = NBeast:CreateButton({
   Name = "No fail on hack",
   Callback = function()
spawn(function()
while wait() do
game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult",true)
end
end)
end,
})

local Section = Player:CreateSection("Player")

local Button = Player:CreateButton({
   Name = "Respawn",
   Callback = function()
   Rayfield:Notify({Title = "Feature disabled.", Content = "This feature is disabled for security purposes.", Duration = 7, Image = 4400697855})
--[[local plr = game.Players.LocalPlayer
plr.Character:Destroy()			
]]
end,
})

local Button = Player:CreateButton({
   Name = "Invisible (must disable anticheat)",
   Callback = function()
   Rayfield:Notify({Title = "Feature disabled.", Content = "This feature is disabled for security purposes.", Duration = 7, Image = 4400697855})
--[[local Global = getgenv and getgenv()
local First = true
local Restart = true
local SoundService = game:GetService("SoundService")
local StoredCF
local SafeZone
if Global.SafeZone ~= nil then
	if type(Global.SafeZone) ~= "userdata" then return error("CFrame must be a userdata (CFrame.new(X, X, X)") end
	SafeZone = Global.SafeZone
else
	SafeZone = CFrame.new(0,-300,0)
end

local ScriptStart = true
local Reset = false
local DeleteOnDeath = {}
local Activate
local Noclip
if Global.Key == nil then
	Activate = "F"
else
	Activate = tostring(Global.Key)     
end

if Global.Noclip == nil then
	Noclip = false
else
	Noclip = Global.Noclip        
end

if type(Noclip) ~= "boolean" then return error("Noclip value isn't a boolean") end

function notify(Message)
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "FE Invisible";
		Text = Message;
		Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://7046168694"
	SoundService:PlayLocalSound(sound)
end

if Global.Running then
	return notify("Script is already running")
else
	Global.Running = true
end

local IsInvisible = false
local WasInvisible = false
local Died = false
local LP = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
repeat wait() until LP.Character
repeat wait() until LP.Character:FindFirstChild("Humanoid")
local RealChar = LP.Character or LP.CharacterAdded:Wait()
RealChar.Archivable = true
local FakeChar = RealChar:Clone()
FakeChar:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
FakeChar.Parent = game:GetService("Workspace")

for _, child in pairs(FakeChar:GetDescendants()) do
	if child:IsA("BasePart") and child.CanCollide == true then
		child.CanCollide = false
	end
end

FakeChar:SetPrimaryPartCFrame(SafeZone * CFrame.new(0, 5, 0))

local Part
Part = Instance.new("Part", workspace)
Part.Anchored = true
Part.Size = Vector3.new(200, 1, 200)
Part.CFrame = SafeZone
Part.CanCollide = true


for i, v in pairs(FakeChar:GetDescendants()) do
	if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
		v.Transparency = 0.7
	end
end

for i, v in pairs(RealChar:GetChildren()) do
	if v:IsA("LocalScript") then
		local clone = v:Clone()
		clone.Disabled = true
		clone.Parent = FakeChar
	end
end

function StopScript()
	if ScriptStart == false then return end
	if Died == false then
		if Restart == true then
			notify("The character used died!\nStopping...")
		else
			notify("Script successfuly ended !")
		end
		Part:Destroy()
		if IsInvisible and RealChar:FindFirstChild("HumanoidRootPart") then
			Visible() 
			WasInvisible = true
		end
		
		if IsInvisible == false and LP.Character:WaitForChild("Humanoid").Health == 0 then
			WasInvisible = true
		end
		if not RealChar:FindFirstChild("Humanoid") then
			Reset = true
			print("a")
		end
		
		game:GetService("Workspace").CurrentCamera.CameraSubject = RealChar:WaitForChild("Humanoid")

		if FakeChar then
			FakeChar:Destroy()
		end

		if WasInvisible then
			local char = LP.Character
			if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
			char:ClearAllChildren()
			local newChar = Instance.new("Model")
			newChar.Parent = workspace
			LP.Character = newChar
			wait()
			LP.Character = char
			newChar:Destroy()
			for _,v in pairs(DeleteOnDeath) do
				v:Destroy()
			end
			
		else
			for _,v in pairs(DeleteOnDeath) do
				v.ResetOnSpawn = true
			end
		end
		Global.Running = false
		ScriptStart = false
		if Restart == true then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Error-Cezar/Roblox-Scripts/main/FE-Invisible.lua'))()
		end
		
			LP.CharacterAdded:Connect(function()
				if Reset == false then return end
			loadstring(game:HttpGet('https://raw.githubusercontent.com/Error-Cezar/Roblox-Scripts/main/FE-Invisible.lua'))()
		end)
		
	end
end

RealChar:WaitForChild("Humanoid").Died:Connect(function()
	StopScript()
end)


FakeChar:WaitForChild("Humanoid").Died:Connect(function()
	StopScript()
end)

function Invisible()
	StoredCF = RealChar:GetPrimaryPartCFrame()
	
if First == true then
		First = false
		for _,v in pairs(LP:WaitForChild("PlayerGui"):GetChildren()) do 
		if v:IsA("ScreenGui") then
			if v.ResetOnSpawn == true then
				v.ResetOnSpawn = false
				table.insert(DeleteOnDeath, v)
			end
		end
	end
	end
	
	if Noclip == true then
	for _, child in pairs(FakeChar:GetDescendants()) do
		if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = false
		end
		end
	end
	FakeChar:SetPrimaryPartCFrame(StoredCF)
	FakeChar:WaitForChild("HumanoidRootPart").Anchored = false
	LP.Character = FakeChar
	game:GetService("Workspace").CurrentCamera.CameraSubject = FakeChar:WaitForChild("Humanoid")
		for _, child in pairs(RealChar:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end

	RealChar:SetPrimaryPartCFrame(SafeZone * CFrame.new(0, 5, 0))
	--	RealChar:WaitForChild("HumanoidRootPart").Anchored = true
	RealChar:WaitForChild("Humanoid"):UnequipTools()

	for i, v in pairs(FakeChar:GetChildren()) do
		if v:IsA("LocalScript") then
			v.Disabled = false
		end
	end
end

function Visible()
	StoredCF = FakeChar:GetPrimaryPartCFrame()
	for _, child in pairs(RealChar:GetDescendants()) do
		if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = true
		end
	end
	RealChar:WaitForChild("HumanoidRootPart").Anchored = false
	RealChar:SetPrimaryPartCFrame(StoredCF)
	LP.Character = RealChar
	FakeChar:WaitForChild("Humanoid"):UnequipTools()
	game:GetService("Workspace").CurrentCamera.CameraSubject = RealChar:WaitForChild("Humanoid")
	for _, child in pairs(FakeChar:GetDescendants()) do
		if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = false
		end
	end
	FakeChar:SetPrimaryPartCFrame(SafeZone * CFrame.new(0, 5, 0))
		FakeChar:WaitForChild("HumanoidRootPart").Anchored = true
	for i, v in pairs(FakeChar:GetChildren()) do
		if v:IsA("LocalScript") then
			v.Disabled = true
		end
	end
end


UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if ScriptStart == false then return end
	if gameProcessed then return end
	if input.KeyCode.Name:lower() ~= Activate:lower() then return end
	if IsInvisible == false then
		Invisible()
		IsInvisible = true
	else
		Visible()
		IsInvisible = false
	end
end)]]
end,
})

local Button = Player:CreateButton({
   Name = "Rejoin",
   Callback = function()
	if identifyexecutor() == "Solara" then
	    Rayfield:Notify({Title = "Feature disabled.", Content = "This feature is not supported by your executor ("..identifyexecutor()..").", Duration = 7, Image = 4400697855})
        elseif #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            wait()
            TeleportService:Teleport(PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
        end
   end,
})

local Button = Player:CreateButton({
   Name = "Bypass Anticheat (dont if beast)",
   Callback = function()
   Rayfield:Notify({Title = "Feature disabled.", Content = "This feature is disabled for security purposes.", Duration = 7, Image = 4400697855})
--[[local character = game.Players.LocalPlayer.Character
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    local root = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    character.Parent = nil
    root.Parent = nil 
    wait(0.5)
    local fake = torso:Clone()
    fake.Parent = character
    torso.Name = "HumanoidRootPart"
    torso.Transparency = 1
    getgenv().Torsoo = torso
    character.Parent = workspace
    ]]
end,
})

local Button = Player:CreateButton({
   Name = "Reload",
   Callback = function()
	task.spawn(function()
		task.wait(1)
		Rayfield:Destroy()
	end)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LeafGaming1/RobloxStuff/main/FleeTheFacility/Script.lua"))()
	task.wait(2)
	script.Enabled = false
   end,
})


local Label = Home:CreateLabel("This was made by LeafGaming1")
local Label = Home:CreateLabel("github.com/LeafGaming1")
local Label = Home:CreateLabel("https://www.youtube.com/@Towwweel")
local Label = Home:CreateLabel("themoon")
