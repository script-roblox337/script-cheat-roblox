-- LocalScript trong StarterPlayerScripts hoặc StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local currentWalkSpeed = 16
local currentJumpPower = 50

local function applyWalkSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = currentWalkSpeed
	end
end

local function applyJumpPower()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.JumpPower = currentJumpPower
	end
end

local function applyAll()
	applyWalkSpeed()
	applyJumpPower()
end

player.CharacterAdded:Connect(function()
	task.wait(0.5)
	applyAll()
end)

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SpeedJumpGUI"
gui.ResetOnSpawn = false

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 120, 0, 35)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.Text = "⚙ Speed Menu"
toggle.TextSize = 14
toggle.Parent = gui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 90)
frame.Position = UDim2.new(0, 10, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false
-- ❌ Không cho kéo menu
-- frame.Active = true
-- frame.Draggable = true
frame.Parent = gui

-- Ô nhập WalkSpeed
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 180, 0, 30)
speedBox.Position = UDim2.new(0, 10, 0, 10)
speedBox.PlaceholderText = "Nhập WalkSpeed (0 - 1000)"
speedBox.Text = tostring(currentWalkSpeed)
speedBox.Parent = frame

-- Nút áp dụng WalkSpeed
local walkBtn = Instance.new("TextButton")
walkBtn.Size = UDim2.new(0, 90, 0, 30)
walkBtn.Position = UDim2.new(0, 200, 0, 10)
walkBtn.Text = "Áp dụng WalkSpeed"
walkBtn.Parent = frame

-- Nút Reset
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0, 280, 0, 30)
resetBtn.Position = UDim2.new(0, 10, 0, 50)
resetBtn.Text = "🔄 Reset về mặc định"
resetBtn.Parent = frame

-- Toggle GUI
toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Xử lý WalkSpeed
walkBtn.MouseButton1Click:Connect(function()
	local val = tonumber(speedBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentWalkSpeed = val
		applyWalkSpeed()
		walkBtn.Text = "✅ WalkSpeed OK"
	else
		walkBtn.Text = "❌ Nhập sai (0–1000)"
	end
	task.wait(1.5)
	walkBtn.Text = "Áp dụng WalkSpeed"
end)

-- Reset về mặc định
resetBtn.MouseButton1Click:Connect(function()
	currentWalkSpeed = 16
	currentJumpPower = 50
	speedBox.Text = "16"
	applyAll()
	resetBtn.Text = "✅ Đã reset"
	task.wait(1.5)
	resetBtn.Text = "🔄 Reset về mặc định"
end)

-- Áp dụng lần đầu
applyAll()
