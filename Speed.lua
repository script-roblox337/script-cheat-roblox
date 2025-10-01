-- LocalScript – đặt trong StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- Tắt toàn bộ GUI mặc định
for _, gui in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
	if gui:IsA("ScreenGui") then
		gui.Enabled = false
	end
end

-- Ẩn nhân vật
for _, part in pairs(character:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Transparency = 1
	elseif part:IsA("Decal") then
		part.Transparency = 1
	elseif part:IsA("Accessory") then
		part:Destroy()
	end
end

-- Khóa nhân vật tại chỗ
if character:FindFirstChild("HumanoidRootPart") then
	character.HumanoidRootPart.Anchored = true
end

-- Đưa camera ra xa
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CFrame.new(Vector3.new(0, 9999, 0))

-- Tạo GUI để hiển thị chữ
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- Màn đen
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)

-- Dòng chữ
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "Script này đã bị xóa"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold

-- Âm thanh cảnh báo
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://9118823103" -- âm thanh glitch/error
sound.Volume = 1
sound:Play()

-- Kick người chơi sau 5 giây
task.wait(5)
player:Kick("Script đã bị xóa.")
