-- Library UI mirip Voidware (abu-abu style)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Library = {}

-- fungsi drag
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
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundTransparency = 1 -- biar nggak nutup blur
    Main.BorderSizePixel = 0
    Main.ZIndex = 1
    Main.Parent = ScreenGui
    
    -- Blur background
    local blur = Instance.new("ImageLabel")
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundTransparency = 1
    blur.Image = "rbxassetid://8992230677"
    blur.ImageTransparency = 0.3 -- lebih solid, keliatan blur
    blur.ScaleType = Enum.ScaleType.Tile
    blur.TileSize = UDim2.new(0, 200, 0, 200)
    blur.ZIndex = 0
    blur.Parent = Main
    
    -- Rounded corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = Main


    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    TitleBar.Parent = Main

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title or "Kumara Hub"
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 16
    TitleText.TextColor3 = Color3.fromRGB(220, 220, 220)
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar

    -- Tombol Close
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 40, 1, 0)
    Close.Position = UDim2.new(1, -40, 0, 0)
    Close.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 16
    Close.Parent = TitleBar
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Sidebar kiri
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 150, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Sidebar.Parent = Main

    -- Content kanan
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -150, 1, -40)
    Content.Position = UDim2.new(0, 150, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Content.Parent = Main

    -- draggable
    makeDraggable(Main, TitleBar)

    return {
        Sidebar = Sidebar,
        Content = Content
    }
end

return Library




