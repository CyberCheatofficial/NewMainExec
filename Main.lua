-- Import necessary libraries
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local ExecuteButton = Instance.new("TextButton")

ScreenGui.Name = "CyberCheat"
ScreenGui.Parent = game.CoreGui

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 400, 0, 300)

TextBox.Name = "ScriptBox"
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.Position = UDim2.new(0.05, 0, 0.1, 0)
TextBox.Size = UDim2.new(0, 360, 0, 200)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Enter your script here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14
TextBox.TextWrapped = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true

ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Parent = Frame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ExecuteButton.Position = UDim2.new(0.35, 0, 0.8, 0)
ExecuteButton.Size = UDim2.new(0, 120, 0, 40)
ExecuteButton.Font = Enum.Font.SourceSans
ExecuteButton.Text = "Execute"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 18

-- Function to execute script
local function executeScript()
    local scriptText = TextBox.Text
    if scriptText and scriptText ~= "" then
        local success, errorMessage = pcall(function()
            loadstring(scriptText)()
        end)
        if not success then
            warn("Error executing script: " .. errorMessage)
        end
    else
        warn("No script to execute")
    end
end

-- Connect button to execute function
ExecuteButton.MouseButton1Click:Connect(executeScript)
