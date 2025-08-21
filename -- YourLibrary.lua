local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Library = {}

-- fungsi drag window
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
    Main.BackgroundTransparency = 1 -- biar blur yg keliatan
    Main.BorderSizePixel = 0
    Main.ZIndex = 1
    Main.Parent = ScreenGui

    -- Blur background (efek kaca)
    local blur = Instance.new("ImageLabel")
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundTransparency = 1
    blur.Image = "rbxassetid://8992230677" -- texture blur halus
    blur.ImageTransparency = 0.25 -- lebih solid
    blur.ScaleType = Enum.ScaleType.Tile
    blur.TileSize = UDim2.new(0, 200, 0, 200)
    blur.ZIndex = 0
    blur.Parent = Main

    -- Rounded corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = Main

    -- Stroke (outline tipis)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(180, 180, 190)
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = Main

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    TitleBar.BackgroundTransparency = 0.25
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    TitleBar.ZIndex = 2

    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(0, 14)
    tbCorner.Parent = TitleBar

    -- Judul
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(235, 235, 235)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = TitleBar
    Title.ZIndex = 2

    -- Tombol Close
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.Parent = TitleBar
    CloseBtn.ZIndex = 2
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 170, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Sidebar.BackgroundTransparency = 0.15
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Sidebar.ZIndex = 1
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -170, 1, -45)
    Content.Position = UDim2.new(0, 170, 0, 45)
    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Content.BackgroundTransparency = 0.25
    Content.BorderSizePixel = 0
    Content.Parent = Main
    Content.ZIndex = 1
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)

    -- drag via titlebar
    makeDraggable(Main, TitleBar)

    return {
        Main = Main,
        Sidebar = Sidebar,
        Content = Content
    }
end

return Library
