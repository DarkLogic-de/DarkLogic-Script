--[[
    =========================================
               DARKLOGIC EXCLUSIVE
    =========================================
    [+] OWNER   : DarkLogic-de
    [+] VERSION : 13.8 (The Masterpiece)
    [+] THEME   : Galaxy + Header + Rainbow + All Features
    =========================================
--]]

local Player = game.Players.LocalPlayer
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v13_8"
MainGui.Parent = (gethui and gethui()) or (game:GetService("CoreGui")) or (Player:WaitForChild("PlayerGui"))
MainGui.ResetOnSpawn = false

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Mouse = Player:GetMouse()
local ACCENT = Color3.fromRGB(0, 255, 255) 
local BG = Color3.fromRGB(10, 10, 15)

-- [ 1. SAFE ANIMATED LOADING SCREEN ]
local LoadFrame = Instance.new("Frame", MainGui)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
LoadFrame.ZIndex = 50

local Title = Instance.new("TextLabel", LoadFrame)
Title.Size = UDim2.new(0, 300, 0, 50)
Title.Position = UDim2.new(0.5, -150, 0.4, 0)
Title.Text = "DARKLOGIC V13.8"
Title.TextColor3 = ACCENT
Title.Font = Enum.Font.GothamBold
Title.TextSize = 45
Title.BackgroundTransparency = 1

local BarBack = Instance.new("Frame", LoadFrame)
BarBack.Size = UDim2.new(0, 320, 0, 10)
BarBack.Position = UDim2.new(0.5, -160, 0.6, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = ACCENT
Instance.new("UICorner", BarFill)

task.spawn(function()
    task.wait(0.5)
    BarFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 1.5)
    task.wait(1.7)
    LoadFrame:Destroy() -- Safely deleted
end)

-- [ 2. CUSTOM NOTIFICATION SYSTEM ]
local NotifFrame = Instance.new("Frame", MainGui)
NotifFrame.Size = UDim2.new(0, 250, 0, 60)
NotifFrame.Position = UDim2.new(1, 10, 0.8, 0)
NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", NotifFrame)
local NotifStroke = Instance.new("UIStroke", NotifFrame)
NotifStroke.Color = ACCENT
NotifStroke.Thickness = 2

local NotifTitle = Instance.new("TextLabel", NotifFrame)
NotifTitle.Size = UDim2.new(1, 0, 0.5, 0)
NotifTitle.Text = "DarkLogic System"
NotifTitle.TextColor3 = ACCENT
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.BackgroundTransparency = 1
NotifTitle.TextSize = 14

local NotifDesc = Instance.new("TextLabel", NotifFrame)
NotifDesc.Size = UDim2.new(1, 0, 0.5, 0)
NotifDesc.Position = UDim2.new(0, 0, 0.5, 0)
NotifDesc.Text = "Loaded Successfully!"
NotifDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifDesc.Font = Enum.Font.Gotham
NotifDesc.BackgroundTransparency = 1
NotifDesc.TextSize = 12

local function Notify(title, text, color)
    NotifTitle.Text = title
    NotifTitle.TextColor3 = color or ACCENT
    NotifStroke.Color = color or ACCENT
    NotifDesc.Text = text
    
    NotifFrame:TweenPosition(UDim2.new(1, -260, 0.8, 0), "Out", "Back", 0.4)
    task.wait(3)
    NotifFrame:TweenPosition(UDim2.new(1, 10, 0.8, 0), "In", "Quad", 0.4)
end

local function NotifyAdmin(name)
    Notify("⚠️ ADMIN DETECTED ⚠️", name .. " has joined!", Color3.fromRGB(255, 50, 50))
end

-- [ 3. MAIN UI & GALAXY BACKGROUND ]
local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 480, 0, 350)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = ACCENT

local GalaxyVideo = Instance.new("VideoFrame", MainFrame)
GalaxyVideo.Size = UDim2.new(1.2, 0, 1.2, 0)
GalaxyVideo.Position = UDim2.new(-0.1, 0, -0.1, 0)
GalaxyVideo.Video = "rbxassetid://5608327212"
GalaxyVideo.Looped = true
GalaxyVideo.ZIndex = 0
GalaxyVideo.BackgroundTransparency = 1
GalaxyVideo:Play()

-- [ 4. DISPLAY NAME HEADER ]
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, -20, 0, 40)
Header.Position = UDim2.new(0, 10, 0, 10)
Header.BackgroundTransparency = 1
Header.ZIndex = 5

local UserLabel = Instance.new("TextLabel", Header)
UserLabel.Size = UDim2.new(0, 150, 1, 0)
UserLabel.Text = Player.DisplayName
UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 16
UserLabel.TextXAlignment = Enum.TextXAlignment.Left
UserLabel.BackgroundTransparency = 1

local VerBadge = Instance.new("Frame", Header)
VerBadge.Size = UDim2.new(0, 50, 0, 22)
VerBadge.Position = UDim2.new(0, 160, 0.2, 0)
VerBadge.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", VerBadge).CornerRadius = UDim.new(1, 0)
local VerText = Instance.new("TextLabel", VerBadge)
VerText.Size = UDim2.new(1, 0, 1, 0)
VerText.Text = "v13.8"
VerText.TextColor3 = Color3.fromRGB(0, 0, 0)
VerText.Font = Enum.Font.GothamBold
VerText.TextSize = 10
VerText.BackgroundTransparency = 1

local StatusBadge = Instance.new("Frame", Header)
StatusBadge.Size = UDim2.new(0, 65, 0, 22)
StatusBadge.Position = UDim2.new(0, 215, 0.2, 0)
StatusBadge.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Instance.new("UICorner", StatusBadge).CornerRadius = UDim.new(1, 0)
local StatusText = Instance.new("TextLabel", StatusBadge)
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.Text = "PREMIUM"
StatusText.TextColor3 = Color3.fromRGB(0, 0, 0)
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 10
StatusText.BackgroundTransparency = 1

-- [ 5. TABS & SIDEBAR ]
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 100, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BackgroundTransparency = 0.4
Sidebar.ZIndex = 1
Instance.new("UICorner", Sidebar)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -110, 1, -70)
ContentArea.Position = UDim2.new(0, 105, 0, 60)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 1

local Pages = {
    Main = Instance.new("ScrollingFrame", ContentArea),
    Combat = Instance.new("ScrollingFrame", ContentArea),
    Troll = Instance.new("ScrollingFrame", ContentArea),
    World = Instance.new("ScrollingFrame", ContentArea),
    Info = Instance.new("ScrollingFrame", ContentArea)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 0
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
end
Pages.Main.Visible = true

local function AddTab(name, pos, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50); btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn)
    btn.ZIndex = 2
    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        page.Visible = true
    end)
end

local function AddToggle(text, page, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(0.95, 0, 0, 38); btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.new(0.8, 0.8, 0.8); btn.Font = Enum.Font.Gotham; Instance.new("UICorner", btn)
    btn.ZIndex = 2
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.TextColor3 = active and ACCENT or Color3.new(0.8, 0.8, 0.8)
        callback(active)
        -- Custom Notification when clicked
        local status = active and "Enabled" or "Disabled"
        local color = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
        task.spawn(function() Notify("Feature Update", text .. " is now " .. status, color) end)
    end)
end

AddTab("MAIN", 10, Pages.Main)
AddTab("COMBAT", 45, Pages.Combat)
AddTab("TROLL", 80, Pages.Troll)
AddTab("WORLD", 115, Pages.World)
AddTab("INFO", 150, Pages.Info)

-- [ 6. FEATURES LIST ]
-- MAIN
AddToggle("Elite Speed", Pages.Main, function(v) _G.fSpeed = v end)
AddToggle("Infinite Jump", Pages.Main, function(v) _G.infJump = v end)
AddToggle("Noclip", Pages.Main, function(v) _G.noclip = v end)
AddToggle("Mobile TP Tool", Pages.Main, function(v) 
    if v then
        local tool = Instance.new("Tool")
        tool.Name = "DL Teleport"
        tool.RequiresHandle = false
        tool.Parent = Player.Backpack
        tool.Activated:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0, 3, 0)
            end
        end)
        _G.tpTool = tool
    else
        if _G.tpTool then _G.tpTool:Destroy() end
    end
end)

-- COMBAT
AddToggle("Mega Hitbox", Pages.Combat, function(v) _G.megaHit = v end)
AddToggle("Melee Reach", Pages.Combat, function(v) _G.meleeReach = v end)
AddToggle("Player ESP", Pages.Combat, function(v) _G.esp = v end)
AddToggle("Silent Aim", Pages.Combat, function(v) _G.silentAim = v end)

-- TROLL
AddToggle("Chat Spammer", Pages.Troll, function(v) _G.spammer = v end)
AddToggle("Spinbot", Pages.Troll, function(v) _G.spin = v end)

-- WORLD
AddToggle("Admin Detector", Pages.World, function(v) _G.adminDetect = v end)
AddToggle("Rainbow Mode", Pages.World, function(v) _G.rainbow = v end)
AddToggle("Fullbright", Pages.World, function(v) game.Lighting.Brightness = v and 2 or 1 end)
AddToggle("Anti-AFK", Pages.World, function(v) _G.antiAfk = v end)

-- INFO
local InfoLabel = Instance.new("TextLabel", Pages.Info)
InfoLabel.Size = UDim2.new(0.95, 0, 0, 150)
InfoLabel.Text = "💎 DARKLOGIC v13.8 💎\n\nOwner: DarkLogic-de\nEdition: The Masterpiece\nStatus: Undetected\n\nThank you for using DarkLogic."
InfoLabel.TextColor3 = ACCENT
InfoLabel.BackgroundTransparency = 1
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextSize = 14

-- [ 7. CORE LOGIC ]
-- Admin Checker
local function CheckPlayer(p)
    if not _G.adminDetect then return end
    if p:GetRankInGroup(game.CreatorId) >= 200 or p:IsFriendsWith(1) then
        NotifyAdmin(p.Name)
    end
end
game.Players.PlayerAdded:Connect(CheckPlayer)

-- Spammer Logic
task.spawn(function()
    while task.wait(3) do
        if _G.spammer then
            local msg = "DarkLogic v13.8 - The Ultimate Menu by DarkLogic-de"
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if ch then ch:SendAsync(msg) end
            else
                pcall(function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All") end)
            end
        end
    end
end)

-- Main Toggle Buttons
local ToggleBtn = Instance.new("TextButton", MainGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.4, 0)
ToggleBtn.Text = "DL"
ToggleBtn.BackgroundColor3 = BG
ToggleBtn.TextColor3 = ACCENT
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.ZIndex = 15
Instance.new("UICorner", ToggleBtn)
Instance.new("UIStroke", ToggleBtn).Color = ACCENT
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local QuickSpeedBtn = Instance.new("TextButton", MainGui)
QuickSpeedBtn.Size = UDim2.new(0, 50, 0, 50)
QuickSpeedBtn.Position = UDim2.new(0, 10, 0.5, 0)
QuickSpeedBtn.Text = "⚡"
QuickSpeedBtn.BackgroundColor3 = BG
QuickSpeedBtn.TextColor3 = ACCENT
QuickSpeedBtn.ZIndex = 15
Instance.new("UICorner", QuickSpeedBtn)
Instance.new("UIStroke", QuickSpeedBtn).Color = ACCENT

local qsActive = false
QuickSpeedBtn.MouseButton1Click:Connect(function()
    qsActive = not qsActive
    _G.fSpeed = qsActive
    QuickSpeedBtn.BackgroundColor3 = qsActive and ACCENT or BG
    QuickSpeedBtn.TextColor3 = qsActive and BG or ACCENT
    task.spawn(function() Notify("Speed Hack", qsActive and "Enabled" or "Disabled", qsActive and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,100,100)) end)
end)

UserInputService.JumpRequest:Connect(function() 
    if _G.infJump and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid:ChangeState("Jumping") 
    end 
end)

-- Heartbeat Loop (Speed, ESP, Hitbox, Rainbow, Spinbot, Noclip)
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if _G.fSpeed then char.Humanoid.WalkSpeed = 150 else char.Humanoid.WalkSpeed = 16 end
        if _G.spin and char:FindFirstChild("HumanoidRootPart") then 
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0) 
        end
        if _G.noclip then
            for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end
    end
    
    -- Rainbow Logic
    if _G.rainbow then
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        MainStroke.Color = color
        ToggleBtn.TextColor3 = color
        UserLabel.TextColor3 = color
        NotifStroke.Color = color
    else
        MainStroke.Color = ACCENT
        ToggleBtn.TextColor3 = ACCENT
        UserLabel.TextColor3 = Color3.new(1,1,1)
    end
    
    -- ESP & Hitbox Logic
    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= Player and other.Character then
            local esp = other.Character:FindFirstChild("DL_ESP")
            if _G.esp and not esp then
                local h = Instance.new("Highlight", other.Character)
                h.Name = "DL_ESP"; h.FillColor = ACCENT
            elseif not _G.esp and esp then esp:Destroy() end
            
            local hrp = other.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if _G.megaHit then
                    hrp.Size = Vector3.new(10, 10, 10); hrp.Transparency = 0.8
                else
                    hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 1
                end
            end
        end
    end
end)

print("DarkLogic v13.8 The Masterpiece has successfully injected.")
