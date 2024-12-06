if getgenv().volt then
    warn("Script already loaded/is loading or errored.")
    return
end
getgenv().volt = true

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
local mouse = player:GetMouse()

local workspace = game:GetService("Workspace")
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

local practice = game.PlaceId == 8206123457
local solara = string.match(getexecutorname(), "Solara")
local acbypass = practice

local moveToUsing = {}

if not values or practice then
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


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
	Title = "volt.gg 2.0.0",
	Theme = "Dark",
	
	Size = UDim2.fromOffset(620, 430),
	Transparency = 0.2,
	Blurring = true,
	MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

local Themes = {
	Light = {
		--// Frames:
		Primary = Color3.fromRGB(232, 232, 232),
		Secondary = Color3.fromRGB(255, 255, 255),
		Component = Color3.fromRGB(245, 245, 245),
		Interactables = Color3.fromRGB(235, 235, 235),

		--// Text:
		Tab = Color3.fromRGB(50, 50, 50),
		Title = Color3.fromRGB(0, 0, 0),
		Description = Color3.fromRGB(100, 100, 100),

		--// Outlines:
		Shadow = Color3.fromRGB(255, 255, 255),
		Outline = Color3.fromRGB(210, 210, 210),

		--// Image:
		Icon = Color3.fromRGB(100, 100, 100),
	},
	
	Dark = {
		--// Frames:
		Primary = Color3.fromRGB(30, 30, 30),
		Secondary = Color3.fromRGB(35, 35, 35),
		Component = Color3.fromRGB(40, 40, 40),
		Interactables = Color3.fromRGB(45, 45, 45),

		--// Text:
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240,240,240),
		Description = Color3.fromRGB(200,200,200),

		--// Outlines:
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),

		--// Image:
		Icon = Color3.fromRGB(220, 220, 220),
	},
	
	Void = {
		--// Frames:
		Primary = Color3.fromRGB(15, 15, 15),
		Secondary = Color3.fromRGB(20, 20, 20),
		Component = Color3.fromRGB(25, 25, 25),
		Interactables = Color3.fromRGB(30, 30, 30),

		--// Text:
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240,240,240),
		Description = Color3.fromRGB(200,200,200),

		--// Outlines:
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),

		--// Image:
		Icon = Color3.fromRGB(220, 220, 220),
	},

}

Window:SetTheme(Themes.Dark)

Window:AddTabSection({
	Name = "Game",
	Order = 1,
})

Window:AddTabSection({
	Name = "World",
	Order = 2,
})

Window:AddTabSection({
	Name = "Other",
	Order = 3,
})

local Catching = Window:AddTab({
	Title = "Catching",
	Section = "Game",
	Icon = "rbxassetid://10723405649"
})

local Physics = Window:AddTab({
	Title = "Physics",
	Section = "World",
	Icon = "rbxassetid://10747382750"
})

local QB = Window:AddTab({
	Title = "Quarterback",
	Section = "Game",
	Icon = "rbxassetid://10734898592"
})

local Visuals = Window:AddTab({
	Title = "Visuals",
	Section = "World",
	Icon = "rbxassetid://10723346959"
})


local Defense = Window:AddTab({
	Title = "Defense",
	Section = "Game",
	Icon = "rbxassetid://10734951847"
})

local Automatics = Window:AddTab({
	Title = "Automatics",
	Section = "World",
	Icon = "rbxassetid://10709759764"
})

local Player = Window:AddTab({
	Title = "Player",
	Section = "Other",
	Icon = "rbxassetid://10734920149"
})

local Settings = Window:AddTab({
	Title = "Settings",
	Section = "Other",
	Icon = "rbxassetid://10734950309"
})


local catching = false
local magnetenabled = false
local cdistance = 10
local tdistance = 10
local cdelay = 0
local hitboxSize = Vector3.new(distance, distance, distance)
local hitboxColor = Color3.fromRGB(255, 0, 0)

local function isCharacterSitting(character)
    if character and character:FindFirstChildOfClass("Humanoid") then
        return character.Humanoid.Sit
    end
    return false
end

local function adjustHandSizes(character, distance)
    local catchRight = character:FindFirstChild("CatchRight")
    local catchLeft = character:FindFirstChild("CatchLeft")
    if catchRight and catchLeft then
        local newSize = Vector3.new(distance, distance, distance)
        if catchRight.Size ~= newSize then
            catchRight.Size = newSize
        end
        if catchLeft.Size ~= newSize then
            catchLeft.Size = newSize
        end
    end
end

local function attachBallToHand(hand, ball)
    if hand and ball then
        ball.CFrame = hand.CFrame
    end
end

local function waitForChildOfClass(parent, className, timeout)
    timeout = timeout or TIMEOUT
    local startTime = tick()
    while tick() - startTime < timeout do
        local child = parent:FindFirstChildOfClass(className)
        if child then
            return child
        end
        task.wait()
    end
    return nil
end

local function findNearestBall(character)
    local nearestBall = nil
    local nearestDistance = cdistance

    for _, child in pairs(workspace:GetChildren()) do
        if child.Name == "Football" then
            local distance = (child.Position - character.HumanoidRootPart.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestBall = child
            end
        end
    end

    return nearestBall
end

local function startMagnet(reach)
    magnetenabled = true
    catching = true
    tdistance = reach

    runService.Heartbeat:Connect(function()
        if not catching then return end

        local character = player.Character
        if character and not isCharacterSitting(character) then
            local nearestBall = findNearestBall(character)
            if nearestBall then
                adjustHandSizes(character, tdistance)
                attachBallToHand(character:FindFirstChild("CatchRight"), nearestBall)
                attachBallToHand(character:FindFirstChild("CatchLeft"), nearestBall)
            end
        end
    end)
end

local function stopMagnet()
    magnetenabled = false
    catching = false

    local character = player.Character
    if character and character:FindFirstChild("CatchRight") and character:FindFirstChild("CatchLeft") then
        character.CatchRight.Size = Vector3.new(1, 1, 1)
        character.CatchLeft.Size = Vector3.new(1, 1, 1)
    end
end

mouse.Button1Down:Connect(function()
    if not magnetenabled then return end

    local character = player.Character
    if character and not isCharacterSitting(character) then
        local nearestBall = findNearestBall(character)
        if nearestBall and waitForChildOfClass(nearestBall, "TouchTransmitter", timeout) then
            adjustHandSizes(character, tdistance)

            task.wait(cdelay)
            attachBallToHand(character:FindFirstChild("CatchRight"), nearestBall)
            attachBallToHand(character:FindFirstChild("CatchLeft"), nearestBall)
        end
        catching = false
    end
end)

Window:AddToggle({
    Title = "Magnets",
    Description = "Extends the football catch distance.",
    Tab = Catching,
    Callback = function(value)
        magnetenabled = value
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (value and "Enabled Magnets" or "Disabled Magnets"),
            Duration = 5
        })
        if value then
            startMagnet(distance)
        else
            stopMagnet()
        end
    end
})

Window:AddSlider({
    Title = "Magnet Distance",
    Description = "Set the distance of the magnets.",
    Tab = Catching,
    AllowDecimals = true,
    MaxValue = 25,
    Callback = function(value) 
        hitboxSize = Vector3.new(value, value, value)
        if magnetenabled then
            tdistance = value
        end
    end
})


Window:AddToggle({
    Title = "Magnet Hitbox",
    Description = "Toggle the magnet hitbox.",
    Tab = Catching,
    Callback = function(value)
        magnetsEnabled = value
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (value and "Enabled Magnet Hitbox" or "Disabled Magnet Hitbox"),
            Duration = 5
        })
        
        if value then
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
    end
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
    
    hitbox.Color = Color3.fromRGB(0, 255, 255)

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


local armSizeFactor = 1
local armsResized = false

local function adjustArmSize(part, factor)
    local originalSize = part.Size
    local newSize = Vector3.new(originalSize.X, originalSize.Y * factor, originalSize.Z)

    local motor6D = part:FindFirstChildWhichIsA("Motor6D")
    if motor6D then
        local originalC0 = motor6D.C0
        motor6D.C0 = CFrame.new(originalC0.X, newSize.Y / 2, originalC0.Z)
    end

    part.Size = newSize
end

local function resizeArms(enabled, factor)
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    if not character then return end

    local leftArm = character:FindFirstChild("LeftUpperArm") or character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("RightUpperArm") or character:FindFirstChild("Right Arm")

    if leftArm then
        adjustArmSize(leftArm, enabled and factor or 1)
    end
    if rightArm then
        adjustArmSize(rightArm, enabled and factor or 1)
    end

    armsResized = enabled
end

Window:AddToggle({
    Title = "Arm Resizer",
    Description = "Enable or disable arm resizing",
    Tab = Main,
    Callback = function(state)
        resizeArms(state, armSizeFactor)
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled Arm Resizer" or "Disabled Arm Resizer"),
            Duration = 5
        })
    end,
})

Window:AddSlider({
    Title = "Arm Size",
    Description = "Set the size of the arms",
    Tab = Main,
    AllowDecimals = true,
    MaxValue = 20,
    Callback = function(value)
        armSizeFactor = value
        if armsResized then
            resizeArms(true, armSizeFactor)
        end
    end,
})


local Workspace = game:GetService("Workspace")
local distance2 = 3

Window:AddToggle({
    Title = "Ball Resize",
    Description = "Resizes the football.",
    Tab = Catching,
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
        Window:Notify({
            Title = "volt.gg",
            Description = (enabled and "Enabled Ball Resize" or "Disabled Ball Resize"),
            Duration = 5
        })
    end
})


Window:AddSlider({
    Title = "Ball Size",
    Description = "Set the size of the footballs.",
    Tab = Catching,
    AllowDecimals = true,
    MaxValue = 20,
    Callback = function(value)
        distance2 = value
        if _G.BallResize then
            for _, v in pairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "Football" then
                    v.Size = Vector3.new(distance2, distance2, distance2)
                    v.CanCollide = false
                end
            end
        end
    end
})

local tpdistance = 2
local quickTPCooldown = os.clock()

local function createMobileQuickTPButton()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(120, 60)
    button.Position = UDim2.new(0.5, -60, 0.9, -30)
    button.Text = "teleport"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 255, 255)
    button.TextStrokeTransparency = 0.8
    button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 24
    button.AutoButtonColor = false
    button.Visible = false
    button.Parent = screenGui
    
    return button
end

local MobileQuickTPButton = createMobileQuickTPButton()

local function tpforward()
    if not character or not humanoidRootPart or not humanoid then return end
    if (os.clock() - quickTPCooldown) < 0.1 then return end

    local camera = workspace.CurrentCamera
    local lookVector = camera.CFrame.LookVector
    local speed = 2 + (tpdistance / 4)
    humanoidRootPart.CFrame = humanoidRootPart.CFrame + lookVector * speed
    quickTPCooldown = os.clock()
end


MobileQuickTPButton.MouseButton1Click:Connect(tpforward)

local boundaries = {}

if not practice then
    for index, part in pairs(workspace.Models.Boundaries:GetChildren()) do
        boundaries[#boundaries + 1] = part
    end
end

local function adjustHeads(scaleValue, transparencyValue, thinValue)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
            local head = v.Character.Head
            head.Size = Vector3.new(thinValue, scaleValue, thinValue)
            head.Transparency = transparencyValue
            if head:FindFirstChild("Mesh") then
                head.Mesh.Scale = Vector3.new(thinValue, scaleValue, thinValue)
            end
        end
    end
end


Window:AddSlider({
    Title = "Magnet Delay",
    Description = "Set the delay for magnet activation",
    Tab = Catching,
    AllowDecimals = true,
    MaxValue = 5,
    Callback = function(value)
        cdelay = value
    end,
})

Window:AddKeybind({
    Title = "Quick TP Keybind",
    Description = "Teleports you quickly to where your camera is looking at.",
    Tab = Physics,
    Callback = function(Key)
        tpforward()
    end,
})

Window:AddToggle({
    Title = "Mobile Quick TP",
    Description = "Enable or disable mobile quick teleport",
    Tab = Physics,
    Callback = function(state)
        MobileQuickTPButton.Visible = state
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Mobile Quick TP",
            Duration = 3
        })
    end,
})

Window:AddSlider({
    Title = "Quick TP Distance",
    Description = "Set the distance for quick teleport",
    Tab = Physics,
    AllowDecimals = true,
    MaxValue = 5,
    Callback = function(value)
        tpdistance = value
    end,
})

Window:AddToggle({
    Title = "Anti Block",
    Description = "Enable or disable anti block",
    Tab = Physics,
    Callback = function(state)
        antiblockon = state
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Anti Block",
            Duration = 3
        })
    end,
})

Window:AddToggle({
    Title = "Anti Jam",
    Description = "Enable or disable anti jam",
    Tab = Physics,
    Callback = function(state)
        getgenv().AntiJam = state
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Anti Jam",
            Duration = 3
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
    end,
})

Window:AddToggle({
    Title = "Anti Out of Bounds",
    Description = "Enable or disable anti out of bounds protection",
    Tab = Physics,
    Callback = function(state)
        antiOOB.Value = state
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Anti Out of Bounds",
            Duration = 3
        })

        for index, boundary in pairs(boundaries) do
            boundary.Parent = not state and workspace.Models.Boundaries or nil
        end
    end,
})

Window:AddToggle({
    Title = "Enable Head Adjustments",
    Description = "Enable or disable head adjustments",
    Tab = Physics,
    Callback = function(state)
        AdjustHeadsEnabled = state
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Head Adjustments",
            Duration = 3
        })

        if state then
            adjustHeads(HeadScale, HeadTransparency, HeadThinness)
        end
    end,
})

Window:AddSlider({
    Title = "Head Scale",
    Description = "Adjust the scale of heads",
    Tab = Physics,
    AllowDecimals = true,
    MaxValue = 5,
    Callback = function(value)
        HeadScale = value
        if AdjustHeadsEnabled then
            adjustHeads(HeadScale, HeadTransparency, HeadThinness)
        end
    end,
})

Window:AddSlider({
    Title = "Head Transparency",
    Description = "Set the transparency level of heads",
    Tab = Physics,
    AllowDecimals = true,
    MaxValue = 1,
    Callback = function(value)
        HeadTransparency = value
        if AdjustHeadsEnabled then
            adjustHeads(HeadScale, HeadTransparency, HeadThinness)
        end
    end,
})

Window:AddSlider({
    Title = "Head Thinness",
    Description = "Adjust the thinness of heads",
    Tab = Physics,
    AllowDecimals = true,
    MaxValue = 10,
    Callback = function(value)
        HeadThinness = value
        if AdjustHeadsEnabled then
            adjustHeads(HeadScale, HeadTransparency, HeadThinness)
        end
    end,
})


local a = false
local b = false
local c = false
local e = true
local f = 3
local g = 0
local h = game:GetService("Players")
local i = game:GetService("Debris")
local j = game:GetService("UserInputService")
local k = h.LocalPlayer
local l = k:GetMouse()
local l = workspace.CurrentCamera
local l = false
local m = nil
local n = Instance.new("Hint", workspace)
n.Parent = nil
local o = "Dive"
local p = ""
local p = Instance.new("Folder")
p.Parent = workspace
local q = { Angle = 45, Direction = Vector3.new(0, 0, 0), Power = 0 }
local r = { "flat", "in/out", "stationary", "curl/comeback" }
local s = { "slant", "post/corner" }
local t = {
    ["Dot"] = {
        xLead = function(t)
            return 3 + (math.max(t - 25, 0) / 50)
        end,
        routes = { ["go"] = { xzOffset = 0, yOffset = 0 }, ["post/corner"] = { xzOffset = 0, yOffset = 0 }, ["slant"] = { xzOffset = 0, yOffset = 0 }, ["in/out"] = { xzOffset = 0, yOffset = 0 }, ["flat"] = { xzOffset = -2.3, yOffset = 0 }, ["curl/comeback"] = { xzOffset = -6, yOffset = 0 }, ["stationary"] = { xzOffset = 0, yOffset = 0 } }
    },
    ["Jump"] = {
        xLead = function(t, u)
            local v = 11.2 + (t / 55)
            if b and table.find(s, u) and t > 175 then
                v += 0.3
            end
            return v
        end,
        routes = { ["go"] = { xzOffset = 0, yOffset = 0 }, ["post/corner"] = { xzOffset = -1, yOffset = 0 }, ["slant"] = { xzOffset = -1, yOffset = 0 }, ["in/out"] = { xzOffset = 0, yOffset = 0 }, ["flat"] = { xzOffset = 0, yOffset = 0 }, ["curl/comeback"] = { xzOffset = -12.5, yOffset = 0 }, ["stationary"] = { xzOffset = 0, yOffset = 0 } }
    },
    ["Bullet"] = {
        xLead = function(t)
            local u = 22
            local v = q.Angle
            local w = (t / 100) ^ 1.4
            if v > 45 then
                local x = (v - 50) / 20
                w = t / (75 - (x * 5))
            end
            u += w
            u += math.max(v - 45, -5) / 5
            if v < 40 then
                u *= 1 - ((45 - v) / 100)
            end
            return u
        end,
        routes = { ["go"] = { xzOffset = 0, yOffset = 0 }, ["post/corner"] = { xzOffset = 0, yOffset = 0 }, ["slant"] = { xzOffset = 0, yOffset = 0 }, ["in/out"] = { xzOffset = 0, yOffset = 0 }, ["flat"] = { xzOffset = -2.3, yOffset = 0 }, ["curl/comeback"] = { xzOffset = -6, yOffset = 0 }, ["stationary"] = { xzOffset = 0, yOffset = 0 } }
    },
    ["Dive"] = {
        xLead = function(t, u)
            local v = 20
            local w = q.Angle
            local x = (t / 100) ^ 1.5
            if w > 45 then
                local y = (w - 50) / 20
                x = t / (75 - (y * 5))
            end
            if b then
                v += k.Character.Humanoid.FloorMaterial == Enum.Material.Air and 7 or 3
            end
            if table.find(s, u) then
                v -= 7 + (t / 37)
            end
            v += x
            v += math.max(w - 45, -5) / 5
            if w < 40 then
                v *= 1 - ((45 - w) / 100)
            end
            return v
        end,
        routes = { ["go"] = { xzOffset = 0, yOffset = 0 }, ["post/corner"] = { xzOffset = -0.3, yOffset = 0 }, ["slant"] = { xzOffset = -0.3, yOffset = 0 }, ["in/out"] = { xzOffset = 0, yOffset = 0 }, ["flat"] = { xzOffset = 0, yOffset = 0 }, ["curl/comeback"] = { xzOffset = -6, yOffset = 0 }, ["stationary"] = { xzOffset = 0, yOffset = 0 } }
    },
    ["Mag"] = {
        xLead = function(t, u)
            local v = 21
            local w = q.Angle
            local x = (t / 100) ^ 1.4
            if w > 45 then
                local y = (w - 50) / 20
                x = t / (75 - (y * 5))
            end
            if b then
                v += k.Character.Humanoid.FloorMaterial == Enum.Material.Air and 7 or 3
            end
            if table.find(s, u) then
                v -= 7 + (t / 37)
            end
            v += x
            v += math.max(w - 45, -5) / 5
            if w < 40 then
                v *= 1 - ((45 - w) / 100)
            end
            return v
        end,
        routes = { ["go"] = { xzOffset = 0, yOffset = 0 }, ["post/corner"] = { xzOffset = -0.3, yOffset = 0 }, ["slant"] = { xzOffset = -0.3, yOffset = 0 }, ["in/out"] = { xzOffset = 0, yOffset = 0 }, ["flat"] = { xzOffset = 0, yOffset = 0 }, ["curl/comeback"] = { xzOffset = -6, yOffset = 0 }, ["stationary"] = { xzOffset = 0, yOffset = 0 } }
    },
}
local u = { ["Dive"] = "Mag", ["Mag"] = "Jump", ["Jump"] = "Dot", ["Dot"] = "Bullet", ["Bullet"] = "Dive" }
local v = Instance.new("Beam");
v.Parent = workspace.Terrain
local w, x = Instance.new("Attachment"), Instance.new("Attachment");
w.Parent = workspace.Terrain;
x.Parent = workspace.Terrain
v.Width0 = 0.5
v.Width1 = 0.5
v.Transparency = NumberSequence.new(0)
v.Color = ColorSequence.new(Color3.fromRGB(173, 173, 173))
v.Attachment0 = w
v.Segments = 3000
v.Attachment1 = x
local y = Instance.new("Highlight")
y.FillColor = Color3.fromRGB(173, 173, 173)
local z = game.PlaceId == 8206123457
local ba = Instance.new("Part")
ba.CanCollide = false
ba.Anchored = true
ba.Transparency = 1
ba.Position = z and Vector3.new(245, 40.55, 0) or Vector3.new(0, 40.55, 0)
ba.Size = Vector3.new(161, 75, 360)
ba.Parent = workspace
local bb = game:GetObjects("rbxassetid://17334970363")[1]:Clone()
bb.Parent = gethui()
function roundMoveDirection(bc)
    return Vector3.new(math.round(bc.X), math.round(bc.Y), math.round(bc.Z))
end
function clamp_oobPosition(bc)
    ba.Size = Vector3.new(161 + (f * 2), 75, 360 + (f * 2))
    return c and Vector3.new(math.clamp(bc.X, -ba.Size.X / 2 + ba.Position.X, ba.Size.X / 2 + ba.Position.X), math.clamp(bc.Y, -ba.Size.Y / 2, ba.Size.Y / 2), math.clamp(bc.Z, -ba.Size.Z / 2 + ba.Position.Z, ba.Size.Z / 2 + ba.Position.Z)) or bc
end
function calc_TimeToPeak(ba, bc, bd)
    local be = Vector3.new(0, -28, 0)
    local bf = 4
    local bd = bd * bf
    local be = 0.5 * be.Y
    local bc = bc.Y - ba.Y
    local ba = bd - ba.Y
    local ba = bc * bc - 4 * be * ba
    if ba < 0 then
        return nil
    end
    local bd = (-bc + math.sqrt(ba)) / (2 * be)
    local ba = (-bc - math.sqrt(ba)) / (2 * be)
    local ba = math.max(bd, ba)
    return ba
end
function calc_Vel(ba, bc, bd)
    local be = Vector3.new(0, -28, 0)
    local bc = (bc - ba - 0.5 * be * bd * bd) / bd;
    local ba = ((ba + bc) - ba).Unit
    local bd = bc.Y / ba.Y
    return bc, ba, math.clamp(math.round(bd), 0, 95)
end
function proj_angle(ba, bc, bd, be)
    local bd = bd / 90 / 1.9
    local bf = (ba - bc).Magnitude
    local bd = bd * bf
    local bd = calc_TimeToPeak(ba, bc, bd + be)
    local be = (ba - bc).Magnitude / 95
    local ba = calc_Vel(ba, bc, math.max(bd, be))
    return ba, math.max(bd, be)
end
function predVel_ToCharacter(ba, bc, bd, be, bf, bg, bh)
    bg = bg or Vector3.zero
    local bi = bd / 90 / 1.9
    local bj = (ba - bc.HumanoidRootPart.Position).Magnitude
    local bi = bi * bj
    local bj = h:GetPlayerFromCharacter(bc)
    local bk = (ba - bc.HumanoidRootPart.Position).Magnitude / 95
    local bi = math.max(calc_TimeToPeak(ba, bc.HumanoidRootPart.Position, bi + be), bk)
    local bj = bj and bc.Humanoid.MoveDirection or (bc.Humanoid.WalkToPoint - bc.HumanoidRootPart.Position).Unit
    if bh == "go" then
        local bh = bc.HumanoidRootPart.Position + (bj * 16)
        local bh = (k.Character.HumanoidRootPart.Position - bh).Unit
        local bk = (k.Character.HumanoidRootPart.Position - bc.HumanoidRootPart.Position).Unit
        local bl = Instance.new("Hint")
        bl.Text = (bh - bk).Magnitude
        bl.Parent = workspace
        i:AddItem(bl, 0.1)
    end
    local bc = clamp_oobPosition(bc.HumanoidRootPart.Position + bg + (bj * 16 * bi) + (bj * (2 + be)))
    local ba = proj_angle(ba, bc, bd, bf)
    return ba, bi
end
function beamProjectile(ba, bc, bd, be)
    local bf = 0.125;
    local bg = 0.5 * ba * be * be + bc * be + bd;
    local bh = bg - (ba * be * be + bc * be) / 3;
    local ba = (bf * ba * be * be + 0.5 * bc * be + bd - bf * (bd + bg)) / (3 * bf) - bh;
    local bc = (ba - bd).Magnitude;
    local be = (bh - bg).Magnitude;
    local bf = (bd - bg).Unit;
    local ba = (ba - bd).Unit;
    local bi = ba:Cross(bf).Unit;
    local bh = (bh - bg).Unit;
    local bj = bh:Cross(bf).Unit;
    bf = bi:Cross(ba).Unit;
    local ba = CFrame.new(bd.x, bd.y, bd.z, ba.x, bi.x, bf.x, ba.y, bi.y, bf.y, ba.z, bi.z, bf.z)
    local bd = CFrame.new(bg.x, bg.y, bg.z, bh.x, bj.x, bf.x, bh.y, bj.y, bf.y, bh.z, bj.z, bf.z)
    return bc, -be, ba, bd;
end
function findRoute(ba)
    local bc = h:GetPlayerFromCharacter(ba)
    local bc = bc and ba.Humanoid.MoveDirection or (ba.Humanoid.WalkToPoint - ba.HumanoidRootPart.Position).Unit
    local bd = (ba.HumanoidRootPart.Position - k.Character.HumanoidRootPart.Position).Magnitude
    local function be()
        local bf = Vector3.new(math.abs(bc.X), 0, math.abs(bc.Z))
        local bf = (bf - Vector3.new(0.7, 0, 0.7)).Magnitude
        return bf < 0.5
    end
    local function bf()
        local bg = (ba.HumanoidRootPart.Position - k.Character.HumanoidRootPart.Position).Unit
        local bg = math.abs(bg.X) > math.abs(bg.Z) and "Z" or "X"
        return math.abs(bc[bg]) > 0.8
    end
    local function bg()
        local ba = ((ba.HumanoidRootPart.Position + (bc * 16)) - k.Character.HumanoidRootPart.Position).Magnitude
        return (bd - ba) > 12
    end
    local ba = {
        ["go"] = function()
            return not be() and not bg()
        end,
        ["post/corner"] = function()
            return be() and not bg() and bd > 125
        end,
        ["slant"] = function()
            return be() and not bg() and bd <= 125
        end,
        ["in/out"] = function()
            return bf() and bd > 125
        end,
        ["flat"] = function()
            return bf() and bd <= 125
        end,
        ["curl/comeback"] = function()
            return bg()
        end,
        ["stationary"] = function()
            return bc.Magnitude <= 0
        end,
    }
    local bd = nil
    for be, bf in pairs(ba) do
        bd = bf() and be or bd
        if bd then
            break
        end
    end
    n.Text = bd
    return bd, bc
end
local function ba()
    local bc = workspace.CurrentCamera
    local bd = nil
    local be = math.huge
    for bf, bf in pairs(h:GetPlayers()) do
        if bf.Name ~= k.Name then
            if bf.Character and bf.Character:FindFirstChild("Humanoid") and bf.Character.Humanoid.Health ~= 0 and bf.Character:FindFirstChild("HumanoidRootPart") and bf.Team == k.Team then
                local h, bc = bc:WorldToViewportPoint(bf.Character.HumanoidRootPart.Position)
                local h = (Vector2.new(j:GetMouseLocation().X, j:GetMouseLocation().Y) - Vector2.new(h.X, h.Y)).magnitude
                if h < be then
                    bd = bf.Character
                    be = h
                end
            end
        end
    end
    return bd
end
p.ChildAdded:Connect(function(h)
    i:AddItem(h, 3)
end)
local h = {
    [Enum.KeyCode.R] = function()
        q.Angle = math.clamp(q.Angle + 5, 5, 70)
    end,
    [Enum.KeyCode.F] = function()
        q.Angle = math.clamp(q.Angle - 5, 5, 70)
    end,
    [Enum.KeyCode.Q] = function()
        l = not l
    end,
    [Enum.KeyCode.Z] = function()
        o = u[o]
    end,
}
j.InputBegan:Connect(function(i, j)
    if j then
        return
    end;
    (h[i.KeyCode] or function()
    end)()
end)
local h;
h = hookmetamethod(game, "__namecall", function(i, ...)
    local j = getnamecallmethod()
    local j = { ... }
    if j[1] == "Clicked" and a then
        local j = { "Clicked", k.Character.Head.Position, k.Character.Head.Position + q.Direction * 10000, (z and q.Power) or 95, q.Power }
        if e then
            local u = k.Character.Head.Position
            local z = q.Direction * q.Power
            local p = Instance.new("Part", p)
            p.Size = Vector3.new(1, 1, 100)
            p.Anchored = true
            p.CanCollide = false
            p.CFrame = CFrame.lookAt(u, u + z)
            p.Transparency = 0.5
            p.Color = Color3.fromRGB(0, 0, 255)
            print(z.Magnitude, p.Orientation.X, q.Angle)
        end
        return h(i, unpack(j))
    end
    return h(i, ...)
end)
task.spawn(function()
    while true do
        task.wait()
        local h, i = pcall(function()
            m = l and m or ba()
            y.OutlineColor = l and Color3.fromRGB(173, 173, 173) or Color3.fromRGB(255, 255, 255)
            y.FillColor = l and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(173, 173, 173)
            n.Parent = e and workspace or nil
            if m and k.PlayerGui:FindFirstChild("BallGui") and a then
                local h, i = findRoute(m)
                local i = (k.Character.HumanoidRootPart.Position - m.HumanoidRootPart.Position).Magnitude
                q.Angle = (b or o == "Bullet") and (((k.Character.Humanoid.FloorMaterial == Enum.Material.Air and i * 1.1 or i) / 8) ^ 1.01) or q.Angle
                if table.find(r, h) and (b or o == "Bullet") then
                    q.Angle = i > 135 and math.max((6 + (i / 75)) ^ 1.3, 10) or 10
                    if o == "Jump" then
                        q.Angle = math.max((q.Angle / 1.7) ^ 1.13, 5)
                        if h == "stationary" then
                            q.Angle = math.max(q.Angle / 1.3, 5)
                        end
                    end
                end
                if (not b and o ~= "Bullet") and (q.Angle % 5 ~= 0) then
                    q.Angle = 45
                end
                local j = t[(((b or o == "Bullet") and table.find(r, h) and "Dot") or (o == "Bullet" and "Dive") or o)].xLead(i, h) + t[((b or o == "Bullet") and table.find(r, h) and "Dot" or o)].routes[h].xzOffset + ((b and not table.find(r, h)) and 10 - (i / 100) or 0)
                j += g
                if o == "Jump" and table.find(s, h) and b then
                    j -= 10
                end
                if o == "Jump" and table.find(r, h) and b and k.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                    j += 2
                end
                local l, p = predVel_ToCharacter(k.Character.Head.Position, m, q.Angle, j, 0, (o == "Jump" and table.find(r, h) and Vector3.new(0, 7, 0)) or (o == "Mag" and Vector3.new(0, 2 - (math.max(i - 100, 0) / 50), 0)), h)
                n.Text = h .. " " .. j .. " " .. i
                local h = math.min(math.round(l.Magnitude), 95)
                local i = l.Unit
                local j, l, n, r = beamProjectile(Vector3.new(0, -28, 0), i * h, k.Character.Head.Position + i * 5, p * 1.5)
                v.CurveSize0 = j
                v.CurveSize1 = l
                v.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                w.CFrame = w.Parent.CFrame:Inverse() * n
                x.CFrame = x.Parent.CFrame:Inverse() * r
                y.Parent = m
                y.Adornee = m
                q.Power = h
                q.Direction = i
                bb.Frame.Airtime.Value.Text = (math.round(p * 100) / 100) .. "s"
                bb.Frame.Angle.Value.Text = math.round(q.Angle * 10) / 10
                bb.Frame.Mode.Value.Text = o
                bb.Frame.Power.Value.Text = h
                bb.Frame.Target.Value.Text = m.Name
            end
            v.Enabled = k.PlayerGui:FindFirstChild("BallGui") and a
            y.Enabled = k.PlayerGui:FindFirstChild("BallGui") and a
            bb.Enabled = k.PlayerGui:FindFirstChild("BallGui") and a
        end);
        ((not h and e) and warn or function()
        end)(i)
    end
end)

Window:AddToggle({
    Title = "QB Aimbot",
    Description = "Enable or disable the QB aimbot",
    Tab = Quarterback,
    Callback = function(state)
        if state then
            a = e
        else
            a = nil
        end
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " QB Aimbot",
            Duration = 3
        })
    end,
})

Window:AddSlider({
    Title = "Lead Distance",
    Description = "Adjust the lead distance for QB aimbot",
    Tab = Quarterback,
    AllowDecimals = true,
    MaxValue = 10,
    Callback = function(value)
        g = value
    end,
})

Window:AddToggle({
    Title = "Anti Out of Bounds",
    Description = "Enable or disable anti out of bounds protection",
    Tab = Quarterback,
    Callback = function(state)
        if state then
            c = a
        else
            c = nil
        end
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Anti Out of Bounds",
            Duration = 3
        })
    end,
})

Window:AddSlider({
    Title = "Anti OOB Threshold",
    Description = "Set the threshold for anti out of bounds",
    Tab = Quarterback,
    AllowDecimals = true,
    MaxValue = 10,
    Callback = function(value)
        f = value
    end,
})

Window:AddToggle({
    Title = "Beam/High Power Mode",
    Description = "Enable or disable beam/high power mode",
    Tab = Quarterback,
    Callback = function(state)
        if state then
            if a then
                b = e
            end
        else
            b = nil
        end
        Window:Notify({
            Title = "volt.gg 2.0.0",
            Description = (state and "Enabled" or "Disabled") .. " Beam/High Power Mode",
            Duration = 3
        })
    end,
})

local Keybind = nil

Window:AddKeybind({
	Title = "Minimize Keybind",
	Description = "Set the keybind for Minimizing the UI",
	Tab = Settings,
	Callback = function(Key) 
		Window:SetSetting("Keybind", Key)
	end,
}) 

Window:AddDropdown({
	Title = "Set Theme",
	Description = "Set the theme of the library!",
	Tab = Settings,
	Options = {
		["Light Mode"] = "Light",
		["Dark Mode"] = "Dark",
		["Extra Dark"] = "Void",
	},
	Callback = function(Theme) 
		Window:SetTheme(Themes[Theme])
	end,
}) 

Window:AddToggle({
	Title = "UI Blur",
	Description = "If enabled, must have your Roblox graphics set to 8+ for it to work.",
	Default = true,
	Tab = Settings,
	Callback = function(Boolean) 
		Window:SetSetting("Blur", Boolean)
	end,
}) 


Window:AddSlider({
	Title = "UI Transparency",
	Description = "Set the transparency of the UI.",
	Tab = Settings,
	AllowDecimals = true,
	MaxValue = 1,
	Callback = function(Amount) 
		Window:SetSetting("Transparency", Amount)
	end,
}) 
