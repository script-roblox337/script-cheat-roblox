--== DỊCH VỤ ==--
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId

--== HÀM LẤY SERVER ==--
local function GetServers(cursor)
	local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
	if cursor then url = url.."&cursor="..cursor end
	local success, result = pcall(function()
		return HttpService:JSONDecode(game:HttpGet(url))
	end)
	return success and result or nil
end

--== HÀM ĐỔI SERVER ==--
local function HopServer(updateText, conditionFunc)
	local tried, nextCursor = {}, nil
	repeat
		local data = GetServers(nextCursor)
		if not data then break end
		for _, server in ipairs(data.data) do
			if server.id ~= jobId and not tried[server.id] and conditionFunc(server) then
				updateText("🔁 Đang chuyển...")
				wait(1)
				TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
				return true
			end
			tried[server.id] = true
		end
		nextCursor = data.nextPageCursor
	until not nextCursor
	updateText("❌ Không tìm thấy!")
	wait(2)
	updateText("Thử lại")
	return false
end

--== GUI ==--
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ServerMenuGUI"
screenGui.ResetOnSpawn = false

--== KHUNG CHÍNH ==--
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 190)
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- ✅ CHO PHÉP KÉO GUI

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

--== TIÊU ĐỀ ==--
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "🔧 Server Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 12)

--== HÀM TẠO NÚT ==--
local function createButton(name, posY, onClick)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.Text = name
	btn.BorderSizePixel = 0

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)

	btn.MouseButton1Click:Connect(function()
		btn.Active = false
		onClick(function(txt) btn.Text = txt end)
		wait(0.5)
		btn.Text = name
		btn.Active = true
	end)
end

--== CÁC NÚT SERVER ==--
createButton("🔄 Ngẫu nhiên", 40, function(setText)
	HopServer(setText, function(server)
		return server.playing < server.maxPlayers
	end)
end)

createButton("⬇️ Ít người (<10)", 90, function(setText)
	HopServer(setText, function(server)
		return server.playing < 10
	end)
end)

createButton("⬆️ Đông người", 140, function(setText)
	HopServer(setText, function(server)
		return server.playing >= (server.maxPlayers - 2)
	end)
end)
