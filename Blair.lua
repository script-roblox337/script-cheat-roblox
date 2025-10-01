-- Script1 from Game2

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local Lighting         = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- preserve original lighting
local origAmbient         = Lighting.Ambient
local origOutdoorAmbient  = Lighting.OutdoorAmbient
local origBrightness      = Lighting.Brightness
local origColorShiftTop   = Lighting.ColorShift_Top
local origColorShiftBottom= Lighting.ColorShift_Bottom

-- create main ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "Game2UI"

-- title label
local titleLabel = Instance.new("TextLabel", screenGui)
titleLabel.Text               = "Made by brown_2, Brown_2's Hub"
titleLabel.Font               = Enum.Font.Gotham
titleLabel.TextSize           = 14
titleLabel.TextColor3         = Color3.new(1,1,1)
titleLabel.BackgroundTransparency = 1
titleLabel.Position           = UDim2.new(0,5,0,5)
titleLabel.Size               = UDim2.new(0,200,0,20)
titleLabel.TextXAlignment     = Enum.TextXAlignment.Left

-- scrolling frame for buttons
local scrollFrame = Instance.new("ScrollingFrame", screenGui)
scrollFrame.Name               = "ButtonFrame"
scrollFrame.Position           = UDim2.new(1, -235, 0, 30)
scrollFrame.Size               = UDim2.new(0, 230, 1, -35)
scrollFrame.CanvasSize         = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding   = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end)

-- 🔘 nút đóng/mở GUI
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 80, 0, 30)
toggleBtn.Position = UDim2.new(1, -90, 0, 5)
toggleBtn.Text = "Hide"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,6)

local guiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    scrollFrame.Visible = guiVisible
    titleLabel.Visible = guiVisible
    toggleBtn.Text = guiVisible and "Hide" or "Show"
end)

-- helper: create a button
local function createButton(name, text)
    local btn = Instance.new("TextButton", scrollFrame)
    btn.Name             = name
    btn.Size             = UDim2.new(1, 0, 0, 50)
    btn.Text             = text
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 14
    btn.TextWrapped      = true
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3       = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    return btn
end

-- clear all BoxHandleAdornments and Highlights
local function clearVisuals()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BoxHandleAdornment") or obj:IsA("Highlight") then
            obj:Destroy()
        end
    end
end

-- 1) Monitor BooBooDoll (BasePart)
local dollActive = false
local function monitorBooBooDoll()
    while dollActive do
        local part = Workspace:FindFirstChild("BooBooDoll")
        if part and part:IsA("BasePart") then
            if not part:FindFirstChildOfClass("BoxHandleAdornment") then
                local a = Instance.new("BoxHandleAdornment", part)
                a.Adornee      = part
                a.Size         = part.Size
                a.AlwaysOnTop  = true
                a.ZIndex       = 1
                a.Transparency = 0.4
                a.Color3       = Color3.fromRGB(255,255,0)
            end
        end
        task.wait(1/350)
    end
end

-- 2) Monitor Ghost (Highlight HRP)
local ghostActive = false
local function monitorGhost()
    while ghostActive do
        local npc = Workspace:FindFirstChild("Ghost")
        if npc and npc:IsA("Model") then
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            if hrp then
                local hl = hrp:FindFirstChildOfClass("Highlight")
                       or Instance.new("Highlight", hrp)
                hl.FillColor           = Color3.fromRGB(255,0,0)
                hl.OutlineColor        = Color3.fromRGB(255,255,255)
                hl.OutlineTransparency = 0
                hl.Enabled = true
            end
        end
        task.wait(1/350)
    end
end

-- 3) Manage Temperature Parts
local tempActive = false
local function manageTemperatureParts()
    local zones = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Zones")
    if not zones then return end

    -- remove Outside
    for _, p in ipairs(zones:GetChildren()) do
        if p:IsA("BasePart") and p.Name == "Outside" then
            p:Destroy()
        end
    end

    -- find coldest
    local coldest, coldVal = nil, math.huge
    for _, p in ipairs(zones:GetChildren()) do
        if p:IsA("BasePart") then
            local tv = p:FindFirstChild("_____Temperature")
            if tv and tv:IsA("NumberValue") and tv.Value < coldVal then
                coldest, coldVal = p, tv.Value
            end
            for _, c in ipairs(p:GetChildren()) do
                if c:IsA("BoxHandleAdornment") then c:Destroy() end
            end
        end
    end

    if coldest then
        local a = Instance.new("BoxHandleAdornment", coldest)
        a.Adornee      = coldest
        a.Size         = coldest.Size
        a.AlwaysOnTop  = true
        a.ZIndex       = 1
        a.Transparency = 0.4
        a.Color3       = Color3.fromRGB(0,255,255)
    end
end
local function monitorTemp()
    while tempActive do
        manageTemperatureParts()
        task.wait(1/350)
    end
end

-- 4) Safe Mode (10.5 studs)
local safeActive = false
local function startSafeLoop()
    while safeActive do
        local char = player.Character
        local npc  = Workspace:FindFirstChild("Ghost")
        if char and npc then
            local root      = char:FindFirstChild("HumanoidRootPart")
            local ghostRoot = npc:FindFirstChild("HumanoidRootPart")
            if root and ghostRoot then
                local d = (root.Position - ghostRoot.Position).Magnitude
                if d <= 10.5 then
                    local blocked = false
                    for _, p in ipairs(Workspace:GetDescendants()) do
                        if p:IsA("BasePart") and p.CanCollide
                        and not p:IsDescendantOf(char)
                        and (p.Position - root.Position).Magnitude < 4.5 then
                            blocked = true; break
                        end
                    end
                    if not blocked then
                        local lines = Workspace:FindFirstChild("Map")
                            and Workspace.Map:FindFirstChild("Van")
                            and Workspace.Map.Van:FindFirstChild("Van")
                            and Workspace.Map.Van.Van:FindFirstChild("Door")
                            and Workspace.Map.Van.Van.Door:FindFirstChild("Lines")
                        if lines and lines:IsA("BasePart") then
                            root.CFrame = CFrame.new(lines.Position + Vector3.new(0,3,0))
                        end
                    end
                end
            end
        end
        task.wait(1/350)
    end
end

-- 5) Infinite Stamina
local staminaActive = false
local function startStaminaLoop()
    while staminaActive do
        local char = player.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 12 or 6
        end
        task.wait(1/350)
    end
end

-- 6) Night Vision Toggle
local nightVision = false
local function toggleNightVision(on)
    if on then
        Lighting.Ambient        = Color3.fromRGB(0,255,0)
        Lighting.OutdoorAmbient = Color3.fromRGB(0,255,0)
        Lighting.Brightness     = 5
        Lighting.ColorShift_Top    = Color3.fromRGB(0,100,0)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0,100,0)
    else
        Lighting.Ambient        = Color3.new(0,0,0)
        Lighting.OutdoorAmbient = Color3.new(0,0,0)
        Lighting.Brightness     = 0
        Lighting.ColorShift_Top    = Color3.new(0,0,0)
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
    end
end

-- 7) Death GUI
local function createDeathGui()
    local gui = Instance.new("ScreenGui", playerGui)
    gui.Name = "DeathGUI"
    local lbl = Instance.new("TextLabel", gui)
    lbl.Size               = UDim2.new(0.5,0,0.2,0)
    lbl.Position           = UDim2.new(0.25,0,0.4,0)
    lbl.Text               = "You have died."
    lbl.TextScaled         = true
    lbl.Font               = Enum.Font.GothamBold
    lbl.BackgroundTransparency = 1
    lbl.TextColor3         = Color3.fromRGB(255,0,0)
end
player.CharacterAdded:Connect(function(c)
    c:WaitForChild("Humanoid").Died:Connect(createDeathGui)
end)

-- 8) Cursed Object ESP
local cursedActive = false
local function cursedESPLoop()
    clearVisuals()
    local items = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Items")
    if items then
        for _, name in ipairs({"Music Box","Tarot Cards"}) do
            local tool = items:FindFirstChild(name)
            if tool then
                for _, part in ipairs(tool:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local a = Instance.new("BoxHandleAdornment", part)
                        a.Adornee      = part
                        a.Size         = part.Size
                        a.AlwaysOnTop  = true
                        a.ZIndex       = 1
                        a.Transparency = 0.4
                        a.Color3       = Color3.fromRGB(255,0,255)
                    end
                end
            end
        end
    end
    local sb = Workspace:FindFirstChild("Spirit Board")
    if sb and sb:IsA("Model") then
        local bd = sb:FindFirstChild("Board")
        if bd and bd:IsA("BasePart") then
            local a = Instance.new("BoxHandleAdornment", bd)
            a.Adornee      = bd
            a.Size         = bd.Size
            a.AlwaysOnTop  = true
            a.ZIndex       = 1
            a.Transparency = 0.4
            a.Color3       = Color3.fromRGB(255,0,255)
        end
    end
end

-- 9) Check Orb Evidence
local function checkOrb()
    local orbs = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Orbs")
    return orbs and #orbs:GetChildren() > 0
end

-- create buttons
local btnDoll   = createButton("MonitorDoll",      "Monitor BooBoo Doll")
local btnGhost  = createButton("MonitorGhost",    "Monitor Ghost")
local btnTemp   = createButton("ManageTemp",      "Manage Temperature Parts")
local btnSafe   = createButton("SafeMode",        "Toggle Safe Mode (10.5)")
local btnStam   = createButton("InfiniteStamina", "Toggle Infinite Stamina")
local btnNight  = createButton("NightVision",     "Toggle Night Vision")
local btnCursed = createButton("CursedESP",       "Cursed Object ESP OFF ❌")
local btnCheck  = createButton("CheckOrb",        "Checking Orb")
local btnCancel = createButton("CancelAll",       "Cancel & Remove GUI")

-- button logic
btnDoll.MouseButton1Click:Connect(function()
    dollActive = not dollActive
    btnDoll.Text = dollActive and "Monitor BooBoo ON ✅" or "Monitor BooBoo OFF ❌"
    if dollActive then coroutine.wrap(monitorBooBooDoll)() end
end)

btnGhost.MouseButton1Click:Connect(function()
    ghostActive = not ghostActive
    btnGhost.Text = ghostActive and "Monitor Ghost ON ✅" or "Monitor Ghost OFF ❌"
    if ghostActive then coroutine.wrap(monitorGhost)() end
end)

btnTemp.MouseButton1Click:Connect(function()
    tempActive = not tempActive
    btnTemp.Text = tempActive and "Manage Temp ON ✅" or "Manage Temp OFF ❌"
    if tempActive then coroutine.wrap(monitorTemp)() end
end)

btnSafe.MouseButton1Click:Connect(function()
    safeActive = not safeActive
    btnSafe.Text = safeActive and "Safe Mode ON ✅" or "Safe Mode OFF ❌"
    if safeActive then coroutine.wrap(startSafeLoop)() end
end)

btnStam.MouseButton1Click:Connect(function()
    staminaActive = not staminaActive
    btnStam.Text = staminaActive and "Infinite Stamina ON ✅" or "Infinite Stamina OFF ❌"
    if staminaActive then coroutine.wrap(startStaminaLoop)() end
end)

btnNight.MouseButton1Click:Connect(function()
    nightVision = not nightVision
    btnNight.Text = nightVision and "Night Vision ON ✅" or "Night Vision OFF ❌"
    toggleNightVision(nightVision)
end)

btnCursed.MouseButton1Click:Connect(function()
    cursedActive = not cursedActive
    btnCursed.Text = cursedActive and "Cursed ESP ON ✅" or "Cursed ESP OFF ❌"
    if cursedActive then
        coroutine.wrap(function()
            while cursedActive do
                cursedESPLoop()
                task.wait(1/350)
            end
        end)()
    else
        clearVisuals()
    end
end)

btnCheck.MouseButton1Click:Connect(function()
    if checkOrb() then
        btnCheck.Text = "Exist (it's a evidence)"
        btnCheck.TextColor3 = Color3.fromRGB(0,255,0)
    else
        btnCheck.Text = "Not Exist (no orb evidence)"
        btnCheck.TextColor3 = Color3.fromRGB(255,0,0)
    end
end)

btnCancel.MouseButton1Click:Connect(function()
    -- stop loops
    dollActive     = false
    ghostActive    = false
    tempActive     = false
    safeActive     = false
    staminaActive  = false
    nightVision    = false
    cursedActive   = false

    -- clear visuals, restore lighting
    clearVisuals()
    toggleNightVision(false)
    Lighting.Ambient         = origAmbient
    Lighting.OutdoorAmbient  = origOutdoorAmbient
    Lighting.Brightness      = origBrightness
    Lighting.ColorShift_Top  = origColorShiftTop
    Lighting.ColorShift_Bottom = origColorShiftBottom

    -- remove GUI permanently
    screenGui:Destroy()
end)
