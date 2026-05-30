-- ND Script v1.4.1 - Mobile Tab Fix + Pill Button Fix
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

-- Device detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

-- Settings
local settings = {
    theme = "BlackWhite",
    buttonSize = 1,
    guiSize = 1,
    animations = true,
}

-- Themes
local themes = {
    BlackWhite = {
        Main = Color3.fromRGB(10, 10, 10),
        TopBar = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(255, 255, 255),
        Button = Color3.fromRGB(20, 20, 20),
        ButtonText = Color3.fromRGB(220, 220, 220),
        ToggleBg = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(200, 200, 200),
        TabBg = Color3.fromRGB(15, 15, 15),
    },
    Red = {
        Main = Color3.fromRGB(15, 5, 5),
        TopBar = Color3.fromRGB(20, 0, 0),
        Accent = Color3.fromRGB(255, 50, 50),
        Button = Color3.fromRGB(25, 10, 10),
        ButtonText = Color3.fromRGB(255, 200, 200),
        ToggleBg = Color3.fromRGB(50, 20, 20),
        Text = Color3.fromRGB(255, 180, 180),
        TabBg = Color3.fromRGB(20, 5, 5),
    },
    Blue = {
        Main = Color3.fromRGB(5, 5, 15),
        TopBar = Color3.fromRGB(0, 0, 20),
        Accent = Color3.fromRGB(50, 100, 255),
        Button = Color3.fromRGB(10, 10, 25),
        ButtonText = Color3.fromRGB(200, 200, 255),
        ToggleBg = Color3.fromRGB(20, 20, 50),
        Text = Color3.fromRGB(180, 200, 255),
        TabBg = Color3.fromRGB(5, 5, 20),
    },
    Green = {
        Main = Color3.fromRGB(5, 15, 5),
        TopBar = Color3.fromRGB(0, 20, 0),
        Accent = Color3.fromRGB(50, 255, 50),
        Button = Color3.fromRGB(10, 25, 10),
        ButtonText = Color3.fromRGB(200, 255, 200),
        ToggleBg = Color3.fromRGB(20, 50, 20),
        Text = Color3.fromRGB(180, 255, 180),
        TabBg = Color3.fromRGB(5, 20, 5),
    },
    Purple = {
        Main = Color3.fromRGB(10, 5, 15),
        TopBar = Color3.fromRGB(15, 0, 20),
        Accent = Color3.fromRGB(150, 50, 255),
        Button = Color3.fromRGB(20, 10, 25),
        ButtonText = Color3.fromRGB(220, 200, 255),
        ToggleBg = Color3.fromRGB(40, 20, 50),
        Text = Color3.fromRGB(200, 180, 255),
        TabBg = Color3.fromRGB(15, 5, 20),
    },
    Gold = {
        Main = Color3.fromRGB(15, 12, 5),
        TopBar = Color3.fromRGB(20, 15, 0),
        Accent = Color3.fromRGB(255, 200, 50),
        Button = Color3.fromRGB(25, 20, 10),
        ButtonText = Color3.fromRGB(255, 240, 200),
        ToggleBg = Color3.fromRGB(50, 40, 20),
        Text = Color3.fromRGB(255, 230, 180),
        TabBg = Color3.fromRGB(20, 15, 5),
    },
}

local currentTheme = themes[settings.theme]

-- Size multipliers
local sizeMultipliers = {
    gui = {1, 1.2},
    button = {1, 1.3, 1.6},
}

local guiMul = sizeMultipliers.gui[settings.guiSize] or 1
local btnMul = sizeMultipliers.button[settings.buttonSize] or 1

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NDScript"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- Discord notification
StarterGui:SetCore("SendNotification", {
    Title = "ND Script v1.4.1",
    Text = "discord.gg/8ycCx8PQb",
    Duration = 8,
})

-- ==================== PILL BUTTON (MOBILE) - FIXED ====================
local pillButton = nil
local main = nil

if isMobile then
    pillButton = Instance.new("TextButton")
    pillButton.Size = UDim2.new(0, 140, 0, 36)
    pillButton.Position = UDim2.new(0.5, -70, 0, 8)
    pillButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    pillButton.BorderSizePixel = 0
    pillButton.Text = "ND SCRIPT v1.4"
    pillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    pillButton.TextSize = 13
    pillButton.Font = Enum.Font.SourceSansBold
    pillButton.ZIndex = 1000
    pillButton.AutoButtonColor = false
    pillButton.Active = true
    pillButton.Selectable = true
    pillButton.Parent = gui
    
    local pillCorner = Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(1, 0)
    pillCorner.Parent = pillButton
    
    local pillStroke = Instance.new("UIStroke")
    pillStroke.Color = Color3.fromRGB(255, 255, 255)
    pillStroke.Thickness = 1.5
    pillStroke.Parent = pillButton
    
    -- Simple tap detection without complex dragging for reliability
    pillButton.MouseButton1Click:Connect(function()
        if main then
            main.Visible = not main.Visible
        end
    end)
end

-- ==================== MAIN GUI ====================
local baseW = math.floor((isMobile and 370 or 350) * guiMul)
local baseH = math.floor((isMobile and 540 or 500) * guiMul)

main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, baseW, 0, baseH)
main.Position = UDim2.new(0.5, -baseW/2, 0.5, -baseH/2)
main.BackgroundColor3 = currentTheme.Main
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.ZIndex = 100
main.ClipsDescendants = true
main.Parent = gui

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = currentTheme.Accent
mainStroke.Thickness = 1
mainStroke.Parent = main

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = main

-- Top bar
local topBarH = math.floor((isMobile and 44 or 34) * guiMul)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, topBarH)
topBar.BackgroundColor3 = currentTheme.TopBar
topBar.BorderSizePixel = 0
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 6)
topCorner.Parent = topBar

local bottomCover = Instance.new("Frame")
bottomCover.Size = UDim2.new(1, 0, 0, 6)
bottomCover.Position = UDim2.new(0, 0, 1, -6)
bottomCover.BackgroundColor3 = currentTheme.TopBar
bottomCover.BorderSizePixel = 0
bottomCover.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 14, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ND SCRIPT v1.4.1"
titleLabel.TextColor3 = currentTheme.Accent
titleLabel.TextSize = math.floor((isMobile and 15 or 13) * guiMul)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeSize = math.floor((isMobile and 34 or 26) * guiMul)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, closeSize, 0, closeSize)
closeBtn.Position = UDim2.new(1, -(closeSize + 6), 0, math.floor((topBarH - closeSize) / 2))
closeBtn.BackgroundColor3 = currentTheme.Button
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = currentTheme.Accent
closeBtn.TextSize = math.floor((isMobile and 16 or 12) * guiMul)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.AutoButtonColor = false
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    shutdown()
    gui:Destroy()
end)

-- Tab buttons - FIXED for mobile
local tabH = math.floor((isMobile and 40 or 30) * guiMul)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, tabH)
tabFrame.Position = UDim2.new(0, 0, 0, topBarH)
tabFrame.BackgroundColor3 = currentTheme.TabBg
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local tabHighlight = Instance.new("Frame")
tabHighlight.Size = UDim2.new(0.125, 0, 0, 2)
tabHighlight.Position = UDim2.new(0, 0, 1, -2)
tabHighlight.BackgroundColor3 = currentTheme.Accent
tabHighlight.BorderSizePixel = 0
tabHighlight.Parent = tabFrame

-- Pages
local function createPage()
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, -(topBarH + tabH + 2))
    page.Position = UDim2.new(0, 0, 0, topBarH + tabH + 2)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = main
    return page
end

local pages = {}
local tabBtns = {}
local tabNames = {"FLY", "AIM", "VISUAL", "MM2", "EXEC", "EXT", "OTHER", "SET"}

for i = 1, #tabNames do
    pages[i] = createPage()
end
pages[1].Visible = true

local function switchTab(index)
    for _, p in pairs(pages) do p.Visible = false end
    for _, b in pairs(tabBtns) do b.TextColor3 = currentTheme.Text end
    pages[index].Visible = true
    tabBtns[index].TextColor3 = currentTheme.Accent
    tabHighlight.Position = UDim2.new((index-1) * 0.125, 0, 1, -2)
end

-- FIXED: Tab buttons with proper mobile touch support
local tabWidth = 0.125
for i = 1, #tabNames do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(tabWidth, 0, 1, 0)
    btn.Position = UDim2.new((i-1) * tabWidth, 0, 0, 0)
    btn.BackgroundColor3 = currentTheme.TabBg
    btn.BorderSizePixel = 0
    btn.Text = tabNames[i]
    btn.TextColor3 = i == 1 and currentTheme.Accent or currentTheme.Text
    btn.TextSize = math.floor((isMobile and 11 or 8) * guiMul)
    btn.Font = Enum.Font.SourceSansBold
    btn.AutoButtonColor = false
    btn.Active = true
    btn.Selectable = true
    btn.ZIndex = 10
    btn.Parent = tabFrame
    
    -- Use MouseButton1Click for reliable mobile taps
    btn.MouseButton1Click:Connect(function()
        switchTab(i)
    end)
    
    table.insert(tabBtns, btn)
end

-- Scrollers
local function makeScroller(parent)
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1, 0, 1, 0)
    sc.BackgroundTransparency = 1
    sc.ScrollBarThickness = math.floor((isMobile and 8 or 4) * guiMul)
    sc.ScrollBarImageColor3 = currentTheme.Accent
    sc.CanvasSize = UDim2.new(0, 0, 0, 2000)
    sc.ScrollingDirection = Enum.ScrollingDirection.Y
    sc.Parent = parent
    return sc
end

local scrollers = {}
for i = 1, #tabNames do
    scrollers[i] = makeScroller(pages[i])
end

-- Sizes
local btnH = math.floor((isMobile and 40 or 32) * btnMul)
local lblH = math.floor((isMobile and 22 or 18) * guiMul)
local sliderH = math.floor((isMobile and 48 or 36) * guiMul)
local txtSize = math.floor((isMobile and 14 or 12) * guiMul)
local smallTxt = math.floor((isMobile and 12 or 10) * guiMul)
local gap = math.floor((isMobile and 8 or 5) * guiMul)

-- Notification
function notify(msg)
    spawn(function()
        for _, v in pairs(main:GetChildren()) do
            if v.Name == "Notif" then v:Destroy() end
        end
        local n = Instance.new("TextLabel")
        n.Name = "Notif"
        n.Size = UDim2.new(0, math.floor(200 * guiMul), 0, math.floor((isMobile and 28 or 22) * guiMul))
        n.Position = UDim2.new(0.5, math.floor(-100 * guiMul), 0, -40)
        n.BackgroundColor3 = currentTheme.TopBar
        n.BorderSizePixel = 0
        n.Text = msg
        n.TextColor3 = currentTheme.Accent
        n.TextSize = math.floor((isMobile and 12 or 10) * guiMul)
        n.Font = Enum.Font.SourceSansBold
        n.Parent = main
        n.ZIndex = 10
        n.BackgroundTransparency = 0
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 4)
        corner.Parent = n
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = currentTheme.Accent
        stroke.Thickness = 1
        stroke.Parent = n
        
        wait(2)
        n:Destroy()
    end)
end

local function inTable(tbl, val)
    for _, v in pairs(tbl) do if v == val then return true end end
    return false
end

-- UI Components
local function addSection(sc, text, y)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, lblH + 6)
    container.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y)
    container.BackgroundTransparency = 1
    container.Parent = sc
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 2, 0, lblH)
    line.Position = UDim2.new(0, 0, 0, 3)
    line.BackgroundColor3 = currentTheme.Accent
    line.BorderSizePixel = 0
    line.Parent = container
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -8, 0, lblH)
    lbl.Position = UDim2.new(0, 8, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = currentTheme.Text
    lbl.TextSize = smallTxt
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container
end

local function addToggle(sc, text, y, callback)
    local state = false
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, btnH)
    container.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y)
    container.BackgroundColor3 = currentTheme.Button
    container.BorderSizePixel = 0
    container.Active = true
    container.Selectable = true
    container.Parent = sc
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, math.floor(180 * guiMul), 1, 0)
    label.Position = UDim2.new(0, math.floor(10 * guiMul), 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = currentTheme.ButtonText
    label.TextSize = txtSize
    label.Font = Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, math.floor(40 * guiMul), 0, math.floor(22 * guiMul))
    toggleBg.Position = UDim2.new(1, math.floor(-50 * guiMul), 0.5, math.floor(-11 * guiMul))
    toggleBg.BackgroundColor3 = currentTheme.ToggleBg
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = container
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, math.floor(18 * guiMul), 0, math.floor(18 * guiMul))
    toggleDot.Position = UDim2.new(0, 2, 0.5, math.floor(-9 * guiMul))
    toggleDot.BackgroundColor3 = currentTheme.Accent
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBg
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = toggleDot
    
    local function toggleUI(on)
        state = on
        if on then
            toggleDot.Position = UDim2.new(1, math.floor(-20 * guiMul), 0.5, math.floor(-9 * guiMul))
            toggleDot.BackgroundColor3 = currentTheme.Main
            toggleBg.BackgroundColor3 = currentTheme.Accent
        else
            toggleDot.Position = UDim2.new(0, 2, 0.5, math.floor(-9 * guiMul))
            toggleDot.BackgroundColor3 = currentTheme.Accent
            toggleBg.BackgroundColor3 = currentTheme.ToggleBg
        end
    end
    
    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleUI(not state)
            callback(not state)
        end
    end)
end

local sliderDragging = false

local function addSlider(sc, text, min, max, default, y, callback)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, lblH)
    lbl.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = currentTheme.Text
    lbl.TextSize = smallTxt
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sc

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, math.floor((isMobile and 30 or 24) * guiMul))
    barBg.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y + lblH + 2)
    barBg.BackgroundTransparency = 1
    barBg.Parent = sc

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, math.floor((isMobile and 10 or 5) * guiMul))
    bar.Position = UDim2.new(0, 0, 0, math.floor((isMobile and 10 or 9) * guiMul))
    bar.BackgroundColor3 = currentTheme.ToggleBg
    bar.BorderSizePixel = 0
    bar.Parent = barBg
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    local ratio = (default - min) / (max - min)
    fill.Size = UDim2.new(ratio, 0, 1, 0)
    fill.BackgroundColor3 = currentTheme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local dragging = false

    local function updateFromPos(inputX)
        local relX = math.clamp(inputX - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        local pos = relX / bar.AbsoluteSize.X
        local val = math.floor(min + (max - min) * pos + 0.5)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        lbl.Text = text .. ": " .. val
        callback(val)
    end

    bar.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not sliderDragging then
            dragging = true; sliderDragging = true
            updateFromPos(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false; sliderDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromPos(input.Position.X)
        end
    end)
end

local function addButton(sc, text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, btnH)
    btn.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y)
    btn.BackgroundColor3 = currentTheme.Button
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = currentTheme.ButtonText
    btn.TextSize = txtSize
    btn.Font = Enum.Font.SourceSansBold
    btn.AutoButtonColor = false
    btn.Active = true
    btn.Selectable = true
    btn.Parent = sc
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function addTextBox(sc, placeholder, y)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, btnH)
    box.Position = UDim2.new(0, math.floor(10 * guiMul), 0, y)
    box.BackgroundColor3 = currentTheme.Button
    box.BorderSizePixel = 0
    box.Text = ""
    box.PlaceholderText = placeholder
    box.TextColor3 = currentTheme.ButtonText
    box.PlaceholderColor3 = currentTheme.Text
    box.TextSize = txtSize
    box.Font = Enum.Font.SourceSans
    box.ClearTextOnFocus = false
    box.Parent = sc
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = box
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = currentTheme.Accent
    stroke.Thickness = 1
    stroke.Parent = box
    
    return box
end

-- ==================== FLY ====================
local flyEnabled, flySpeed = false, 50
local flyBodyGyro, flyBodyVelocity, flyConnection = nil, nil, nil

local function flyCleanup()
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
end

local function flyAttach(root)
    flyCleanup()
    if not root then return end
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    flyBodyGyro.P = 15000; flyBodyGyro.D = 500
    flyBodyGyro.CFrame = root.CFrame; flyBodyGyro.Parent = root
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    flyBodyVelocity.Velocity = Vector3.zero; flyBodyVelocity.P = 1000
    flyBodyVelocity.Parent = root
end

local smoothVelocity = Vector3.zero

local function flyStart()
    local char = LocalPlayer.Character
    if not char then notify("No character!"); return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then notify("No root!"); return end
    smoothVelocity = Vector3.zero; flyAttach(root)
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if flyBodyVelocity and flyBodyVelocity.Parent ~= root then flyAttach(root) end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local dir = Vector3.zero
        if not isMobile then
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
        else
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                local md = hum.MoveDirection
                if md.Z > 0.1 then dir += cam.CFrame.LookVector * md.Z elseif md.Z < -0.1 then dir += cam.CFrame.LookVector * md.Z end
                if md.X > 0.1 then dir += cam.CFrame.RightVector * md.X elseif md.X < -0.1 then dir += cam.CFrame.RightVector * md.X end
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.ButtonR2) then dir += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.ButtonL2) then dir -= Vector3.yAxis end
        end
        local tv = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
        smoothVelocity = smoothVelocity:Lerp(tv, 0.15)
        if flyBodyVelocity then flyBodyVelocity.Velocity = smoothVelocity end
        if flyBodyGyro then flyBodyGyro.CFrame = CFrame.new(root.Position, root.Position + cam.CFrame.LookVector) end
    end)
    notify("Fly ON")
end

local function flyStop()
    flyEnabled = false; smoothVelocity = Vector3.zero; flyCleanup()
    notify("Fly OFF")
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if flyEnabled then task.wait(0.5); local root = char:FindFirstChild("HumanoidRootPart")
        if root then smoothVelocity = Vector3.zero; flyAttach(root) end
    end
end)

-- ==================== NOCLIP ====================
local noclipEnabled, noclipConnection = false, nil

local function noclipStart()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        pcall(function()
            local char = LocalPlayer.Character
            if char then for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    end)
end

local function noclipStop()
    if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
    pcall(function()
        local char = LocalPlayer.Character
        if char then for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
    end)
end

-- ==================== SPEED ====================
local speedEnabled, speedVal, speedConnection = false, 50, nil

local function speedStart()
    if speedConnection then speedConnection:Disconnect() end
    speedConnection = RunService.Heartbeat:Connect(function()
        if not speedEnabled then return end
        pcall(function() local char = LocalPlayer.Character; if char then local hum = char:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = speedVal end end end)
    end)
    pcall(function() local char = LocalPlayer.Character; if char then local hum = char:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = speedVal end end end)
end

local function speedStop()
    if speedConnection then speedConnection:Disconnect(); speedConnection = nil end
    pcall(function() local char = LocalPlayer.Character; if char then local hum = char:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = 16 end end end)
end

-- ==================== ESP ====================
local espEnabled, espHighlights = false, {}

local function espCleanup()
    for _, h in pairs(espHighlights) do pcall(function() h:Destroy() end) end
    espHighlights = {}
end

local function espAddHighlight(part)
    if not part:IsA("BasePart") then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(255, 255, 255); h.FillTransparency = 0.85
    h.OutlineColor = Color3.fromRGB(255, 255, 255); h.OutlineTransparency = 0
    h.Adornee = part; h.Parent = part
    table.insert(espHighlights, h)
end

local function espAddPlayer(player)
    local function onChar(char)
        for _, p in pairs(char:GetDescendants()) do espAddHighlight(p) end
        char.DescendantAdded:Connect(function(p) espAddHighlight(p) end)
    end
    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
end

local function espStart()
    espCleanup()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espAddPlayer(p) end end
    Players.PlayerAdded:Connect(function(p) if espEnabled then espAddPlayer(p) end end)
end

local function espStop() espCleanup() end

-- ==================== AIMBOT ====================
local aimbotEnabled, aimbotFov, aimbotSmooth, aimbotWallCheck, aimbotTargetPart = false, 200, 5, true, "Head"
local aimbotConnection, aimbotCircle = nil, nil

local function aimbotCleanup()
    if aimbotConnection then aimbotConnection:Disconnect(); aimbotConnection = nil end
    if aimbotCircle then aimbotCircle:Destroy(); aimbotCircle = nil end
end

local function aimbotUpdateCircle()
    if not aimbotCircle then return end
    local cam = Workspace.CurrentCamera; if not cam then return end
    local size = cam.ViewportSize
    aimbotCircle.Size = UDim2.new(0, aimbotFov * 2, 0, aimbotFov * 2)
    aimbotCircle.Position = UDim2.new(0, size.X/2 - aimbotFov, 0, size.Y/2 - aimbotFov)
end

local function isVisible(part)
    if not aimbotWallCheck then return true end
    local cam = Workspace.CurrentCamera; if not cam then return true end
    local origin = cam.CFrame.Position; local dir = (part.Position - origin)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local char = LocalPlayer.Character; rayParams.FilterDescendantsInstances = char and {char} or {}
    local result = Workspace:Raycast(origin, dir.Unit * dir.Magnitude, rayParams)
    if result and result.Instance then return result.Instance:IsDescendantOf(part.Parent) end
    return true
end

local function aimbotGetTarget()
    local cam = Workspace.CurrentCamera; if not cam then return nil end
    local size = cam.ViewportSize; local center = Vector2.new(size.X/2, size.Y/2)
    local best, bestDist = nil, aimbotFov
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local targetPart = p.Character:FindFirstChild(aimbotTargetPart)
            if not targetPart and aimbotTargetPart == "Legs" then targetPart = p.Character:FindFirstChild("LeftLowerLeg") or p.Character:FindFirstChild("RightLowerLeg") end
            if not targetPart and aimbotTargetPart == "Torso" then targetPart = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("HumanoidRootPart") end
            local hum = p.Character:FindFirstChild("Humanoid")
            if targetPart and hum and hum.Health > 0 then
                if aimbotWallCheck and not isVisible(targetPart) then continue end
                local sp, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                if not onScreen then continue end
                local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                if dist < bestDist then bestDist = dist; best = targetPart end
            end
        end
    end
    return best
end

local function aimbotStart()
    aimbotCleanup()
    aimbotCircle = Instance.new("Frame")
    aimbotCircle.BackgroundTransparency = 1; aimbotCircle.ZIndex = 999; aimbotCircle.Parent = gui
    local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(255, 255, 255); stroke.Thickness = 1; stroke.Transparency = 0.5; stroke.Parent = aimbotCircle
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(1, 0); corner.Parent = aimbotCircle
    aimbotUpdateCircle()
    local cam = Workspace.CurrentCamera; if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(aimbotUpdateCircle) end
    aimbotConnection = RunService.Heartbeat:Connect(function()
        if not aimbotEnabled then return end
        if not UserInputService:IsMouseButtonPressed(1) then return end
        local targetPart = aimbotGetTarget()
        if targetPart then local cam = Workspace.CurrentCamera; if cam then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, targetPart.Position), aimbotSmooth/100) end end
    end)
    notify("Aimbot ON")
end

local function aimbotStop() aimbotCleanup(); notify("Aimbot OFF") end

-- ==================== MM2 ESP ====================
local mm2espEnabled, mm2espObjects, mm2espUpdate, playerRoles = false, {}, nil, {}

local function detectMM2Role(player)
    local char = player.Character; if not char then return playerRoles[player] or "Innocent" end
    local foundRole = nil
    for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") and (t.Name:lower():find("knife") or t.Name:lower():find("blade")) then foundRole = "Murderer" break end end
    if not foundRole then local bp = player:FindFirstChild("Backpack"); if bp then for _, t in pairs(bp:GetChildren()) do if t:IsA("Tool") and (t.Name:lower():find("knife") or t.Name:lower():find("blade")) then foundRole = "Murderer" break end end end end
    if not foundRole then for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("sheriff") then foundRole = "Sheriff" break end end end
    if not foundRole then for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") and (t.Name:lower():find("gun") or t.Name:lower():find("pistol")) then foundRole = "Hero" break end end end
    if foundRole then playerRoles[player] = foundRole; return foundRole end
    return playerRoles[player] or "Innocent"
end

local function getRoleColor(role)
    if role == "Murderer" then return Color3.fromRGB(255, 0, 0)
    elseif role == "Sheriff" then return Color3.fromRGB(0, 100, 255)
    elseif role == "Hero" then return Color3.fromRGB(255, 255, 0)
    else return Color3.fromRGB(0, 255, 0) end
end

local function mm2espCleanup()
    for _, d in pairs(mm2espObjects) do for _, h in pairs(d.Highlights) do pcall(function() h:Destroy() end) end end
    mm2espObjects = {}; if mm2espUpdate then mm2espUpdate:Disconnect(); mm2espUpdate = nil end; playerRoles = {}
end

local function mm2espAdd(player)
    local data = {Player = player, Highlights = {}}
    local function addH(part, col) if not part:IsA("BasePart") then return end; local h = Instance.new("Highlight"); h.FillColor = col; h.FillTransparency = 0.7; h.OutlineColor = col; h.OutlineTransparency = 0; h.Adornee = part; h.Parent = part; table.insert(data.Highlights, h) end
    local function updateAll() local col = getRoleColor(detectMM2Role(player)); for _, h in pairs(data.Highlights) do if h and h.Parent then h.FillColor = col; h.OutlineColor = col end end end
    local function onChar(char) local col = getRoleColor(detectMM2Role(player)); for _, p in pairs(char:GetDescendants()) do addH(p, col) end; char.DescendantAdded:Connect(function(p) addH(p, getRoleColor(detectMM2Role(player))); updateAll() end) end
    if player.Character then onChar(player.Character) end; player.CharacterAdded:Connect(onChar); table.insert(mm2espObjects, data)
end

local function mm2espUpdateColors() for _, d in pairs(mm2espObjects) do local col = getRoleColor(detectMM2Role(d.Player)); for _, h in pairs(d.Highlights) do if h and h.Parent then h.FillColor = col; h.OutlineColor = col end end end end

local function mm2espStart()
    mm2espCleanup()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then mm2espAdd(p) end end
    Players.PlayerAdded:Connect(function(p) if mm2espEnabled then mm2espAdd(p) end end)
    mm2espUpdate = RunService.Heartbeat:Connect(function() if not mm2espEnabled then return end; pcall(mm2espUpdateColors) end)
end

local function mm2espStop() mm2espCleanup() end

-- ==================== FAKE BADGE ====================
local fakeBadgeEnabled, fakeBadgeType, fakeBadgeConnection = false, "Verified", nil
local verifiedEmojis = {Verified = "☑️", Premium = "⭐", RobloxPlus = "➕"}

local function startFakeBadge()
    fakeBadgeEnabled = true
    fakeBadgeConnection = RunService.Heartbeat:Connect(function()
        if not fakeBadgeEnabled then return end
        pcall(function()
            local emoji = verifiedEmojis[fakeBadgeType] or "☑️"
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BillboardGui") and v:FindFirstChild("NameTag") then
                    local tag = v.NameTag
                    if tag:IsA("TextLabel") and not tag.Text:find(emoji) then tag.Text = emoji .. " " .. tag.Text:gsub("☑️ ", ""):gsub("⭐ ", ""):gsub("➕ ", "") end
                end
            end
        end)
    end)
    notify("Fake " .. fakeBadgeType .. " ON")
end

local function stopFakeBadge()
    fakeBadgeEnabled = false
    if fakeBadgeConnection then fakeBadgeConnection:Disconnect(); fakeBadgeConnection = nil end
    pcall(function() for _, v in pairs(game:GetDescendants()) do if v:IsA("BillboardGui") and v:FindFirstChild("NameTag") then local tag = v.NameTag; if tag:IsA("TextLabel") then tag.Text = tag.Text:gsub("☑️ ", ""):gsub("⭐ ", ""):gsub("➕ ", "") end end end end)
    notify("Fake Badge OFF")
end

local function setBadgeType(t) fakeBadgeType = t; if fakeBadgeEnabled then stopFakeBadge(); task.wait(0.1); startFakeBadge() end; notify("Badge: " .. t) end

-- ==================== FOV ====================
local fovEnabled, fovValue, fovConnection = false, 70, nil

local function updateFov(v) fovValue = v; if fovEnabled then pcall(function() Workspace.CurrentCamera.FieldOfView = v end) end end
local function startFov()
    fovEnabled = true; if fovConnection then fovConnection:Disconnect() end
    fovConnection = RunService.Heartbeat:Connect(function() if not fovEnabled then return end; pcall(function() Workspace.CurrentCamera.FieldOfView = fovValue end) end)
    pcall(function() Workspace.CurrentCamera.FieldOfView = fovValue end); notify("FOV: " .. fovValue)
end
local function stopFov() fovEnabled = false; if fovConnection then fovConnection:Disconnect(); fovConnection = nil end; pcall(function() Workspace.CurrentCamera.FieldOfView = 70 end); notify("FOV OFF") end

-- ==================== TROLLING ====================
local function spinChar() local char = LocalPlayer.Character; if not char then notify("No character!"); return end; local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end; local b = Instance.new("BodyAngularVelocity"); b.MaxTorque = Vector3.new(9e9, 9e9, 9e9); b.AngularVelocity = Vector3.new(0, 50, 0); b.Parent = root; task.delay(5, function() if b then b:Destroy() end end); notify("Spin!") end
local function flingChar() local char = LocalPlayer.Character; if not char then notify("No character!"); return end; local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end; local b = Instance.new("BodyVelocity"); b.MaxForce = Vector3.new(9e9, 9e9, 9e9); b.Velocity = Vector3.new(0, 500, 0); b.Parent = root; task.delay(3, function() if b then b:Destroy() end end); notify("Fling!") end
local function sitChar() local char = LocalPlayer.Character; if not char then notify("No character!"); return end; local hum = char:FindFirstChild("Humanoid"); if hum then hum.Sit = not hum.Sit; notify("Sit toggled!") end end
local function freezeChar() local char = LocalPlayer.Character; if not char then notify("No character!"); return end; local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end; root.Anchored = not root.Anchored; notify(root.Anchored and "Frozen!" or "Unfrozen!") end
local function crashServer() notify("Crashing..."); spawn(function() for i = 1, 500 do pcall(function() local p = Instance.new("Part"); p.Size = Vector3.new(10,10,10); p.Position = Vector3.new(math.random(-100,100), math.random(0,50), math.random(-100,100)); p.Anchored = true; p.Parent = Workspace end) end end) end
local function lagServer() notify("Lagging..."); spawn(function() for i = 1, 1000 do pcall(function() local s = Instance.new("Sound"); s.SoundId = "rbxassetid://0"; s.Volume = 10; s.Parent = Workspace end) end end) end

-- ==================== YOUTUBE MUSIC ====================
local musicSound = nil

local function playMusic(url)
    if musicSound then musicSound:Destroy(); musicSound = nil end
    musicSound = Instance.new("Sound")
    musicSound.SoundId = url
    musicSound.Volume = 0.5
    musicSound.Looped = true
    musicSound.Parent = Workspace
    musicSound:Play()
    notify("Music playing!")
end

local function stopMusic()
    if musicSound then musicSound:Destroy(); musicSound = nil end
    notify("Music stopped!")
end

-- ==================== SHUTDOWN ====================
function shutdown()
    flyEnabled = false; noclipEnabled = false; espEnabled = false; aimbotEnabled = false
    speedEnabled = false; mm2espEnabled = false; fakeBadgeEnabled = false; fovEnabled = false
    smoothVelocity = Vector3.zero
    flyCleanup(); noclipStop(); espCleanup(); aimbotCleanup(); mm2espCleanup(); stopFakeBadge()
    if fovConnection then fovConnection:Disconnect() end
    if speedConnection then speedConnection:Disconnect(); speedConnection = nil end
    if musicSound then musicSound:Destroy(); musicSound = nil end
    pcall(function()
        local char = LocalPlayer.Character
        if char then local hum = char:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = 16 end
            for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end
        end
        Workspace.CurrentCamera.FieldOfView = 70
    end)
end

-- ==================== PC BIND ====================
if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then main.Visible = not main.Visible end
    end)
end

-- ==================== BUILD UI ====================

-- FLY TAB
local y = 5
addSection(scrollers[1], "FLIGHT", y); y = y + lblH + 8
addToggle(scrollers[1], "Fly", y, function(s) flyEnabled = s; if s then flyStart() else flyStop() end end); y = y + btnH + gap
addSlider(scrollers[1], "Speed", 10, 200, 50, y, function(v) flySpeed = v end); y = y + sliderH + gap
addSection(scrollers[1], "NOCLIP", y); y = y + lblH + 8
addToggle(scrollers[1], "Noclip", y, function(s) noclipEnabled = s; if s then noclipStart() else noclipStop() end end); y = y + btnH + gap
addSection(scrollers[1], "SPEED", y); y = y + lblH + 8
addToggle(scrollers[1], "Speed Boost", y, function(s) speedEnabled = s; if s then speedStart() else speedStop() end end); y = y + btnH + gap
addSlider(scrollers[1], "Walk Speed", 16, 200, 50, y, function(v) speedVal = v; if speedEnabled then pcall(function() local char = LocalPlayer.Character; if char then local hum = char:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = v end end end) end end)
y = y + sliderH + 15; scrollers[1].CanvasSize = UDim2.new(0, 0, 0, y)

-- AIM TAB
y = 5
addSection(scrollers[2], "AIMBOT", y); y = y + lblH + 8
addToggle(scrollers[2], "Aimbot", y, function(s) aimbotEnabled = s; if s then aimbotStart() else aimbotStop() end end); y = y + btnH + gap
addSlider(scrollers[2], "FOV", 50, 500, 200, y, function(v) aimbotFov = v; aimbotUpdateCircle() end); y = y + sliderH + gap
addSlider(scrollers[2], "Smooth", 1, 30, 5, y, function(v) aimbotSmooth = v end); y = y + sliderH + gap
addToggle(scrollers[2], "Wall Check", y, function(s) aimbotWallCheck = s end); y = y + btnH + gap
addSection(scrollers[2], "TARGET", y); y = y + lblH + 8
local targetParts = {"Head", "Torso", "Legs"}
for idx, partName in pairs(targetParts) do
    local pb = Instance.new("TextButton")
    pb.Size = UDim2.new(0.3, -6, 0, btnH - 4); pb.Position = UDim2.new(0.03 + (idx-1)*0.32, 0, 0, y)
    pb.BackgroundColor3 = partName == aimbotTargetPart and currentTheme.Accent or currentTheme.Button
    pb.BorderSizePixel = 0; pb.Text = partName
    pb.TextColor3 = partName == aimbotTargetPart and currentTheme.Main or currentTheme.ButtonText
    pb.TextSize = smallTxt - 1; pb.Font = Enum.Font.SourceSansBold; pb.AutoButtonColor = false
    pb.Active = true; pb.Selectable = true; pb.Parent = scrollers[2]
    local pc = Instance.new("UICorner"); pc.CornerRadius = UDim.new(0, 4); pc.Parent = pb
    pb.MouseButton1Click:Connect(function()
        aimbotTargetPart = partName
        for _, c in pairs(scrollers[2]:GetChildren()) do if c:IsA("TextButton") and inTable(targetParts, c.Text) then
            c.BackgroundColor3 = currentTheme.Button; c.TextColor3 = currentTheme.ButtonText end end
        pb.BackgroundColor3 = currentTheme.Accent; pb.TextColor3 = currentTheme.Main
    end)
end
y = y + btnH + gap + 15; scrollers[2].CanvasSize = UDim2.new(0, 0, 0, y)

-- VISUALS TAB
y = 5
addSection(scrollers[3], "FAKE BADGE", y); y = y + lblH + 8
addToggle(scrollers[3], "Fake Badge", y, function(s) if s then startFakeBadge() else stopFakeBadge() end end); y = y + btnH + gap
local badgeTypes = {"Verified", "Premium", "RobloxPlus"}
for idx, badgeName in pairs(badgeTypes) do
    local bb = Instance.new("TextButton")
    bb.Size = UDim2.new(0.3, -6, 0, btnH - 4); bb.Position = UDim2.new(0.03 + (idx-1)*0.32, 0, 0, y)
    bb.BackgroundColor3 = badgeName == fakeBadgeType and currentTheme.Accent or currentTheme.Button
    bb.BorderSizePixel = 0; bb.Text = badgeName
    bb.TextColor3 = badgeName == fakeBadgeType and currentTheme.Main or currentTheme.ButtonText
    bb.TextSize = smallTxt - 1; bb.Font = Enum.Font.SourceSansBold; bb.AutoButtonColor = false
    bb.Active = true; bb.Selectable = true; bb.Parent = scrollers[3]
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 4); bc.Parent = bb
    bb.MouseButton1Click:Connect(function()
        setBadgeType(badgeName)
        for _, c in pairs(scrollers[3]:GetChildren()) do if c:IsA("TextButton") and inTable(badgeTypes, c.Text) then
            c.BackgroundColor3 = currentTheme.Button; c.TextColor3 = currentTheme.ButtonText end end
        bb.BackgroundColor3 = currentTheme.Accent; bb.TextColor3 = currentTheme.Main
    end)
end
y = y + btnH + gap
addSection(scrollers[3], "FOV CHANGER", y); y = y + lblH + 8
addToggle(scrollers[3], "FOV", y, function(s) if s then startFov() else stopFov() end end); y = y + btnH + gap
addSlider(scrollers[3], "FOV Value", 30, 120, 70, y, function(v) updateFov(v) end); y = y + sliderH + gap
addSection(scrollers[3], "PLAYER ESP", y); y = y + lblH + 8
addToggle(scrollers[3], "ESP", y, function(s) espEnabled = s; if s then espStart() else espStop() end end); y = y + btnH + 15
scrollers[3].CanvasSize = UDim2.new(0, 0, 0, y)

-- MM2 TAB
y = 5
addSection(scrollers[4], "MM2 ESP", y); y = y + lblH + 8
addToggle(scrollers[4], "MM2 ESP", y, function(s) mm2espEnabled = s; if s then mm2espStart() else mm2espStop() end end); y = y + btnH + gap
addSection(scrollers[4], "ROLES", y); y = y + lblH + 8
local roleInfo = {{"Murderer", Color3.fromRGB(255, 0, 0)}, {"Sheriff", Color3.fromRGB(0, 100, 255)}, {"Hero", Color3.fromRGB(255, 255, 0)}, {"Innocent", Color3.fromRGB(0, 255, 0)}}
for _, info in pairs(roleInfo) do
    local dot = Instance.new("Frame"); dot.Size = UDim2.new(0, 10, 0, 10); dot.Position = UDim2.new(0, 14, 0, y + 4)
    dot.BackgroundColor3 = info[2]; dot.BorderSizePixel = 0; dot.Parent = scrollers[4]
    local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
    local rl = Instance.new("TextLabel"); rl.Size = UDim2.new(1, -32, 0, lblH); rl.Position = UDim2.new(0, 28, 0, y)
    rl.BackgroundTransparency = 1; rl.Text = info[1]; rl.TextColor3 = info[2]; rl.TextSize = smallTxt
    rl.Font = Enum.Font.SourceSansBold; rl.TextXAlignment = Enum.TextXAlignment.Left; rl.Parent = scrollers[4]
    y = y + lblH + 2
end
y = y + 15; scrollers[4].CanvasSize = UDim2.new(0, 0, 0, y)

-- EXECUTOR TAB
y = 5
addSection(scrollers[5], "BUILT-IN EXECUTOR", y); y = y + lblH + 8
local scriptBox = addTextBox(scrollers[5], "Paste script here...", y)
scriptBox.Size = UDim2.new(1, math.floor(-20 * guiMul), 0, btnH * 3)
scriptBox.TextYAlignment = Enum.TextYAlignment.Top; scriptBox.MultiLine = true
y = y + btnH * 3 + gap

local function executeScript()
    local code = scriptBox.Text
    if code == "" then notify("Empty script!"); return end
    local success, err = pcall(function() loadstring(code)() end)
    if success then notify("Executed!") else notify("Error: " .. tostring(err)) end
end

local function clearScript() scriptBox.Text = ""; notify("Cleared!") end
local function pasteScript() pcall(function() scriptBox.Text = getclipboard() end); notify("Pasted!") end
local function copyScript() pcall(function() setclipboard(scriptBox.Text) end); notify("Copied!") end

addButton(scrollers[5], "EXECUTE", y, executeScript); y = y + btnH + gap
addButton(scrollers[5], "CLEAR", y, clearScript); y = y + btnH + gap
addButton(scrollers[5], "PASTE", y, pasteScript); y = y + btnH + gap
addButton(scrollers[5], "COPY", y, copyScript); y = y + btnH + gap
addSection(scrollers[5], "SAVED SCRIPTS", y); y = y + lblH + 8
addButton(scrollers[5], "+ NEW SCRIPT", y, function() scriptBox.Text = ""; notify("New script!") end); y = y + btnH + gap
for i = 1, 5 do
    local sName = "Script " .. i
    addButton(scrollers[5], sName, y, function() scriptBox.Text = "-- " .. sName .. "\nprint('ND Script!')"; notify("Loaded: " .. sName) end)
    y = y + btnH + gap
end
y = y + 15; scrollers[5].CanvasSize = UDim2.new(0, 0, 0, y)

-- EXTERNAL TAB
y = 5
addSection(scrollers[6], "EXTERNAL SCRIPTS", y); y = y + lblH + 8
addButton(scrollers[6], "INFINITE YIELD", y, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))(); notify("Loaded!") end); y = y + btnH + gap
addButton(scrollers[6], "DEX EXPLORER", y, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))(); notify("Loaded!") end); y = y + btnH + gap
addButton(scrollers[6], "SIMPLE SPY", y, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/exxprt/SimpleSpy/main/SimpleSpy.lua"))(); notify("Loaded!") end); y = y + btnH + gap
addButton(scrollers[6], "DARK DEX", y, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/DarkDexV3.lua"))(); notify("Loaded!") end); y = y + btnH + 15
scrollers[6].CanvasSize = UDim2.new(0, 0, 0, y)

-- OTHERS TAB
y = 5
addSection(scrollers[7], "YOUTUBE MUSIC", y); y = y + lblH + 8
local musicBox = addTextBox(scrollers[7], "rbxassetid://ID", y); y = y + btnH + gap
addButton(scrollers[7], "PLAY", y, function() playMusic(musicBox.Text) end); y = y + btnH + gap
addButton(scrollers[7], "STOP", y, stopMusic); y = y + btnH + gap
addButton(scrollers[7], "VOLUME 50%", y, function() if musicSound then musicSound.Volume = 0.5; notify("Volume: 50%") end end); y = y + btnH + gap
addButton(scrollers[7], "VOLUME 100%", y, function() if musicSound then musicSound.Volume = 1; notify("Volume: 100%") end end); y = y + btnH + gap
addSection(scrollers[7], "TROLLING", y); y = y + lblH + 8
addButton(scrollers[7], "SPIN", y, spinChar); y = y + btnH + gap
addButton(scrollers[7], "FLING", y, flingChar); y = y + btnH + gap
addButton(scrollers[7], "SIT / STAND", y, sitChar); y = y + btnH + gap
addButton(scrollers[7], "FREEZE", y, freezeChar); y = y + btnH + gap
addButton(scrollers[7], "CRASH SERVER", y, crashServer); y = y + btnH + gap
addButton(scrollers[7], "LAG SERVER", y, lagServer); y = y + btnH + 15
scrollers[7].CanvasSize = UDim2.new(0, 0, 0, y)

-- SETTINGS TAB
y = 5
addSection(scrollers[8], "THEMES", y); y = y + lblH + 8
for themeName, _ in pairs(themes) do
    addButton(scrollers[8], themeName, y, function()
        settings.theme = themeName
        currentTheme = themes[themeName]
        main.BackgroundColor3 = currentTheme.Main
        mainStroke.Color = currentTheme.Accent
        topBar.BackgroundColor3 = currentTheme.TopBar
        bottomCover.BackgroundColor3 = currentTheme.TopBar
        titleLabel.TextColor3 = currentTheme.Accent
        tabFrame.BackgroundColor3 = currentTheme.TabBg
        tabHighlight.BackgroundColor3 = currentTheme.Accent
        closeBtn.BackgroundColor3 = currentTheme.Button
        closeBtn.TextColor3 = currentTheme.Accent
        for _, b in pairs(tabBtns) do b.BackgroundColor3 = currentTheme.TabBg end
        notify("Theme: " .. themeName)
    end)
    y = y + btnH + gap
end

addSection(scrollers[8], "BUTTON SIZE", y); y = y + lblH + 8
local sizes = {"Normal", "Large", "Huge"}
for idx, sizeName in pairs(sizes) do
    addButton(scrollers[8], sizeName, y, function()
        settings.buttonSize = idx
        btnMul = sizeMultipliers.button[idx]
        notify("Button size: " .. sizeName .. " (reload to apply)")
    end)
    y = y + btnH + gap
end

addSection(scrollers[8], "GUI SIZE", y); y = y + lblH + 8
addButton(scrollers[8], "Normal", y, function()
    settings.guiSize = 1; guiMul = 1
    main.Size = UDim2.new(0, (isMobile and 370 or 350), 0, (isMobile and 540 or 500))
    notify("GUI: Normal")
end); y = y + btnH + gap
addButton(scrollers[8], "Large", y, function()
    settings.guiSize = 2; guiMul = 1.2
    main.Size = UDim2.new(0, math.floor((isMobile and 370 or 350) * 1.2), 0, math.floor((isMobile and 540 or 500) * 1.2))
    notify("GUI: Large")
end); y = y + btnH + gap

addSection(scrollers[8], "ANIMATIONS", y); y = y + lblH + 8
addToggle(scrollers[8], "Animations", y, function(s) settings.animations = s; notify("Animations: " .. (s and "ON" or "OFF")) end); y = y + btnH + 15
scrollers[8].CanvasSize = UDim2.new(0, 0, 0, y)

notify("ND Script v1.4.1 loaded!")
