local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Hàm tạo GUI:
local function createGUI()
    if player.PlayerGui:FindFirstChild("TPGui_Delta_HackV2667") then
        player.PlayerGui:FindFirstChild("TPGui_Delta_HackV2667"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    ScreenGui.Name = "TPGui_Delta_HackV2667"

    -- Khung chính (ẩn mặc định, chỉ mở sau khi verify key):
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 250, 0, 260)
    Frame.Position = UDim2.new(0.5, -125, 0.5, -130)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Visible = false
    Frame.Active = true

    -- ==================== KEY SYSTEM ====================
    local KeyFrame = Instance.new("Frame", ScreenGui)
    KeyFrame.Size = UDim2.new(0, 250, 0, 150)
    KeyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeyFrame.Active = true

    local KeyTitle = Instance.new("TextLabel", KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 30)
    KeyTitle.BackgroundColor3 = Color3.fromRGB(0,170,255)
    KeyTitle.TextColor3 = Color3.fromRGB(255,255,255)
    KeyTitle.Text = "🔑 Key System"
    KeyTitle.TextScaled = true

    local KeyBox = Instance.new("TextBox", KeyFrame)
    KeyBox.Size = UDim2.new(1, -20, 0, 30)
    KeyBox.Position = UDim2.new(0, 10, 0, 40)
    KeyBox.PlaceholderText = "Nhập Key vào đây..."
    KeyBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
    KeyBox.TextColor3 = Color3.fromRGB(0,0,0)
    KeyBox.TextScaled = true

    local GetKeyBtn = Instance.new("TextButton", KeyFrame)
    GetKeyBtn.Size = UDim2.new(1, -20, 0, 30)
    GetKeyBtn.Position = UDim2.new(0, 10, 0, 80)
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
    GetKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    GetKeyBtn.TextScaled = true

    local VerifyBtn = Instance.new("TextButton", KeyFrame)
    VerifyBtn.Size = UDim2.new(1, -20, 0, 30)
    VerifyBtn.Position = UDim2.new(0, 10, 0, 120)
    VerifyBtn.Text = "Xác minh Key"
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    VerifyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    VerifyBtn.TextScaled = true

    local CorrectKey = "HjHdI862Kundvp8hK"

    local Notification = Instance.new("TextLabel", ScreenGui)
    Notification.Size = UDim2.new(0, 300, 0, 30)
    Notification.Position = UDim2.new(0.5, -150, 0.1, 0)
    Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.TextScaled = true
    Notification.BackgroundTransparency = 0.4
    Notification.Visible = false

    local function showNotification(msg, color)
        Notification.Text
