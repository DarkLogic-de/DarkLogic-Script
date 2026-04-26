--[[
    =========================================
               DARKLOGIC EXCLUSIVE
    =========================================
    [+] OWNER   : DarkLogic-de
    [+] VERSION : 13.1 (Hotfix)
    [+] THEME   : Electric Cyan
    [+] STATUS  : Undetected
    =========================================
--]]

local Player = game.Players.LocalPlayer
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v13_1"
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

-- [ 2. MAIN SCRIPT & UI ]
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

-- NEW: FLOATING SPEED BUTTON (MOBILE FRIENDLY)
local QuickSpeedBtn = Instance.new("TextButton", MainGui)
QuickSpeedBtn.Size = UDim2.new(0, 45, 0, 45)
QuickSpeedBtn.Position = UDim2.new(0, 10, 0.5, 0)
QuickSpeedBtn.Text = "⚡"
QuickSpeedBtn.BackgroundColor3 = BG
QuickSpeedBtn.TextColor3 = ACCENT
QuickSpeedBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", QuickSpeedBtn)
Instance.new("UIStroke", QuickSpeedBtn).Color = ACCENT

local qsActive = false
QuickSpeedBtn.MouseButton1Click:Connect(function()
    qsActive = not qsActive
    _G.fSpeed = qsActive
    QuickSpeedBtn.BackgroundColor3 = qsActive and ACCENT or BG
    QuickSpeedBtn.TextColor3 = qsActive and BG or ACCENT
end)

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
    World = Instance.new("ScrollingFrame", ContentArea),
    Settings = Instance.new("ScrollingFrame", ContentArea)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 2
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
end
Pages.Main.Visible = true

local function AddTab(name, pos, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        page.Visible = true
    end)
end

local function AddToggle(text, page, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(0.95, 0, 0, 38); btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    btn.Font = Enum.Font.Gotham; Instance.new("UICorner", btn)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.TextColor3 = active and ACCENT or Color3.new(0.8, 0.8, 0.8)
        callback(active)
    end)
end

-- [ 3. TABS ]
AddTab("MAIN", 10, Pages.Main)
AddTab("COMBAT", 45, Pages.Combat)
AddTab("TROLL", 80, Pages.Troll)
AddTab("WORLD", 115, Pages.World)
AddTab("INFO", 150, Pages.Settings)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

AddToggle("Elite Speed (150)", Pages.Main, function(v) _G.fSpeed = v end)
AddToggle("Click TP (Ctrl+Click)", Pages.Main, function(v) _G.clickTP = v end)
AddToggle("Infinite Jump", Pages.Main, function(v) _G.infJump = v end)
AddToggle("Noclip", Pages.Main, function(v) _G.noclip = v end)

AddToggle("Silent Aim", Pages.Combat, function(v) _G.silentAim = v end)
AddToggle("Mega Hitbox", Pages.Combat, function(v) _G.megaHit = v end)
AddToggle("Melee Reach", Pages.Combat, function(v) _G.meleeReach = v end) -- NEW
AddToggle("Player ESP", Pages.Combat, function(v) _G.esp = v end)

AddToggle("Chat Spammer", Pages.Troll, function(v) _G.spammer = v end)
AddToggle("Spinbot", Pages.Troll, function(v) _G.spin = v end)

AddToggle("Anti-AFK", Pages.World, function(v) _G.antiAfk = v end)
AddToggle("Chat Spy", Pages.World, function(v) _G.chatSpy = v end) -- NEW
AddToggle("Fullbright", Pages.World, function(v) game.Lighting.Brightness = v and 2 or 1 end)

local Credit = Instance.new("TextLabel", Pages.Settings)
Credit.Size = UDim2.new(0.95, 0, 0, 80)
Credit.Text = "⚡ OWNER: DarkLogic-de ⚡\nVersion: 13.1 (Hotfix)\nStatus: Undetected"
Credit.TextColor3 = ACCENT
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 14

-- SAFELY LOAD CHAT SPY
pcall(function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if events and events:FindFirstChild("OnMessageDoneFiltering") then
        events.OnMessageDoneFiltering.OnClientEvent:Connect(function(data)
            if _G.chatSpy and data.FromSpeaker ~= Player.Name then
                print("[SPY] " .. data.FromSpeaker .. ": " .. data.Message)
            end
        end)
    end
end)

-- [ 4. LOGIC ]
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    -- Added extra safety checks to prevent crashes if character dies
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        if _G.fSpeed then char.Humanoid.WalkSpeed = 150 else char.Humanoid.WalkSpeed = 16 end
        if _G.spin then char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0) end
        if _G.noclip then
            for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end
    end
    
    -- ESP, Hitbox & Reach Logic
    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= Player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
            -- ESP
            local existingEsp = other.Character:FindFirstChild("DL_ESP")
            if _G.esp and not existingEsp then
                local h = Instance.new("Highlight", other.Character)
                h.Name = "DL_ESP"
                h.FillColor = ACCENT
            elseif not _G.esp and existingEsp then
                existingEsp:Destroy()
            end
            
            -- Mega Hitbox
            local head = other.Character:FindFirstChild("Head")
            if head then
                if _G.megaHit then
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.5
                else
                    head.Size = Vector3.new(1.2, 1.2, 1.2)
                    head.Transparency = 0
                end
            end

            -- Melee Reach
            if _G.meleeReach then
                for _, part in pairs(other.Character:GetChildren()) do
                    if part:IsA("BasePart") and (part.Name:find("Arm") or part.Name:find("Hand")) then
                        part.Size = Vector3.new(5, 5, 5)
                        part.Transparency = 0.8
                    end
                end
            end
        end
    end
end)

-- Click TP Logic
Mouse.Button1Down:Connect(function()
    if _G.clickTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0, 3, 0)
    end
end)

-- Spammer Logic safely wrapped
spawn(function()
    while task.wait(2) do
        if _G.spammer then
            local msg = "DarkLogic v13.1 - Owner: DarkLogic-de"
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if ch then ch:SendAsync(msg) end
            else
                pcall(function()
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                end)
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function() 
    if _G.infJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid:ChangeState("Jumping") 
    end 
end)

print("DarkLogic v13.1 Hotfix Loaded!")
