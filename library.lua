if getgenv().voltclient then
    warn("Script already loaded/is loading or errored.")
    return
end
getgenv().voltclient = true

loadstring([[
  function LPH_NO_VIRTUALIZE(f) return f end;
]])();

local debris = game:GetService("Debris")
local contentProvider = game:GetService("ContentProvider")
local scriptContext = game:GetService("ScriptContext")
local players = game:GetService("Players")

local TweenService = game:GetService("TweenService")
local statsService = game:GetService("Stats")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local starterGui = game:GetService("StarterGui")

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local Workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local values = replicatedStorage:FindFirstChild("Values")

function findClosestBall()
	local lowestDistance = math.huge
	local nearestBall = nil

	local character = player.Character

	for index, ball in pairs(workspace:GetChildren()) do
		if ball.Name ~= "Football" then continue end
		if not ball:IsA("BasePart") then continue end
		if not character:FindFirstChild("HumanoidRootPart") then continue end
		local distance = (ball.Position - character.HumanoidRootPart.Position).Magnitude

		if distance < lowestDistance then
			nearestBall = ball
			lowestDistance = distance
		end
	end

	return nearestBall
end

local IS_PRACTICE = game.PlaceId == 8206123457
local IS_SOLARA = string.match(getexecutorname(), "Solara")
local AC_BYPASS = IS_PRACTICE

local moveToUsing = {}

if not values or IS_PRACTICE then
if replicatedStorage:FindFirstChild("Values") then
  replicatedStorage:FindFirstChild("Values"):Destroy()
end
values = Instance.new("Folder")
local status = Instance.new("StringValue")
status.Name = "Status"
status.Value = "InPlay"
status.Parent = values
values.Parent = replicatedStorage
values.Name = "Values"
end

if not LPH_OBFUSCATED then
  getfenv().LPH_NO_VIRTUALIZE = function(f) return f end
end


local ReplicatedStorage = game:GetService("ReplicatedStorage")


local Handshake = ReplicatedStorage.Remotes.CharacterSoundEvent
local Hooks = {}
local HandshakeInts = {}

LPH_NO_VIRTUALIZE(function()
  for i, v in getgc() do
      if typeof(v) == "function" and islclosure(v) then
          if (#getprotos(v) == 1) and table.find(getconstants(getproto(v, 1)), 4000001) then
              hookfunction(v, function() end)
          end
      end
  end
end)()

Hooks.__namecall = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(self, ...)
  local Method = getnamecallmethod()
  local Args = {...}

  if not checkcaller() and (self == Handshake) and (Method == "fireServer") and (string.find(Args[1], "AC")) then
      if (#HandshakeInts == 0) then
          HandshakeInts = {table.unpack(Args[2], 2, 18)}
      else
          for i, v in HandshakeInts do
              Args[2][i + 1] = v
          end
      end
  end

  return Hooks.__namecall(self, ...)
end))

task.wait(1)

local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

local Window = MacLib:Window({
	Title = "Volt Client 2.0.0",
	Subtitle = "Build - Paid | FF2",
	Size = UDim2.fromOffset(820, 615),
	DragStyle = 2,
	DisabledWindowControls = {},
	ShowUserInfo = true,
	Keybind = Enum.KeyCode.RightControl,
	AcrylicBlur = true,
})

local globalSettings = {
	UIBlurToggle = Window:GlobalSetting({
		Name = "UI Blur",
		Default = Window:GetAcrylicBlurState(),
		Callback = function(bool)
			Window:SetAcrylicBlurState(bool)
			Window:Notify({
				Title = Window.Settings.Title,
				Description = (bool and "Enabled" or "Disabled") .. " UI Blur",
				Lifetime = 5
			})
		end,
	}),
	NotificationToggler = Window:GlobalSetting({
		Name = "Notifications",
		Default = Window:GetNotificationsState(),
		Callback = function(bool)
			Window:SetNotificationsState(bool)
			Window:Notify({
				Title = Window.Settings.Title,
				Description = (bool and "Enabled" or "Disabled") .. " Notifications",
				Lifetime = 5
			})
		end,
	}),
	ShowUserInfo = Window:GlobalSetting({
		Name = "Show User Info",
		Default = Window:GetUserInfoState(),
		Callback = function(bool)
			Window:SetUserInfoState(bool)
			Window:Notify({
				Title = Window.Settings.Title,
				Description = (bool and "Showing" or "Redacted") .. " User Info",
				Lifetime = 5
			})
		end,
	})
}

local tabGroups = {
	Game = Window:TabGroup(),
	World = Window:TabGroup(),
	Other = Window:TabGroup()
}

local tabs = {
    Catching = tabGroups.Game:Tab({ Name = "Catching", Image = "rbxassetid://10723405649" }),
    Physics = tabGroups.World:Tab({ Name = "Physics", Image = "rbxassetid://10747382750" }),
    Quarterback = tabGroups.Game:Tab({ Name = "Quarterback", Image = "rbxassetid://10734898592" }),
    Visuals = tabGroups.World:Tab({ Name = "Visuals", Image = "rbxassetid://104811813262009" }),
    Defense = tabGroups.Game:Tab({ Name = "Defense", Image = "rbxassetid://10734951847" }),
    Automatics = tabGroups.World:Tab({ Name = "Automatics", Image = "rbxassetid://10709759764" }),
    Player = tabGroups.Other:Tab({ Name = "Player", Image = "rbxassetid://10734920149" }),
    Settings = tabGroups.Other:Tab({ Name = "Settings", Image = "rbxassetid://10734950309" })
}


local sections = {
	mag1 = tabs.Catching:Section({ Side = "Left" }),
	mag2 = tabs.Catching:Section({ Side = "Left" }),
	mag3 = tabs.Catching:Section({ Side = "Right" }),
	mag4 = tabs.Catching:Section({ Side = "Right" }),

	physic1 = tabs.Physics:Section({ Side = "Left" }),
	physic2 = tabs.Physics:Section({ Side = "Left" }),
	physic3 = tabs.Physics:Section({ Side = "Right" }),
	physic4 = tabs.Physics:Section({ Side = "Right" }),

	qb1 = tabs.Quarterback:Section({ Side = "Left" }),
	qb2 = tabs.Quarterback:Section({ Side = "Left" }),
	qb3 = tabs.Quarterback:Section({ Side = "Right" }),
	qb4 = tabs.Quarterback:Section({ Side = "Right" }),

	visual1 = tabs.Visuals:Section({ Side = "Left" }),
	visual2 = tabs.Visuals:Section({ Side = "Left" }),
	visual3 = tabs.Visuals:Section({ Side = "Right" }),
	visual4 = tabs.Visuals:Section({ Side = "Right" }),

	defense1 = tabs.Defense:Section({ Side = "Left" }),
	defense2 = tabs.Defense:Section({ Side = "Left" }),
	defense3 = tabs.Defense:Section({ Side = "Right" }),
	defense4 = tabs.Defense:Section({ Side = "Right" }),

	automatic1 = tabs.Automatics:Section({ Side = "Left" }),
	automatic2 = tabs.Automatics:Section({ Side = "Left" }),
	automatic3 = tabs.Automatics:Section({ Side = "Right" }),
	automatic4 = tabs.Automatics:Section({ Side = "Right" }),

	player1 = tabs.Player:Section({ Side = "Left" }),
	player2 = tabs.Player:Section({ Side = "Left" }),
	player3 = tabs.Player:Section({ Side = "Right" }),
	player4 = tabs.Player:Section({ Side = "Right" }),
}

sections.mag1:Header({
	Name = "Magnets"
})


local distance = 10
local hitboxSize = Vector3.new(distance, distance, distance)
shared.Mags = false

sections.mag1:Slider({
    Name = "Magnet Distance",
    Default = 10,
    Minimum = 0,
    Maximum = 25,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(value)
        distance = value
        hitboxSize = Vector3.new(value, value, value)
    end
}, "MagnetDistance")

sections.mag1:Toggle({
    Name = "Magnets",
    Default = false,
    Callback = function(value)
        shared.Mags = value
        Window:Notify({
            Title = Window.Settings.Title,
            Description = (value and "Enabled " or "Disabled ") .. "Magnets"
        })
    end,
}, "Magnets")

local function moveBall(ball)
    if ball and player.Character and shared.Mags then
        local leftArm = player.Character:FindFirstChild("Left Arm")
        if leftArm then
            ball.CanCollide = false
            local startPosition = ball.Position
            local endPosition = leftArm.Position
            local direction = (endPosition - startPosition).Unit
            local distance = (endPosition - startPosition).Magnitude
            local speed = distance / 3000
            local startTime = tick()

            runService:BindToRenderStep("MoveBall", Enum.RenderPriority.Camera.Value + 20, function()
                local elapsedTime = tick() - startTime
                local t = math.min(elapsedTime / speed, 1)
                local newPosition = startPosition + direction * distance * t
                ball.CFrame = CFrame.new(newPosition)
                if t >= 1 then
                    runService:UnbindFromRenderStep("MoveBall")
                    ball.CanCollide = true
                end
            end)
        end
    end
end

local function isWithinRange(football)
    local mag = (player.Character.HumanoidRootPart.Position - football.Position).Magnitude
    return mag <= distance
end

runService.Stepped:Connect(function()
    if shared.Mags then
        local closestBall = nil
        local closestDist = math.huge

        for _, v in ipairs(workspace:GetChildren()) do
            if v.Name == "Football" and v:IsA("BasePart") and isWithinRange(v) then
                local mag = (player.Character.HumanoidRootPart.Position - v.Position).Magnitude
                if mag < closestDist then
                    closestBall = v
                    closestDist = mag
                end
            end
        end

        if closestBall then
            moveBall(closestBall)
        end
    end
end)


local hitboxColor = Color3.fromRGB(255, 0, 0)

local alphaColorPicker = sections.mag3:Colorpicker({
    Name = "Transparency Colorpicker",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = 0,
    Callback = function(color, alpha)
        hitboxColor = color
        if shared.Mags then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Football" and v:IsA("BasePart") then
                    local hitbox = v:FindFirstChild("MagnetHitbox")
                    if hitbox then
                        hitbox.Color = hitboxColor
                    end
                end
            end
        end
    end,
}, "TransparencyColorpicker")



sections.mag1:Toggle({
    Name = "View Mag Hitbox",
    Default = false,
    Callback = function(state)
        magnetsEnabled = state

        Window:Notify({
            Title = Window.Settings.Title,
            Description = (state and "Enabled " or "Disabled ") .. "Mag Hitbox"
        })

        local function createHitbox(target)
            if not target:IsA("BasePart") then return end

            local hitbox = Instance.new("Part")
            hitbox.Shape = Enum.PartType.Ball
            hitbox.Size = hitboxSize
            hitbox.Transparency = 0.05
            hitbox.Anchored = true
            hitbox.CanCollide = false
            hitbox.Material = Enum.Material.ForceField
            hitbox.Name = "MagnetHitbox"
            hitbox.CFrame = target.CFrame
            hitbox.CastShadow = false
            hitbox.Parent = target
            
            hitbox.Color = hitboxColor or Color3.fromRGB(0, 255, 255)

            local function updateHitbox()
                while magnetsEnabled and target and target.Parent do
                    hitbox.Size = hitboxSize
                    hitbox.CFrame = target.CFrame
                    task.wait()
                end
                hitbox:Destroy()
            end

            task.spawn(updateHitbox)
        end

        for _, child in pairs(workspace:GetChildren()) do
            if child.Name == "Football" and child:IsA("BasePart") and magnetsEnabled then
                createHitbox(child)
            end
        end

        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Football" and child:IsA("BasePart") and magnetsEnabled then
                createHitbox(child)
            end
        end)
    end
}, "ViewMagHitbox")

local player = game.Players.LocalPlayer

local function updateArms(size)
    if player.Character:FindFirstChild('Left Arm') and player.Character:FindFirstChild('Right Arm') then
        player.Character['Left Arm'].Size = Vector3.new(size, size * 2, size)
        player.Character['Right Arm'].Size = Vector3.new(size, size * 2, size)
        player.Character['Left Arm'].Transparency = 0.5
        player.Character['Right Arm'].Transparency = 0.5
    end
end

sections.mag1:Slider({
    Name = "Arm Size",
    Default = 2,
    Minimum = 1,
    Maximum = 5,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(value)
        _G.ArmSize = value
        if _G.ArmResizerEnabled then
            updateArms(_G.ArmSize)
        end
    end,
}, "ArmSize")

sections.mag1:Toggle({
    Name = "Arm Resizer",
    Default = false,
    Callback = function(enabled)
        _G.ArmResizerEnabled = enabled
        if enabled then
            updateArms(_G.ArmSize or 2)
        else
            if player.Character:FindFirstChild('Left Arm') and player.Character:FindFirstChild('Right Arm') then
                player.Character['Left Arm'].Size = Vector3.new(1, 2, 1)
                player.Character['Right Arm'].Size = Vector3.new(1, 2, 1)
                player.Character['Left Arm'].Transparency = 0
                player.Character['Right Arm'].Transparency = 0
            end
        end
    end,
}, "ArmResizer")


local Workspace = game:GetService("Workspace")
local distance2 = 3

sections.mag3:Toggle({
    Name = "Ball Resize",
    Default = false,
    Callback = function(enabled)
        _G.BallResize = enabled
        if enabled then
            Workspace.ChildAdded:Connect(function(Child)
                if Child:IsA("BasePart") and Child.Name == "Football" then
                    Child.Size = Vector3.new(distance2, distance2, distance2)
                    Child.CanCollide = false
                end
            end)
        end
    end,
}, "BallResize")

sections.mag3:Slider({
    Name = "Ball Size",
    Default = 3,
    Minimum = 0,
    Maximum = 20,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(value)
        distance = value
        if _G.BallResize then
            for _, v in pairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "Football" then
                    v.Size = Vector3.new(distance, distance, distance)
                    v.CanCollide = false
                end
            end
        end
    end,
}, "BallSize")

sections.physic1:Keybind({
    Name = "Quick TP",
    Blacklist = false,
    Callback = function(binded)
        Window:Notify({
            Title = "Quick TP",
            Description = "Pressed keybind - " .. tostring(binded.Name),
            Lifetime = 3
        })
    end,
    onBinded = function(bind)
        Window:Notify({
            Title = "Quick TP",
            Description = "Successfully Binded Keybind to - " .. tostring(bind.Name),
            Lifetime = 3
        })
    end,
}, "QuickTPBind")

local quickTPCooldown = os.clock()
local tpDistance = 2

userInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode ~= QuickTPBind.Value then return end

    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChild("Humanoid")

    if not quickTP.Value then return end
    if not character or not humanoidRootPart or not humanoid then return end
    if (os.clock() - quickTPCooldown) < 0.1 then return end

    local speed = 2 + (tpDistance / 4)
    humanoidRootPart.CFrame += humanoid.MoveDirection * speed
    quickTPCooldown = os.clock()
end)


sections.physic1:Toggle({
    Name = "Mobile Quick TP",
    Default = false,
    Callback = function(state)
        Toggle = state

        Window:Notify({
            Title = Window.Settings.Title,
            Description = (state and "Enabled " or "Disabled ") .. "Mobile Quick TP"
        })

        if Toggle then
            local userInputService = game:GetService("UserInputService")
            local TweenService = game:GetService("TweenService")

            local ScreenGui = Instance.new("ScreenGui")
            local TextButton = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            local BorderFrame = Instance.new("Frame")
            local BorderUICorner = Instance.new("UICorner")

            ScreenGui.Parent = player:WaitForChild("PlayerGui")
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            BorderFrame.Size = UDim2.new(0, 71, 0, 68)
            BorderFrame.Position = UDim2.new(0.47683534, -3, 0.461152881, -3)
            BorderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BorderFrame.BorderSizePixel = 0
            BorderFrame.Parent = ScreenGui

            BorderUICorner.CornerRadius = UDim.new(0.5, 0)
            BorderUICorner.Parent = BorderFrame

            TextButton.Size = UDim2.new(0, 65, 0, 62)
            TextButton.Position = UDim2.new(0, 3, 0, 3)
            TextButton.BackgroundColor3 = Color3.new(0.0588, 0.0588, 0.0588)
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderSizePixel = 0
            TextButton.Font = Enum.Font.SourceSans
            TextButton.Text = "TP"
            TextButton.TextColor3 = Color3.new(0.8314, 0.8314, 0.8314)
            TextButton.TextSize = 17.000
            TextButton.BackgroundTransparency = 0.76
            TextButton.Parent = BorderFrame

            UICorner.CornerRadius = UDim.new(0.5, 0)
            UICorner.Parent = TextButton

            local function dragify(button)
                local dragging, dragInput, dragStart, startPos

                local function update(input)
                    local delta = input.Position - dragStart
                    button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end

                button.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        dragStart = input.Position
                        startPos = button.Position

                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                            end
                        end)
                    end
                end)

                button.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        dragInput = input
                    end
                end)

                userInputService.InputChanged:Connect(function(input)
                    if dragging and input == dragInput then
                        update(input)
                    end
                end)
            end

            dragify(BorderFrame)

            local function teleportForward()
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = character.HumanoidRootPart
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * tpDistance
                end
            end

            TextButton.MouseButton1Click:Connect(teleportForward)

            local function animateBorder()
                while true do
                    local tween1 = TweenService:Create(BorderFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    local tween2 = TweenService:Create(BorderFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)})

                    tween1:Play()
                    tween1.Completed:Wait()

                    tween2:Play()
                    tween2.Completed:Wait()
                end
            end

            task.spawn(animateBorder)
        end
    end
}, "MobileQuickTP")

sections.physic2:Toggle({
    Name = "Anti Block",
    Default = false,
    Callback = function(state)
        antiblockon = state

        Window:Notify({
            Title = Window.Settings.Title,
            Description = (state and "Enabled " or "Disabled ") .. "Anti Block"
        })
    end,
}, "AntiBlock")

local Torso = player.Character and player.Character:FindFirstChild("Torso")

local function DestroyBlockEvent()
    if antiblockon then
        local ffmover = Torso and Torso:FindFirstChild("FFmover")
        if ffmover then
            ffmover:Destroy()
        end
    end
end

task.spawn(function()
    while task.wait() do
        DestroyBlockEvent()
    end
end)

sections.physic2:Toggle({
    Name = "Anti Jam",
    Default = false,
    Callback = function(state)
        getgenv().AntiJam = state

        Window:Notify({
            Title = Window.Settings.Title,
            Description = (state and "Enabled " or "Disabled ") .. "Anti Jam"
        })

        local function updateCollisionState()
            while getgenv().AntiJam do
                local localPlayer = game:GetService("Players").LocalPlayer
                if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") and localPlayer.Character.Head.CanCollide then
                    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            pcall(function()
                                if player.Character:FindFirstChild("Torso") then
                                    player.Character.Torso.CanCollide = false
                                end
                                player.Character.Head.CanCollide = false
                            end)
                        end
                    end
                end
                task.wait()
            end

            local localPlayer = game:GetService("Players").LocalPlayer
            if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
                if localPlayer.Character:FindFirstChild("Torso") then
                    localPlayer.Character.Torso.CanCollide = true
                end
                localPlayer.Character.Head.CanCollide = true
            end
        end

        if getgenv().AntiJam then
            task.spawn(updateCollisionState)
        end
    end
}, "AntiJam")

local alphaColorPicker = sections.mag3:Colorpicker({
	Name = "Transparency Colorpicker",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		print("Color: ", color, " Alpha: ", alpha)
	end,
}, "TransparencyColorpicker")

local rainbowActive
local rainbowConnection
local hue = 0

sections.mag3:Toggle({
	Name = "Rainbow",
	Default = false,
	Callback = function(value)
		rainbowActive = value

		if rainbowActive then
			rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
				hue = (hue + deltaTime * 0.1) % 1
				alphaColorPicker:SetColor(Color3.fromHSV(hue, 1, 1))
			end)
		elseif rainbowConnection then
			rainbowConnection:Disconnect()
			rainbowConnection = nil
		end
	end,
}, "RainbowToggle")



sections.mag4:Button({
	Name = "Update Selection",
	Callback = function()
		Dropdown:UpdateSelection("Grapes")
		MultiDropdown:UpdateSelection({"Banana", "Pineapple"})
	end,
})

sections.mag2:Divider()




sections.mag3:Label({
	Text = "Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
})

sections.mag4:SubLabel({
	Text = "Sub-Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
})

MacLib:SetFolder("Maclib")
tabs.Settings:InsertConfigSection("Left")

Window.onUnloaded(function()
	print("Unloaded!")
end)

tabs.Main:Select()
MacLib:LoadAutoLoadConfig()
