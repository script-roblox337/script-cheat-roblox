--===[ ESP + AIM GUI v1 made by jtiydoyxll  ]===--
-- Place as LocalScript in StarterPlayerScripts or StarterGui
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- ====== Config ======
local config = {
    aimbotEnabled = false,
    fovPixels = 60,
    maxDistanceStuds = 400,
    maxTransparency = 0.1,
    teamCheck = false,
    wallCheck = false,
    aimPart = "Head", -- "Torso"
}

-- ====== GUI setup (styled like your example) ======
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESP_Aim_GUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,180,0,290)
MainFrame.Position = UDim2.new(0.05,0,0.2,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,-40,0,30)
Title.Position = UDim2.new(0,10,0,5)
Title.Text = "⚙ ESP / Aimbot"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-35,0,5)
MinBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextScaled = true
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1,0)

local BodyFrame = Instance.new("Frame", MainFrame)
BodyFrame.Size = UDim2.new(1,0,1,-40)
BodyFrame.Position = UDim2.new(0,0,0,40)
BodyFrame.BackgroundTransparency = 1

-- === Buttons / Controls ===
local ESPBtn = Instance.new("TextButton", BodyFrame)
ESPBtn.Size = UDim2.new(0.8,0,0,40)
ESPBtn.Position = UDim2.new(0.1,0,0,0)
ESPBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
ESPBtn.Text = "ESP"
ESPBtn.TextColor3 = Color3.fromRGB(255,255,255)
ESPBtn.Font = Enum.Font.SourceSansBold
ESPBtn.TextScaled = true
Instance.new("UICorner", ESPBtn).CornerRadius = UDim.new(1,0)

local AimbotBtn = Instance.new("TextButton", BodyFrame)
AimbotBtn.Size = UDim2.new(0.8,0,0,40)
AimbotBtn.Position = UDim2.new(0.1,0,0,50)
AimbotBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
AimbotBtn.Text = "Aimbot"
AimbotBtn.TextColor3 = Color3.fromRGB(255,255,255)
AimbotBtn.Font = Enum.Font.SourceSansBold
AimbotBtn.TextScaled = true
Instance.new("UICorner", AimbotBtn).CornerRadius = UDim.new(1,0)

-- Small settings area (FOV, AimPart, Team/Wall toggles)
local LabelFOV = Instance.new("TextLabel", BodyFrame)
LabelFOV.Size = UDim2.new(0.6,0,0,20)
LabelFOV.Position = UDim2.new(0.1,0,0,105)
LabelFOV.BackgroundTransparency = 1
LabelFOV.Text = "FOV (px):"
LabelFOV.TextColor3 = Color3.fromRGB(255,255,255)
LabelFOV.Font = Enum.Font.SourceSans
LabelFOV.TextScaled = true
LabelFOV.TextXAlignment = Enum.TextXAlignment.Left

local FOVBox = Instance.new("TextBox", BodyFrame)
FOVBox.Size = UDim2.new(0.3,0,0,22)
FOVBox.Position = UDim2.new(0.55,0,0,103)
FOVBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
FOVBox.Text = tostring(config.fovPixels)
FOVBox.TextColor3 = Color3.fromRGB(255,255,255)
FOVBox.Font = Enum.Font.SourceSans
FOVBox.TextScaled = true
Instance.new("UICorner", FOVBox).CornerRadius = UDim.new(1,0)

local LabelAimPart = Instance.new("TextLabel", BodyFrame)
LabelAimPart.Size = UDim2.new(0.9,0,0,20)
LabelAimPart.Position = UDim2.new(0.05,0,0,135)
LabelAimPart.BackgroundTransparency = 1
LabelAimPart.Text = "Aim Part (Head/Torso):"
LabelAimPart.TextColor3 = Color3.fromRGB(255,255,255)
LabelAimPart.Font = Enum.Font.SourceSans
LabelAimPart.TextScaled = true
LabelAimPart.TextXAlignment = Enum.TextXAlignment.Left

local AimPartBox = Instance.new("TextBox", BodyFrame)
AimPartBox.Size = UDim2.new(0.9,0,0,22)
AimPartBox.Position = UDim2.new(0.05,0,0,155)
AimPartBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
AimPartBox.Text = tostring(config.aimPart)
AimPartBox.TextColor3 = Color3.fromRGB(255,255,255)
AimPartBox.Font = Enum.Font.SourceSans
AimPartBox.TextScaled = true
Instance.new("UICorner", AimPartBox).CornerRadius = UDim.new(1,0)

local TeamLabel = Instance.new("TextLabel", BodyFrame)
TeamLabel.Size = UDim2.new(0.5,0,0,20)
TeamLabel.Position = UDim2.new(0.05,0,0,185)
TeamLabel.BackgroundTransparency = 1
TeamLabel.Text = "Team Check"
TeamLabel.TextColor3 = Color3.fromRGB(255,255,255)
TeamLabel.Font = Enum.Font.SourceSans
TeamLabel.TextScaled = true
TeamLabel.TextXAlignment = Enum.TextXAlignment.Left

local TeamToggle = Instance.new("TextButton", BodyFrame)
TeamToggle.Size = UDim2.new(0.3,0,0,20)
TeamToggle.Position = UDim2.new(0.55,0,0,185)
TeamToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
TeamToggle.Text = "OFF"
TeamToggle.TextColor3 = Color3.fromRGB(255,255,255)
TeamToggle.Font = Enum.Font.SourceSansBold
TeamToggle.TextScaled = true
Instance.new("UICorner", TeamToggle).CornerRadius = UDim.new(1,0)

local WallLabel = Instance.new("TextLabel", BodyFrame)
WallLabel.Size = UDim2.new(0.5,0,0,20)
WallLabel.Position = UDim2.new(0.05,0,0,210)
WallLabel.BackgroundTransparency = 1
WallLabel.Text = "Wall Check"
WallLabel.TextColor3 = Color3.fromRGB(255,255,255)
WallLabel.Font = Enum.Font.SourceSans
WallLabel.TextScaled = true
WallLabel.TextXAlignment = Enum.TextXAlignment.Left

local WallToggle = Instance.new("TextButton", BodyFrame)
WallToggle.Size = UDim2.new(0.3,0,0,20)
WallToggle.Position = UDim2.new(0.55,0,0,210)
WallToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
WallToggle.Text = "OFF"
WallToggle.TextColor3 = Color3.fromRGB(255,255,255)
WallToggle.Font = Enum.Font.SourceSansBold
WallToggle.TextScaled = true
Instance.new("UICorner", WallToggle).CornerRadius = UDim.new(1,0)

-- ====== Minimize behavior ======
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        BodyFrame.Visible = false
        MainFrame:TweenSize(UDim2.new(0,180,0,40),"Out","Quad",0.2,true)
        MinBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0,180,0,220),"Out","Quad",0.2,true)
        task.wait(0.2)
        BodyFrame.Visible = true
        MinBtn.Text = "-"
    end
end)

-- ====== FOV Drawing (Drawing API) ======
local DrawingLib = Drawing
local FOVring = DrawingLib.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(128,0,128)
FOVring.Filled = false
FOVring.Radius = config.fovPixels
FOVring.Position = cam.ViewportSize/2
FOVring.Transparency = config.maxTransparency

local function clamp(val, a, b) if val < a then return a end if val > b then return b end return val end
local function updateFOVDrawing()
    FOVring.Position = cam.ViewportSize/2
    FOVring.Radius = config.fovPixels
end

-- ====== ESP Implementation ======
local espEnabled = false
local espObjects = {}

local function clearESP()
    for _,v in pairs(espObjects) do
        if v.box and v.box.Parent then v.box:Destroy() end
        if v.gui and v.gui.Parent then v.gui:Destroy() end
    end
    table.clear(espObjects)
end

local function createESP(plr)
    if plr == player then return end
    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
    if espObjects[plr] then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(4,6,2)
    box.Color3 = Color3.fromRGB(255,0,0)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Adornee = plr.Character.HumanoidRootPart
    box.Parent = game.CoreGui

    local bg = Instance.new("BillboardGui")
    bg.Size = UDim2.new(0,200,0,50)
    bg.AlwaysOnTop = true
    bg.Adornee = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
    local label = Instance.new("TextLabel", bg)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold

    bg.Parent = game.CoreGui
    espObjects[plr] = {box = box, gui = bg, label = label}
end

local function updateESP()
    for plr,data in pairs(espObjects) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            local hp = humanoid and math.floor(humanoid.Health) or 0
            local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local distance = myHrp and math.floor((myHrp.Position - hrp.Position).Magnitude) or 0
            data.label.Text = string.format("%s | HP: %d | %dm", plr.Name, hp, distance)
        else
            if data.box and data.box.Parent then data.box:Destroy() end
            if data.gui and data.gui.Parent then data.gui:Destroy() end
            espObjects[plr] = nil
        end
    end
end

local function toggleESP(state)
    if state then
        espEnabled = true
        for _,p in pairs(Players:GetPlayers()) do createESP(p) end
        Players.PlayerAdded:Connect(function(p) createESP(p) end)
        -- update loop
        RunService.RenderStepped:Connect(function()
            if espEnabled then updateESP() end
        end)
    else
        espEnabled = false
        clearESP()
    end
end

-- ====== Aimbot Implementation ======
-- Utility functions
local function isAlive(plr)
    local char = plr.Character
    return char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0
end

local function isVisibleThroughWalls(plr, trgPartName)
    if not config.wallCheck then return true end
    local localChar = player.Character
    if not localChar then return false end
    local trgPart = plr.Character and plr.Character:FindFirstChild(trgPartName)
    if not trgPart then return false end

    local rayOrigin = cam.CFrame.Position
    local rayDir = (trgPart.Position - rayOrigin)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {localChar}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local res = workspace:Raycast(rayOrigin, rayDir, params)
    if res and res.Instance and res.Instance:IsDescendantOf(plr.Character) then
        return true
    end
    return false
end

local function getClosestPlayerInFOV()
    local nearest = nil
    local bestDistPixels = math.huge
    local center = cam.ViewportSize/2

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and (not config.teamCheck or plr.Team ~= player.Team) and isAlive(plr) and plr.Character then
            local part = plr.Character:FindFirstChild(config.aimPart)
            if part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local distPixels = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    local worldDist = (part.Position - cam.CFrame.Position).Magnitude
                    if distPixels <= config.fovPixels and worldDist <= config.maxDistanceStuds and distPixels < bestDistPixels and isVisibleThroughWalls(plr, config.aimPart) then
                        bestDistPixels = distPixels
                        nearest = plr
                    end
                end
            end
        end
    end

    return nearest, bestDistPixels
end

local FOVconn = nil
local function startAimbot()
    if config.aimbotEnabled then return end
    config.aimbotEnabled = true
    FOVring.Visible = true

    FOVconn = RunService.RenderStepped:Connect(function()
        updateFOVDrawing()
        local target, distPixels = getClosestPlayerInFOV()
        if target and target.Character and target.Character:FindFirstChild(config.aimPart) then
            -- direct lookAt (no smoothing)
            local targetPos = target.Character[config.aimPart].Position
            local lookVector = (targetPos - cam.CFrame.Position).unit
            cam.CFrame = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + lookVector)
        end

        if target and distPixels then
            local t = clamp((1 - (distPixels / config.fovPixels)) * config.maxTransparency, 0, config.maxTransparency)
            FOVring.Transparency = t
        else
            FOVring.Transparency = config.maxTransparency
        end
    end)
end

local function stopAimbot()
    if not config.aimbotEnabled then return end
    config.aimbotEnabled = false
    FOVring.Visible = false
    if FOVconn then FOVconn:Disconnect() FOVconn = nil end
end

-- Toggle (button wiring)
ESPBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ESPBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
        toggleESP(true)
    else
        ESPBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
        toggleESP(false)
    end
end)

AimbotBtn.MouseButton1Click:Connect(function()
    if config.aimbotEnabled then
        stopAimbot()
        AimbotBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
        AimbotBtn.Text = "Aimbot"
    else
        startAimbot()
        AimbotBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
        AimbotBtn.Text = "Aimbot: ON"
    end
end)

-- Toggle team/wall
TeamToggle.MouseButton1Click:Connect(function()
    config.teamCheck = not config.teamCheck
    TeamToggle.Text = config.teamCheck and "ON" or "OFF"
    TeamToggle.BackgroundColor3 = config.teamCheck and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)

WallToggle.MouseButton1Click:Connect(function()
    config.wallCheck = not config.wallCheck
    WallToggle.Text = config.wallCheck and "ON" or "OFF"
    WallToggle.BackgroundColor3 = config.wallCheck and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)

-- FOV box update
FOVBox.FocusLost:Connect(function(enter)
    local n = tonumber(FOVBox.Text)
    if n and n > 0 then
        config.fovPixels = n
        FOVring.Radius = n
    else
        FOVBox.Text = tostring(config.fovPixels)
    end
end)

-- AimPart box
AimPartBox.FocusLost:Connect(function()
    local v = tostring(AimPartBox.Text)
    if v and v ~= "" then
        config.aimPart = v
    else
        AimPartBox.Text = config.aimPart
    end
end)

-- Keyboard hotkey: RightControl toggles aimbot
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        if config.aimbotEnabled then
            stopAimbot()
            AimbotBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
            AimbotBtn.Text = "Aimbot"
        else
            startAimbot()
            AimbotBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
            AimbotBtn.Text = "Aimbot: ON"
        end
    end
end)

-- Clean up ESP objects when players leave
Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        if espObjects[p].box and espObjects[p].box.Parent then espObjects[p].box:Destroy() end
        if espObjects[p].gui and espObjects[p].gui.Parent then espObjects[p].gui:Destroy() end
        espObjects[p] = nil
    end
end)

-- Ensure initial states
FOVring.Visible = false
AimbotBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
ESPBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
TeamToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
WallToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
MinBtn.Text = "-"

-- Optional: create ESP for existing players when toggled (handled in toggleES