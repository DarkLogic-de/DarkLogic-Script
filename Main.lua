--[[
    =========================================
               DARKLOGIC EXCLUSIVE
    =========================================
    [+] OWNER   : DarkLogic-de
    [+] VERSION : 12.8 (Elite Edition)
    [+] THEME   : Electric Cyan
    [+] STATUS  : Undetected
    =========================================
--]]

local Player = game.Players.LocalPlayer
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v12_8"
MainGui.Parent = (gethui and gethui()) or (game:GetService("CoreGui")) or (Player:WaitForChild("PlayerGui"))
MainGui.ResetOnSpawn = false

-- [ 1. LOADING SCREEN ]
local LoadFrame = Instance.new("Frame", MainGui)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LoadFrame.ZIndex = 10

local Title = Instance.new("TextLabel", LoadFrame)
Title.Size = UDim2.new(0, 300, 0, 50)
Title.Position = UDim2.new(0.5, -150, 0.4, 0)
Title.Text = "DARKLOGIC"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 45
Title.BackgroundTransparency = 1

local OwnerLabel = Instance.new("TextLabel", LoadFrame)
OwnerLabel.Size = UDim2.new(0, 300, 0, 30)
OwnerLabel.Position = UDim2.new(0.5, -150, 0.4, 55)
OwnerLabel.Text = "Owner: DarkLogic-de"
OwnerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
OwnerLabel.Font = Enum.Font.Gotham
OwnerLabel.TextSize = 20
OwnerLabel.BackgroundTransparency = 1

local BarBack = Instance.new("Frame", LoadFrame)
BarBack.Size = UDim2.new(0, 320, 0, 12)
BarBack.Position = UDim2.new(0.5, -160, 0.6, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Instance.new("UICorner", BarFill)

-- Animation
task.wait(0.5)
BarFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 2.5)
task.wait(2.8)
LoadFrame:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Back", 0.6)
task.wait(0.7)
LoadFrame:Destroy()

-- [ 2. MAIN SCRIPT ]
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Mouse = Player:GetMouse()
local ACCENT = Color3.fromRGB(0, 255, 255) 
local BG = Color3.fromRGB(12, 12, 12)

local ToggleBtn = Instance.new("TextButton", MainGui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0.4, 0)
ToggleBtn.Text = "DL"
ToggleBtn.BackgroundColor3 = BG
ToggleBtn.TextColor3 = ACCENT
ToggleBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", ToggleBtn)
Instance.new("UIStroke", ToggleBtn).Color = ACCENT

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = BG
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = ACCENT

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Sidebar)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, -10)
ContentArea.Position = UDim2.new(0, 115, 0, 5)
ContentArea.BackgroundTransparency = 1

local Pages = {
    Main = Instance.new("ScrollingFrame", ContentArea),
    Combat = Instance.new("ScrollingFrame", ContentArea),
    Troll = Instance.new("ScrollingFrame", ContentArea),
    World = Instance.new("
        
