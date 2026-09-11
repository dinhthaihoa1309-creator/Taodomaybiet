local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local sg = Instance.new("ScreenGui", CoreGui:FindFirstChild("RobloxGui") or CoreGui)
sg.Name = "ModernMenuHog"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 230, 0, 115)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Stroke phát sáng viền Neon
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(85, 103, 255)
stroke.Thickness = 1.8
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tiêu đề
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -70, 0, 35)
title.Position = UDim2.new(0, 12, 0, 2)
title.Text = "HUB CONTROL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13

-- Nút Thu Nhỏ
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -56, 0, 7)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Nút Đóng
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 7)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -20, 1, -45)
content.Position = UDim2.new(0, 10, 0, 40)
content.BackgroundTransparency = 1

-- Nút Hitbox Modern
local hbBtn = Instance.new("TextButton", content)
hbBtn.Size = UDim2.new(1, 0, 0, 45)
hbBtn.Position = UDim2.new(0, 0, 0, 0)
hbBtn.Text = "HITBOX x7: OFF"
hbBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
hbBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
hbBtn.Font = Enum.Font.GothamBold
hbBtn.TextSize = 12
hbBtn.BorderSizePixel = 0
Instance.new("UICorner", hbBtn).CornerRadius = UDim.new(0, 8)

local hbStroke = Instance.new("UIStroke", hbBtn)
hbStroke.Color = Color3.fromRGB(35, 35, 45)
hbStroke.Thickness = 1.2

-- Gradient cho nút khi bật
local hbGradient = Instance.new("UIGradient", hbBtn)
hbGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 103, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 255))
})
hbGradient.Enabled = false

local hbOn = false
local defaultSize = Vector3.new(2, 2, 1)

hbBtn.MouseButton1Click:Connect(function()
	hbOn = not hbOn
	if hbOn then
		hbBtn.Text = "HITBOX x7: ON"
		hbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		hbGradient.Enabled = true
		hbStroke.Color = Color3.fromRGB(140, 120, 255)
	else
		hbBtn.Text = "HITBOX x7: OFF"
		hbBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
		hbGradient.Enabled = false
		hbBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
		hbStroke.Color = Color3.fromRGB(35, 35, 45)
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				v.Character.HumanoidRootPart.Size = defaultSize
				v.Character.HumanoidRootPart.Transparency = 1
			end
		end
	end
end)

local isMin = false
minBtn.MouseButton1Click:Connect(function()
	isMin = not isMin
	content.Visible = not isMin
	main.Size = isMin and UDim2.new(0, 230, 0, 38) or UDim2.new(0, 230, 0, 115)
end)

closeBtn.MouseButton1Click:Connect(function()
	sg:Destroy()
end)

task.spawn(function()
	while task.wait(0.1) do
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character then
				local hrp = v.Character:FindFirstChild("HumanoidRootPart")
				if hrp and hbOn then
					hrp.Size = Vector3.new(14, 14, 7)
					hrp.Transparency = 0.8
					hrp.Color = Color3.fromRGB(85, 103, 255)
					hrp.Material = Enum.Material.SmoothPlastic
					hrp.CanCollide = false
				end
			end
		end
	end
end)
