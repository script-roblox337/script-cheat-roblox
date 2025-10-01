local player = game.Players.LocalPlayer

-- Hàm tạo GUI:
local function createGUI()
    if player.PlayerGui:FindFirstChild("TPGui_Delta_HackV2667") then
        player.PlayerGui:FindFirstChild("TPGui_Delta_HackV2667"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    ScreenGui.Name = "TPGui_Delta_HackV2667"

    -- Nút mở/tắt GUI:
    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.Text = "TP GUI"
    ToggleButton.Size = UDim2.new(0, 100, 0, 30)
    ToggleButton.Position = UDim2.new(0, 10, 0, 10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextScaled = true

    -- Khung chính:
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 250, 0, 260)
    Frame.Position = UDim2.new(0.5, -125, 0.5, -130)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Visible = false
    Frame.Draggable = true
    Frame.Active = true

    -- Tiêu đề:
    local TitleLabel = Instance.new("TextLabel", Frame)
    TitleLabel.Text = "TP GUI By Delta_HackV2667"
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true

    -- Nút Dropdown:
    local Dropdown = Instance.new("TextButton", Frame)
    Dropdown.Text = "Chọn người chơi"
    Dropdown.Size = UDim2.new(1, -20, 0, 30)
    Dropdown.Position = UDim2.new(0, 10, 0, 50)
    Dropdown.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Dropdown.TextScaled = true

    -- Khung chứa danh sách:
    local DropdownListFrame = Instance.new("Frame", Frame)
    DropdownListFrame.Size = UDim2.new(1, -20, 0, 100)
    DropdownListFrame.Position = UDim2.new(0, 10, 0, 85)
    DropdownListFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DropdownListFrame.Visible = false
    DropdownListFrame.ClipsDescendants = true

    -- Danh sách cuộn:
    local DropdownList = Instance.new("ScrollingFrame", DropdownListFrame)
    DropdownList.Size = UDim2.new(1, -5, 1, -5)
    DropdownList.Position = UDim2.new(0, 2, 0, 2)
    DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropdownList.ScrollBarThickness = 5
    DropdownList.BackgroundTransparency = 1

    -- Nút Teleport:
    local ButtonTP = Instance.new("TextButton", Frame)
    ButtonTP.Text = "Teleport"
    ButtonTP.Size = UDim2.new(1, -20, 0, 30)
    ButtonTP.Position = UDim2.new(0, 10, 0, 190)
    ButtonTP.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ButtonTP.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonTP.TextScaled = true

    -- Nút Follow:
    local ButtonFollow = Instance.new("TextButton", Frame)
    ButtonFollow.Text = "Auto Follow: TẮT"
    ButtonFollow.Size = UDim2.new(1, -20, 0, 30)
    ButtonFollow.Position = UDim2.new(0, 10, 0, 155)
    ButtonFollow.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    ButtonFollow.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonFollow.TextScaled = true

    -- Nút ADMIN CMD:
    local ButtonAdmin = Instance.new("TextButton", Frame)
    ButtonAdmin.Text = "ADMIN CMD"
    ButtonAdmin.Size = UDim2.new(1, -20, 0, 30)
    ButtonAdmin.Position = UDim2.new(0, 10, 0, 225)
    ButtonAdmin.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ButtonAdmin.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonAdmin.TextScaled = true

    DropdownList.Parent = DropdownListFrame
    DropdownListFrame.Parent = Frame

    -- Thông báo:
    local Notification = Instance.new("TextLabel", ScreenGui)
    Notification.Size = UDim2.new(0, 300, 0, 30)
    Notification.Position = UDim2.new(0.5, -150, 0.1, 0)
    Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.TextScaled = true
    Notification.BackgroundTransparency = 0.4
    Notification.Visible = false

    local selectedPlayer = nil
    local followEnabled = false

    local function showNotification(msg, color)
        Notification.Text = msg
        Notification.BackgroundColor3 = color
        Notification.Visible = true
        task.delay(2, function()
            Notification.Visible = false
        end)
    end

    local function updateDropdownList()
        DropdownList:ClearAllChildren()
        local yPos = 0
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player then
                local nameButton = Instance.new("TextButton", DropdownList)
                nameButton.Text = plr.Name
                nameButton.Size = UDim2.new(1, 0, 0, 25)
                nameButton.Position = UDim2.new(0, 0, 0, yPos)
                nameButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                nameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameButton.TextScaled = true

                nameButton.MouseButton1Click:Connect(function()
                    selectedPlayer = plr
                    Dropdown.Text = "Đã chọn: " .. plr.Name
                    DropdownListFrame.Visible = false
                end)

                yPos = yPos + 28
            end
        end
        DropdownList.CanvasSize = UDim2.new(0, 0, 0, yPos)
    end

    Dropdown.MouseButton1Click:Connect(function()
        DropdownListFrame.Visible = not DropdownListFrame.Visible
        if DropdownListFrame.Visible then
            updateDropdownList()
        end
    end)

    game.Players.PlayerAdded:Connect(updateDropdownList)
    game.Players.PlayerRemoving:Connect(updateDropdownList)

    -- Teleport:
    ButtonTP.MouseButton1Click:Connect(function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character:MoveTo(selectedPlayer.Character.HumanoidRootPart.Position)
            showNotification("Teleport thành công đến: " .. selectedPlayer.Name, Color3.fromRGB(0, 200, 0))
        else
            showNotification("Teleport thất bại! Kiểm tra người chơi.", Color3.fromRGB(200, 0, 0))
        end
    end)

    -- Follow liên tục:
    ButtonFollow.MouseButton1Click:Connect(function()
        followEnabled = not followEnabled
        ButtonFollow.Text = followEnabled and "Auto Follow: BẬT" or "Auto Follow: TẮT"
    end)

    game:GetService("RunService").Heartbeat:Connect(function()
        if followEnabled and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 2)
            end
        end
    end)

    -- Nút ADMIN CMD:
    ButtonAdmin.MouseButton1Click:Connect(function()
        showNotification("Đang tải ADMIN CMD...", Color3.fromRGB(255, 170, 0))
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)

    -- Hiệu ứng mở/tắt:
    ToggleButton.MouseButton1Click:Connect(function()
        Frame.Visible = not Frame.Visible
        if Frame.Visible then
            Frame:TweenPosition(UDim2.new(0.5, -125, 0.5, -130), "Out", "Bounce", 0.3, true)
        end
    end)
end

-- Tạo GUI:
createGUI()

-- Auto hồi GUI khi chết:
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    createGUI()
end)
