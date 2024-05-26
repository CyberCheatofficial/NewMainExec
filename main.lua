-- Import required libraries
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Define the UI elements
local executor = script.Parent
local ui = executor:WaitForChild("UI")
local titleBar = ui:WaitForChild("TitleBar")
local cyberCheatLabel = titleBar:WaitForChild("CyberCheatLabel")

-- Set the UI color scheme
ui.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
titleBar.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
cyberCheatLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

-- Make the UI movable
local isDragging = false
local dragStart = Vector3.new(0, 0, 0)
local startPos = Vector3.new(0, 0, 0)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = ui.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if isDragging then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            ui:TweenPosition(newPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        end
    end
end)

