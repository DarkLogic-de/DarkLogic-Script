--[[
    =========================================
               DARKLOGIC EXCLUSIVE
    =========================================
    [+] OWNER   : DarkLogic-de
    [+] VERSION : 12.9 (The Aura Update)
    [+] THEME   : Electric Cyan
    =========================================
--]]

local Player = game.Players.LocalPlayer
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v12_9"
MainGui.Parent = (gethui and gethui()) or (game:GetService("CoreGui")) or (Player:WaitForChild("PlayerGui"))
MainGui.ResetOnSpawn = false

-- [ 1. CINEMATIC LOADING SCREEN ]
local LoadFrame = Instance.new("Frame", MainGui)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
LoadFrame.ZIndex = 10

local Title = Instance.new("TextLabel", LoadFrame)
Title.Size = UDim2.new(0, 400, 0, 60)
Title.Position = UDim2.new(0.5, -200, 0.45, -30)
Title.Text = "DARKLOGIC"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 60
Title.BackgroundTransparency = 1
Title.TextTransparency = 0

local OwnerLabel = Instance.new("TextLabel", LoadFrame)
OwnerLabel.Size = UDim2.new(0, 300, 0, 30)
OwnerLabel.Position = UDim2.new(0.5, -150, 0.45, 30)
OwnerLabel.Text = "OWNER: DARKLOGIC-DE"
OwnerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
OwnerLabel.Font = Enum.Font.GothamSemibold
OwnerLabel.TextSize = 18
OwnerLabel.BackgroundTransparency = 1

local BarBack = Instance.new("Frame", LoadFrame)
BarBack.Size = UDim2.new(0, 350, 0, 4)
BarBack.Position = UDim2.new(0.5, -175, 0.6, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Instance.new("UICorner", BarFill)

-- Animation
task.spawn(function()
    BarFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 2.5)
    task.wait(3)
    LoadFrame:TweenPosition(UDim2.new(0, 0, -1, 0), "In", "Back", 0.7)
    task.wait(0.8)
    LoadFrame:Destroy()
end)

-- [ 2. MAIN SCRIPT ]
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Mouse = Player:GetMouse()
local ACCENT = Color3.fromRGB(0, 255, 255) 
local BG = Color3.fromRGB(12, 12, 12)

local ToggleBtn = Instance.new("TextButton", MainGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
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
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Instance.new("UICorner", Sidebar)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -10)
ContentArea.Position = UDim2.new(0, 125, 0, 5)
ContentArea.BackgroundTransparency = 1

local Pages = {
    Main = Instance.new("ScrollingFrame", ContentArea),
    Combat = Instance.new("ScrollingFrame", ContentArea),
    Troll = Instance.new("ScrollingFrame", ContentArea),
    World = Instance.new("ScrollingFrame", ContentArea)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
end
Pages.Main.Visible = true

local function AddTab(name, pos, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        page.Visible = true
    end)
end

local function AddToggle(text, page, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(0.95, 0, 0, 40); btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22); btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.TextColor3 = active and ACCENT or Color3.new(0.7, 0.7, 0.7)
        callback(active)
    end)
end

AddTab("MAIN", 15, Pages.Main)
AddTab("COMBAT", 55, Pages.Combat)
AddTab("TROLL", 95, Pages.Troll)
AddTab("WORLD", 135, Pages.World)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Features
AddToggle("Elite Speed (150)", Pages.Main, function(v) _G.fSpeed = v end)
AddToggle("Click TP (Ctrl+Click)", Pages.Main, function(v) _G.clickTP = v end)
AddToggle("Infinite Jump", Pages.Main, function(v) _G.infJump = v end)
AddToggle("Noclip", Pages.Main, function(v) _G.noclip = v end)
AddToggle("Mega Hitbox", Pages.Combat, function(v) _G.megaHit = v end)
AddToggle("Player ESP", Pages.Combat, function(v) _G.esp = v end)
AddToggle("Chat Spammer", Pages.Troll, function(v) _G.spammer = v end)
AddToggle("Spinbot", Pages.Troll, function(v) _G.spin = v end)

-- Logic Loops
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if _G.fSpeed then char.Humanoid.WalkSpeed = 150 else char.Humanoid.WalkSpeed = 16 end
        if _G.spin then char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0) end
        if _G.noclip then
            for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end
        if _G.esp then
            for _, o in pairs(game.Players:GetPlayers()) do
                if o ~= Player and o.Character and not o.Character:FindFirstChild("DL_ESP") then
                    local h = Instance.new("Highlight", o.Character); h.Name = "DL_ESP"; h.FillColor = ACCENT
                end
            end
        end
    end
end)

Mouse.Button1Down:Connect(function()
    if _G.clickTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0, 3, 0)
    end
end)

UserInputService.JumpRequest:Connect(function() if _G.infJump then Player.Character.Humanoid:ChangeState("Jumping") end
        
