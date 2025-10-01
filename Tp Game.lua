-- LocalScript (đặt trong StarterGui hoặc StarterPlayerScripts)

local player = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo Frame chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🎮 Teleport tới Game khác"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.Parent = frame

-- Ô nhập ID
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.9, 0, 0, 30)
input.Position = UDim2.new(0.05, 0, 0.35, 0)
input.PlaceholderText = "Nhập Game ID (VD: 126884695634066)"
input.Text = ""
input.ClearTextOnFocus = false
input.TextColor3 = Color3.new(1, 1, 1)
input.TextSize = 16
input.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
input.Parent = frame

-- Nút Teleport
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0.65, 0)
button.Text = "🚀 Teleport!"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Parent = frame

-- Sự kiện nút Teleport
button.MouseButton1Click:Connect(function()
	local id = tonumber(input.Text)
	if id then
		TeleportService:Teleport(id, player)
	else
		button.Text = "❌ ID không hợp lệ!"
		wait(1.5)
		button.Text = "🚀 Teleport!"
	end
end)
