local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- COLOR PALETTE & CONFIG (Based on Character)
-- ==========================================
local PALETTE = {
    Background = Color3.fromRGB(182, 233, 219), -- Pastel Teal/Mint
    Stroke = Color3.fromRGB(24, 28, 32),         -- Bold Charcoal Outline
    Yellow = Color3.fromRGB(255, 222, 105),     -- Soft Yellow
    Pink = Color3.fromRGB(247, 148, 179),       -- Pastel Pink
    Blue = Color3.fromRGB(114, 186, 242),       -- Character Blue
    White = Color3.fromRGB(255, 252, 242)       -- Cream White
}

local TWEEN_INFO_BOUNCE = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_INFO_FAST = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ==========================================
-- UTILITY FUNCTIONS FOR UTMOST CUTESINESS
-- ==========================================
local function applyCartoonStyle(instance, cornerRadius, strokeThickness)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim2.new(0, cornerRadius)
    uiCorner.Parent = instance

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = strokeThickness
    uiStroke.Color = PALETTE.Stroke
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = instance
end

local function makeButtonBouncy(button)
    local originalSize = button.Size
    
    local hoverTween = TweenService:Create(button, TWEEN_INFO_BOUNCE, {
        Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 8, originalSize.Y.Scale, originalSize.Y.Offset + 8)
    })
    local normalTween = TweenService:Create(button, TWEEN_INFO_BOUNCE, { Size = originalSize })
    local clickTween = TweenService:Create(button, TWEEN_INFO_FAST, {
        Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 6, originalSize.Y.Scale, originalSize.Y.Offset - 6)
    })

    button.MouseEnter:Connect(function() hoverTween:Play() end)
    button.MouseLeave:Connect(function() normalTween:Play() end)
    button.MouseButton1Down:Connect(function() clickTween:Play() end)
    button.MouseButton1Up:Connect(function() hoverTween:Play() end)
end

-- ==========================================
-- CONSTRUCTING THE MAIN FRAME
-- ==========================================
local screenGui = script.Parent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 850, 0, 480)
mainFrame.Position = UDim2.new(0.5, -425, 0.5, -240)
mainFrame.BackgroundColor3 = PALETTE.Background
mainFrame.Parent = screenGui
applyCartoonStyle(mainFrame, 24, 5)

-- Decorative Top Banner (Scallop/Yellow Header Effect)
local headerBar = Instance.new("Frame")
headerBar.Name = "HeaderBar"
headerBar.Size = UDim2.new(0, 400, 0, 55)
headerBar.Position = UDim2.new(0.5, -200, 0, -25)
headerBar.BackgroundColor3 = PALETTE.Yellow
headerBar.Parent = mainFrame
applyCartoonStyle(headerBar, 16, 4)

local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, 0, 1, 0)
headerText.Text = "CANDY CAT SHOP!"
headerText.Font = Enum.Font.FredokaOne
headerText.TextSize = 28
headerText.TextColor3 = PALETTE.Stroke
headerText.BackgroundTransparency = 1
headerText.Parent = headerBar

-- ==========================================
-- LEFT SIDE: ITEMS GRID
-- ==========================================
local itemsGridFrame = Instance.new("Frame")
itemsGridFrame.Name = "ItemsGridFrame"
itemsGridFrame.Size = UDim2.new(0, 500, 0, 340)
itemsGridFrame.Position = UDim2.new(0, 25, 0, 55)
itemsGridFrame.BackgroundColor3 = Color3.fromRGB(215, 245, 238) -- Soft inner tint
itemsGridFrame.Parent = mainFrame
applyCartoonStyle(itemsGridFrame, 16, 4)

local uiGrid = Instance.new("UIGridLayout")
uiGrid.CellSize = UDim2.new(0, 105, 0, 145)
uiGrid.CellPadding = UDim2.new(0, 15, 0, 15)
uiGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiGrid.VerticalAlignment = Enum.VerticalAlignment.Center
uiGrid.Parent = itemsGridFrame

-- Helper to fill shop slots dynamically
local dummyItems = {"Candy Skin", "Plushie", "Keychain", "Headbow", "Bowtie", "Candy Mask"}
for _, itemName in ipairs(dummyItems) do
    local itemCard = Instance.new("Frame")
    itemCard.BackgroundColor3 = PALETTE.White
    itemCard.Parent = itemsGridFrame
    applyCartoonStyle(itemCard, 12, 3)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 5)
    label.Text = string.upper(itemName)
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 12
    label.TextColor3 = PALETTE.Stroke
    label.BackgroundTransparency = 1
    label.Parent = itemCard

    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0, 80, 0, 30)
    buyBtn.Position = UDim2.new(0.5, -40, 1, -38)
    buyBtn.BackgroundColor3 = PALETTE.Yellow
    buyBtn.Text = "BUY"
    buyBtn.Font = Enum.Font.FredokaOne
    buyBtn.TextSize = 14
    buyBtn.TextColor3 = PALETTE.Stroke
    buyBtn.Parent = itemCard
    applyCartoonStyle(buyBtn, 8, 3)
    makeButtonBouncy(buyBtn)
end

-- ==========================================
-- RIGHT SIDE: PREVIEW DISPLAY
-- ==========================================
local previewFrame = Instance.new("Frame")
previewFrame.Name = "PreviewFrame"
previewFrame.Size = UDim2.new(0, 270, 0, 340)
previewFrame.Position = UDim2.new(1, -295, 0, 55)
previewFrame.BackgroundColor3 = Color3.fromRGB(215, 245, 238)
previewFrame.Parent = mainFrame
applyCartoonStyle(previewFrame, 16, 4)

-- Character Name Tag Banner
local nameTag = Instance.new("Frame")
nameTag.Size = UDim2.new(0, 180, 0, 35)
nameTag.Position = UDim2.new(0.5, -90, 0, -15)
nameTag.BackgroundColor3 = PALETTE.Blue
nameTag.Parent = previewFrame
applyCartoonStyle(nameTag, 10, 3)

local nameText = Instance.new("TextLabel")
nameText.Size = UDim2.new(1, 0, 1, 0)
nameText.Text = "CANDY CAT"
nameText.Font = Enum.Font.FredokaOne
nameText.TextSize = 16
nameText.TextColor3 = PALETTE.White
nameText.BackgroundTransparency = 1
nameText.Parent = nameTag

-- Currency Info Box
local currencyBox = Instance.new("Frame")
currencyBox.Size = UDim2.new(0, 220, 0, 60)
currencyBox.Position = UDim2.new(0.5, -110, 1, -80)
currencyBox.BackgroundColor3 = PALETTE.White
currencyBox.Parent = previewFrame
applyCartoonStyle(currencyBox, 12, 3)

local currencyText = Instance.new("TextLabel")
currencyText.Size = UDim2.new(1, 0, 1, 0)
currencyText.Text = "CANDY COINS:\n1450"
currencyText.Font = Enum.Font.FredokaOne
currencyText.TextSize = 18
currencyText.TextColor3 = PALETTE.Stroke
currencyText.BackgroundTransparency = 1
currencyText.Parent = currencyBox

-- ==========================================
-- FOOTER: TABS & NAVIGATION BUTTONS
-- ==========================================
local footerFrame = Instance.new("Frame")
footerFrame.Size = UDim2.new(1, -40, 0, 50)
footerFrame.Position = UDim2.new(0, 20, 1, -65)
footerFrame.BackgroundTransparency = 1
footerFrame.Parent = mainFrame

local footerLayout = Instance.new("UIListLayout")
footerLayout.FillDirection = Enum.FillDirection.Horizontal
footerLayout.SortOrder = Enum.SortOrder.LayoutOrder
footerLayout.Padding = UDim.new(0, 12)
footerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
footerLayout.Parent = footerFrame

local tabs = {
    {Name = "CHARACTERS", Color = PALETTE.Yellow},
    {Name = "SHOP", Color = PALETTE.Pink},
    {Name = "ITEMS", Color = PALETTE.Blue},
    {Name = "EXIT", Color = Color3.fromRGB(120, 120, 120)}
}

for i, tabInfo in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 160, 1, 0)
    tabBtn.BackgroundColor3 = tabInfo.Color
    tabBtn.Text = tabInfo.Name
    tabBtn.Font = Enum.Font.FredokaOne
    tabBtn.TextSize = 16
    tabBtn.TextColor3 = PALETTE.White
    tabBtn.LayoutOrder = i
    tabBtn.Parent = footerFrame
    applyCartoonStyle(tabBtn, 12, 4)
    makeButtonBouncy(tabBtn)
    
    if tabInfo.Name == "EXIT" then
        tabBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = false
        end)
    end
end
