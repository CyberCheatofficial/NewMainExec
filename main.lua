local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

local CNEXPLOIT = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedSlider = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")
local InfJumpButton = Instance.new("TextButton")

CNEXPLOIT.Name = "CNEXPLOIT"
CNEXPLOIT.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = CNEXPLOIT
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.SourceSans
Title.Text = "CNEXPLOIT"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24

SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Parent = MainFrame
SpeedSlider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.3, 0)
SpeedSlider.Size = UDim2.new(0.8, 0, 0.1, 0)
SpeedSlider.Font = Enum.Font.SourceSans
SpeedSlider.Text = "Speed: 16"
SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
SpeedSlider.TextSize = 18

FlyButton.Name = "FlyButton"
FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
FlyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
FlyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
FlyButton.Font = Enum.Font.SourceSans
FlyButton.Text = "Fly: Off"
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.TextSize = 18

InfJumpButton.Name = "InfJumpButton"
InfJumpButton.Parent = MainFrame
InfJumpButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InfJumpButton.Position = UDim2.new(0.1, 0, 0.7, 0)
InfJumpButton.Size = UDim2.new(0.8, 0, 0.1, 0)
InfJumpButton.Font = Enum.Font.SourceSans
InfJumpButton.Text = "Infinite Jump: Off"
InfJumpButton.TextColor3 = Color3.new(1, 1, 1)
InfJumpButton.TextSize = 18

local function createLoadingScreen()
    local LoadingScreen = Instance.new("ScreenGui")
    local LoadingFrame = Instance.new("Frame")
    local LoadingText = Instance.new("TextLabel")

    LoadingScreen.Name = "LoadingScreen"
    LoadingScreen.Parent = game.CoreGui

    LoadingFrame.Name = "LoadingFrame"
    LoadingFrame.Parent = LoadingScreen
    LoadingFrame.BackgroundColor3 = Color3.new(1, 0.75, 0.8)
    LoadingFrame.Size = UDim2.new(1, 0, 1, 0)

    LoadingText.Name = "LoadingText"
    LoadingText.Parent = LoadingFrame
    LoadingText.BackgroundColor3 = Color3.new(1, 0.75, 0.8)
    LoadingText.Size = UDim2.new(1, 0, 1, 0)
    LoadingText.Font = Enum.Font.SourceSans
    LoadingText.Text = "Loading CNEXPLOIT..."
    LoadingText.TextColor3 = Color3.new(0, 0, 0)
    LoadingText.TextSize = 36

    wait(2)
    LoadingScreen:Destroy()
end

createLoadingScreen()

local speed = 16
local flying = false
local infJump = false

SpeedSlider.MouseButton1Click:Connect(function()
    speed = speed + 16
    if speed > 1000 then
        speed = 16
    end
    SpeedSlider.Text = "Speed: " .. speed
    humanoid.WalkSpeed = speed
end)

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    FlyButton.Text = "Fly: " .. (flying and "On" or "Off")
    if flying then
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyGyro.P = 9e4
        bodyGyro.Parent = character.HumanoidRootPart
        bodyVelocity.Parent = character.HumanoidRootPart
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        RunService.RenderStepped:Connect(function()
            if flying then
                bodyGyro.CFrame = camera.CFrame
                bodyVelocity.Velocity = camera.CFrame.LookVector * speed
            else
                bodyGyro:Destroy()
                bodyVelocity:Destroy()
            end
        end)
    end
end)

InfJumpButton.MouseButton1Click:Connect(function()
    infJump = not infJump
    InfJumpButton.Text = "Infinite Jump: " .. (infJump and "On" or "Off")
end)

UserInputService.JumpRequest:Connect(function()
    if infJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
