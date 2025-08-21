-- Kumara Library UI (Glass Style mirip Aroel Hub)

local UIS = game:GetService("UserInputService")

local Library = {}

-- Fungsi drag
local function makeDraggable(gui, handle)
    local dragging, dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Name = "KumaraLibrary"

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 650, 0, 420)
    Main.Position = UDim2.new(0.5, -325, 0.5, -210)
    Main.BackgroundTransparency = 1
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    -- Glass Effect (background blur halus)
    local Glass = Instance.new("ImageLabel")
    Glass.Size = UDim2.new(1, 0, 1, 0)
    Glass.BackgroundTransparency = 1
    Glass.Image = "rbxassetid://5554236805" -- tekstur kaca blur
    Glass.ImageTransparency = 0.15
    Glass.ScaleType = Enum.ScaleType.Stretch
    Glass.Parent = Main

    local GlassCorner = Instance.new("UICorner", Glass)
    GlassCorner.CornerRadius = UDim.new(0, 12)

    local Stroke = Instance.new("UIStroke", Glass)
    Stroke.Color = Color3.fromRGB(80, 80, 90)
    Stroke.Thickness = 1.2

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    TitleBar.BackgroundTransparency = 0.3
    TitleBar.Parent = Main
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Kumara Hub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 180, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Sidebar.BackgroundTransparency = 0.25
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    -- Content Frame
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -180, 1, -40)
    Content.Position = UDim2.new(0, 180, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Content.BackgroundTransparency = 0.2
    Content.BorderSizePixel = 0
    Content.Parent = Main
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)

    -- Contoh isi Content
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = ">> Isi menu Automation"
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Top
    Label.Parent = Content

    -- Bikin bisa di drag
    makeDraggable(Main, TitleBar)

    return Main, Sidebar, Content
end

return Library
