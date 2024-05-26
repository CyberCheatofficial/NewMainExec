-- Import required libraries
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- Create the main UI
local CyberCheat = Instance.new("ScreenGui")
CyberCheat.Name = "CyberCheat"
CyberCheat.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = CyberCheat

-- Create the title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "CyberCheat"
TitleLabel.Parent = TitleBar

-- Create the script input box
local ScriptBox = Instance.new("TextBox")
ScriptBox.Name = "ScriptBox"
ScriptBox.Size = UDim2.new(0.8, 0, 0.6, 0)
ScriptBox.Position = UDim2.new(0.1, 0, 0.2, 0)
ScriptBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptBox.TextSize = 14
ScriptBox.Font = Enum.Font.SourceSans
ScriptBox.PlaceholderText = "Paste your script here..."
ScriptBox.Parent = MainFrame

-- Create the execute button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0.2, 0, 0.1, 0)
ExecuteButton.Position = UDim2.new(0.4, 0, 0.8, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 16
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.Text = "Execute"
ExecuteButton.Parent = MainFrame

-- Create the loading screen
local LoadingScreen = Instance.new("Frame")
LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingScreen.Visible = false
LoadingScreen.Parent = CyberCheat

local LoadingLabel = Instance.new("TextLabel")
LoadingLabel.Name = "LoadingLabel"
LoadingLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
LoadingLabel.Position = UDim2.new(0.35, 0, 0.45, 0)
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingLabel.TextSize = 24
LoadingLabel.Font = Enum.Font.SourceSansBold
LoadingLabel.Text = "Loading..."
LoadingLabel.Parent = LoadingScreen

-- Drag functionality for the main frame
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Userr.InputType.MouseButton1 or input.UserInputType == Userr.InputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Userr.InputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Userr.InputType.MouseMovement or input.UserInputType == Userr.InputType.Touch then
        if dragging then
            update(input)
        end
    end
end)

-- Execute button functionality
ExecuteButton.MouseButton1Click:Connect(function()
    local script = ScriptBox.Text
    if script ~= "" then
        LoadingScreen.Visible = true
        local success, err = pcall(function()
            loadstring(script)()
        end)
        if not success then
            warn("Error executing script: " .. err)
        end
        LoadingScreen.Visible = false
    end
end)
