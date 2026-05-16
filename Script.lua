
local player = game.Players.LocalPlayer
local money = Instance.new("IntValue")
money.Name = "Money"
money.Value = 0
money.Parent = player

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0,50,0,50)
icon.Position = UDim2.new(0,100,0,100)
icon.BackgroundColor3 = Color3.new(0,0,0)
icon.Text = ""
icon.Parent = gui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0,160,0,100)
frame.Visible = false
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "Wave"
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8,0,0,40)
button.Position = UDim2.new(0.1,0,0.45,0)
button.Text = "1000 tiền / 1 wave"
button.Parent = frame

local enabled = false
local wave = 0

button.MouseButton1Click:Connect(function()
	enabled = not enabled
end)

icon.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

local dragging = false
local dragStart
local startPos

icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = icon.Position
	end
end)

icon.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		icon.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X + 60,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

icon.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

while true do
	task.wait(10)
	if enabled then
		wave += 1
		money.Value += 1000
	end
end
