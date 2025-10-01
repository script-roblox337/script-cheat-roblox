-- Create Hub
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local hubFrame = Instance.new("Frame")
hubFrame.Parent = screenGui
hubFrame.Size = UDim2.new(0, 200, 0, 400)
hubFrame.Position = UDim2.new(0, 100, 0, 100)
hubFrame.BackgroundColor3 = Color3.fromRGB(169, 169, 169)  -- Gray color
hubFrame.Active = true
hubFrame.Draggable = true

-- Create Key Tool
local keyTool = Instance.new("Tool")
keyTool.Name = "Key"
keyTool.RequiresHandle = true

local keyHandle = Instance.new("Part")
keyHandle.Name = "Handle"
keyHandle.Size = Vector3.new(1, 1, 3)
keyHandle.Shape = Enum.PartType.Block
keyHandle.Color = Color3.fromRGB(255, 255, 255)  -- White color
keyHandle.Anchored = false
keyHandle.CanCollide = false
keyHandle.Parent = keyTool

-- Create Stick Tool
local stickTool = Instance.new("Tool")
stickTool.Name = "Stick"
stickTool.RequiresHandle = true

local stickHandle = Instance.new("Part")
stickHandle.Name = "Handle"
stickHandle.Size = Vector3.new(0.5, 5, 0.5)
stickHandle.Color = Color3.fromRGB(139, 69, 19)  -- Brown color
stickHandle.Anchored = false
stickHandle.CanCollide = false
stickHandle.Parent = stickTool

-- Create Gun Tool
local gunTool = Instance.new("Tool")
gunTool.Name = "Gun"
gunTool.RequiresHandle = true

local gunHandle = Instance.new("Part")
gunHandle.Name = "Handle"
gunHandle.Size = Vector3.new(1, 1, 2)
gunHandle.Color = Color3.fromRGB(50, 50, 50)  -- Dark gray color for realism
gunHandle.Anchored = false
gunHandle.CanCollide = false
gunHandle.Parent = gunTool

gunTool.Equipped:Connect(function()
    gunTool.Activated:Connect(function()
        local bullet = Instance.new("Part")
        bullet.Size = Vector3.new(0.2, 0.2, 1)
        bullet.Color = Color3.fromRGB(255, 255, 0)  -- Yellow bullet
        bullet.Shape = Enum.PartType.Cylinder
        bullet.CFrame = gunHandle.CFrame * CFrame.new(0, 0, -2)
        bullet.CanCollide = false
        bullet.Parent = workspace

        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = gunHandle.CFrame.LookVector * 100
        bodyVelocity.Parent = bullet

        game:GetService("Debris"):AddItem(bullet, 2)

        bullet.Touched:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:TakeDamage(20)  -- Deal 20 damage
                bullet:Destroy()
            end
        end)
    end)
end)

-- Create Sword Tool
local swordTool = Instance.new("Tool")
swordTool.Name = "Sword"
swordTool.RequiresHandle = true

local swordHandle = Instance.new("Part")
swordHandle.Name = "Handle"
swordHandle.Size = Vector3.new(1, 4, 0.5)
swordHandle.Color = Color3.fromRGB(128, 128, 128)  -- Classic sword color
swordHandle.Anchored = false
swordHandle.CanCollide = false
swordHandle.Parent = swordTool

swordTool.Activated:Connect(function()
    swordHandle.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:TakeDamage(25)  -- Deal 25 damage
        end
    end)
end)

-- Create Buttons in the Hub
local tools = {
    {tool = keyTool, name = "Equip Key", position = 10},
    {tool = stickTool, name = "Equip Stick", position = 60},
    {tool = gunTool, name = "Equip Gun", position = 110},
    {tool = swordTool, name = "Equip Sword", position = 160},
}

for _, toolInfo in pairs(tools) do
    local button = Instance.new("TextButton")
    button.Parent = hubFrame
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = UDim2.new(0, 10, 0, toolInfo.position)
    button.Text = toolInfo.name
    button.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
    button.TextColor3 = Color3.fromRGB(0, 0, 0)

    button.MouseButton1Click:Connect(function()
        toolInfo.tool.Parent = game.Players.LocalPlayer.Backpack
    end)
end
