--[[
    =========================================
               DARKLOGIC EXCLUSIVE
    =========================================
    [+] OWNER   : DarkLogic-de
    [+] VERSION : 12.6
    [+] THEME   : Electric Cyan
    [+] STATUS  : Undetected
    =========================================
--]]

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
-- ... everything else stays below ...

    DarkLogic v12.6 - THE CREATOR UPDATE
    New: Reach (Melee/Combat), Streamer Mode (Panic Key), Owner Credits
--]]

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")

-- CYBER CYAN THEME
local ACCENT = Color3.fromRGB(0, 255, 255) 
local BG = Color3.fromRGB(12, 12, 12)

-- 1. UI CORE (DELTA FIX)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v12_6"
MainGui.Parent = (gethui and gethui()) or (game:GetService("CoreGui")) or (Player:WaitForChild("PlayerGui"))
MainGui.ResetOnSpawn = false

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
local frameStroke = Instance.new("UIStroke", MainFrame)
frameStroke.Color = ACCENT

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Sidebar)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, -10)
ContentArea.Position = UDim2.new(0, 115, 0, 5)
ContentArea.BackgroundTransparency = 1

-- 2. TABS
local Pages = {
    Main = Instance.new("ScrollingFrame", ContentArea),
    Combat = Instance.new("ScrollingFrame", ContentArea),
    Troll = Instance.new("ScrollingFrame", ContentArea),
    Settings = Instance.new("ScrollingFrame", ContentArea)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 2
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
end
Pages.Main.Visible = true

-- 3. BUILDERS
local function AddTab(name, pos, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        page.Visible = true
    end)
end

local function AddToggle(text, page, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(0.95, 0, 0, 38); btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Instance.new("UICorner", btn)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.TextColor3 = active and ACCENT or Color3.new(0.8, 0.8, 0.8)
        callback(active)
    end)
end

-- 4. FEATURES
AddTab("MAIN", 10, Pages.Main)
AddTab("COMBAT", 45, Pages.Combat)
AddTab("TROLL", 80, Pages.Troll)
AddTab("INFO", 115, Pages.Settings)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [MAIN]
AddToggle("CFrame Speed", Pages.Main, function(v) _G.cfSpeed = v end)
AddToggle("Noclip", Pages.Main, function(v) _G.noclip = v end)
AddToggle("Infinite Jump", Pages.Main, function(v) _G.infJump = v end)

-- [COMBAT]
AddToggle("Reach (Melee Range)", Pages.Combat, function(v) _G.reach = v end)
AddToggle("Mega Hitbox", Pages.Combat, function(v) _G.hitbox = v end)
AddToggle("Silent Aim", Pages.Combat, function(v) _G.silentAim = v end)

-- [TROLL]
AddToggle("Chat Spammer", Pages.Troll, function(v) _G.spammer = v end)
AddToggle("Spin Fling", Pages.Troll, function(v) _G.fling = v end)

-- [SETTINGS / INFO]
AddToggle("Panic Mode (Hide UI)", Pages.Settings, function(v)
    MainGui.Enabled = not v
end)

local Credit = Instance.new("TextLabel", Pages.Settings)
Credit.Size = UDim2.new(0.95, 0, 0, 50)
Credit.Text = "Owner: DarkLogic-de\nVersion: 12.6 (Cyber Edition)"
Credit.TextColor3 = ACCENT
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.GothamBold

-- 5. THE BRAINS
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Reach / Hitbox Logic
        if _G.reach or _G.hitbox then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                    if _G.reach and dist < 25 then
                        -- Makes their character "larger" so your hits connect from far away
                        p.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                        p.Character.HumanoidRootPart.Transparency = 0.8
                    elseif _G.hitbox then
                        p.Character.Head.Size = Vector3.new(5, 5, 5)
                        p.Character.Head.Transparency = 0.5
                    else
                        p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        p.Character.HumanoidRootPart.Transparency = 1
                    end
                end
            end
        end
        -- CFrame Speed
        if _G.cfSpeed and char.Humanoid.MoveDirection.Magnitude > 0 then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * 1.1)
        end
        -- Spin Fling
        if _G.fling then
            char.HumanoidRootPart.RotVelocity = Vector3.new(0, 5000, 0)
        end
    end
end)

-- Chat Spammer (Fixed)
spawn(function()
    while task.wait(1.5) do
        if _G.spammer then
            local msg = "DarkLogic ON TOP! Get it on GitHub."
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if channel then channel:SendAsync(msg) end
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function() if _G.infJump then Player.Character.Humanoid:ChangeState("Jumping") end end)

print("DarkLogic v12.6 - Creator Edition Loaded!")
