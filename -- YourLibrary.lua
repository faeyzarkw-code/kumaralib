-- Kumara Hub (No White Dots)

local UIS = game:GetService("UserInputService")

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
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 100
    ScreenGui.Name = "KumaraHub"

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 650, 0, 420)
    Main.Position = UDim2.new(0.5, -325, 0.5, -210)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Main.BackgroundTransparency = 0.25
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    -- Gradient (biar glassy, no dots)
    local Gradient = Instance.new("UIGradient", Main)
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,180))
    }
    Gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.2),
        NumberSequenceKeypoint.new(1, 0.4)
    }
    Gradient.Rotation = 90

    -- Stroke border
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(80, 80, 90)
    Stroke.Thickness = 1

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TitleBar.BackgroundTransparency = 0.15
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

    local TitleTxt = Instance.new("TextLabel")
    TitleTxt.Size = UDim2.new(1, -40, 1, 0)
    TitleTxt.Position = UDim2.new(0, 10, 0, 0)
    TitleTxt.BackgroundTransparency = 1
    TitleTxt.Text = title or "Kumara Hub"
    TitleTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleTxt.Font = Enum.Font.GothamBold
    TitleTxt.TextSize = 18
    TitleTxt.TextXAlignment = Enum.TextXAlignment.Left
    TitleTxt.Parent = TitleBar

    -- Close button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -35, 0.5, -15)
    Close.Text = "X"
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 16
    Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Close.BorderSizePixel = 0
    Close.Parent = TitleBar
    Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 180, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Sidebar.BackgroundTransparency = 0.2
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -180, 1, -40)
    Content.Position = UDim2.new(0, 180, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Content.BackgroundTransparency = 0.2
    Content.BorderSizePixel = 0
    Content.Parent = Main
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)

    -- Text sample
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 1, -20)
    Label.Position = UDim2.new(0, 10, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = ">> Isi menu Automation"
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Top
    Label.Parent = Content

    makeDraggable(Main, TitleBar)

    return Main, Sidebar, Content
end

-- panggil
CreateWindow("Kumara Hub")
