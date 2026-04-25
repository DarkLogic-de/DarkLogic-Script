--[[
    DarkLogic v12.5 - DELTA & CHAT FIX
    Theme: Electric Cyan
    Fixes: Delta UI, Chat Spammer, CFrame Speed
--]]

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")

-- COOL COLOR THEME (Electric Cyan)
local ACCENT = Color3.fromRGB(0, 255, 255) 
local BG = Color3.fromRGB(12, 12, 12)

-- 1. UI SETUP (Fixed for Delta)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DarkLogic_v12_5"
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
local btnStroke = Instance.new("UIStroke", ToggleBtn)
btnStroke.Color = ACCENT
btnStroke.Thickness = 2

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local frameStroke = Instance.new("UIStroke", MainFrame)
frameStroke.Color = ACCENT
frameStroke.Thickness = 1.5

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
    World = Instance.new("ScrollingFrame", ContentArea),
    TP = Instance.new("ScrollingFrame", ContentArea),
    Settings = Instance.new("ScrollingFrame", ContentArea)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.ScrollBarThickness = 2
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
end
Pages.Main.Visible = true

-- 3. BUILDERS
local function AddTab(name, pos, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
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
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and ACCENT or Color3.fromRGB(25, 25, 25)
        btn.TextColor3 = active and Color3.new(0,0,0) or Color3.new(0.8, 0.8, 0.8)
        callback(active)
    end)
end

-- 4. FEATURES
AddTab("MAIN", 10, Pages.Main)
AddTab("COMBAT", 45, Pages.Combat)
AddTab("TROLL", 80, Pages.Troll)
AddTab("WORLD", 115, Pages.World)
AddTab("TP", 150, Pages.TP)
AddTab("SETTINGS", 185, Pages.Settings)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [MAIN]
AddToggle("CFrame Speed (Bypass)", Pages.Main, function(v) _G.cfSpeed = v end)
AddToggle("Infinite Jump", Pages.Main, function(v) _G.infJump = v end)
AddToggle("Noclip", Pages.Main, function(v) _G.noclip = v end)
AddToggle("Click TP (Ctrl+Click)", Pages.Main, function(v) _G.clickTP = v end)

-- [COMBAT]
AddToggle("Silent Aim", Pages.Combat, function(v) _G.silentAim = v end)
AddToggle("Mega Hitbox", Pages.Combat, function(v) _G.megaHit = v end)
AddToggle("ESP (Cyan)", Pages.Combat, function(v)
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            if v then local h = Instance.new("Highlight", plr.Character); h.Name = "DL_ESP"; h.FillColor = ACCENT
            elseif plr.Character:FindFirstChild("DL_ESP") then plr.Character.DL_ESP:Destroy() end
        end
    end
end)

-- [TROLL]
AddToggle("Chat Spammer", Pages.Troll, function(v) _G.spammer = v end)
AddToggle("Spin Fling", Pages.Troll, function(v) _G.fling = v end)
AddToggle("Invisible (Local)", Pages.Troll, function(v)
    for _, p in pairs(Player.Character:GetDescendants()) do
        if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = v and 1 or 0 end
    end
end)

-- [WORLD]
AddToggle("Anti-AFK", Pages.World, function(v) _G.antiAfk = v end)
AddToggle("Fullbright", Pages.World, function(v) game.Lighting.Brightness = v and 2 or 1 end)

-- [SETTINGS]
AddToggle("Rainbow Border", Pages.Settings, function(v) _G.rainbow = v end)

-- 5. LOGIC (The Brains)
-- FIXED CHAT SPAMMER
spawn(function()
    while task.wait(1.5) do
        if _G.spammer then
            local msg = "DarkLogic v12.5 ON TOP!"
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if channel then channel:SendAsync(msg) end
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
        end
    end
end)

-- Click TP
Mouse.Button1Down:Connect(function()
    if _G.clickTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0, 3, 0)
    end
end)

RunService.RenderStepped:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- CFrame Speed
        if _G.cfSpeed and char.Humanoid.MoveDirection.Magnitude > 0 then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * 1.1)
        end
        -- Spin Fling
        if _G.fling then
            char.HumanoidRootPart.RotVelocity = Vector3.new(0, 5000, 0)
        end
        -- Noclip
        if _G.noclip then
            for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end
        -- Rainbow UI
        if _G.rainbow then
            local hue = tick() % 5 / 5
            frameStroke.Color = Color3.fromHSV(hue, 1, 1)
        else
            frameStroke.Color = ACCENT
        end
    end

    -- Hitbox Logic
    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= Player and other.Character and other.Character:FindFirstChild("Head") then
            if _G.megaHit then other.Character.Head.Size = Vector3.new(5, 5, 5); other.Character.Head.Transparency = 0.5 end
        end
    end
end)

UserInputService.JumpRequest:Connect(function() if _G.infJump then Player.Character.Humanoid:ChangeState("Jumping") end end)

print("DarkLogic v12.5 - Cyber Edition Loaded")
