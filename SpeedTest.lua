-- ======= VARIABLES =======
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local normalSpeed = 16
local runSpeed = 50
local speedEnabled = false

-- ======= GUI SETUP =======
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControllerGui"
screenGui.Parent = playerGui

-- الدائرة الصغيرة
local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "SpeedToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 100)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://6031094673" -- مثال أيقونة دائرية
toggleButton.Parent = screenGui

-- النافذة المنبثقة
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 70, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Visible = false
frame.Parent = screenGui

-- زر التفعيل/الإيقاف داخل النافذة
local toggleSpeedBtn = Instance.new("TextButton")
toggleSpeedBtn.Size = UDim2.new(1, -20, 0, 50)
toggleSpeedBtn.Position = UDim2.new(0, 10, 0, 25)
toggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleSpeedBtn.Text = "تشغيل السرعة"
toggleSpeedBtn.Parent = frame

-- ======= BUTTON FUNCTIONS =======
toggleButton.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

toggleSpeedBtn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
	if speedEnabled then
		toggleSpeedBtn.Text = "إيقاف السرعة"
	else
		toggleSpeedBtn.Text = "تشغيل السرعة"
	end
end)

-- ======= SPEED CONTROL =======
player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = normalSpeed

	-- تحديث السرعة باستمرار
	task.spawn(function()
		while character.Parent do
			if speedEnabled then
				humanoid.WalkSpeed = runSpeed
			else
				humanoid.WalkSpeed = normalSpeed
			end
			task.wait(0.1)
		end
	end)
end)
