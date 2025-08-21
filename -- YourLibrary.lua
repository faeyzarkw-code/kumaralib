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

function Library:CreateWindow(title, version)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Name = "KumaraLibrary"

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 650, 0, 420)
    Main.Position = UDim2.new(0.5, -325, 0.5, -210)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Main.BorderSizePixel = 0
    Main.ZIndex = 1
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    -- TitleBar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    TitleBar.ZIndex = 2

    -- Judul
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(235, 235, 235)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.Parent = TitleBar
    Title.ZIndex = 2

    -- Version
    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(0, 90, 1, 0)
    Version.Position = UDim2.new(1, -95, 0, 0)
    Version.BackgroundTransparency = 1
    Version.Text = version or "v1.0.0"
    Version.TextColor3 = Color3.fromRGB(170, 170, 170)
    Version.Font = Enum.Font.Gotham
    Version.TextSize = 12
    Version.TextXAlignment = Enum.TextXAlignment.Right
    Version.Parent = TitleBar
    Version.ZIndex = 2

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 170, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Sidebar.ZIndex = 1
    
    -- layout biar button tab turun kebawah
    local list = Instance.new("UIListLayout", Sidebar)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 5)

    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -170, 1, -40)
    Content.Position = UDim2.new(0, 170, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Content.BorderSizePixel = 0
    Content.Parent = Main
    Content.ZIndex = 1
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

    -- fungsi buat tombol sidebar
    local function createSidebarButton(name, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundTransparency = 1
        btn.Text = name
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextSize = 14
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = Sidebar
        btn.LayoutOrder = #Sidebar:GetChildren()  -- << ini buat urut

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200,200,200)}):Play()
        end)

        btn.MouseButton1Click:Connect(callback)

        return btn
    end

    -- contoh isi sidebar
    local HomeBtn = createSidebarButton("Home", function()
        Content:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.Text = "Home Content"
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.Parent = Content
    end)

    local FarmingBtn = createSidebarButton("Farming", function()
        Content:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.Text = "Farming Content"
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.Parent = Content
    end)

    -- drag
    makeDraggable(Main, TitleBar)

    return {
        Main = Main,
        Sidebar = Sidebar,
        Content = Content
    }
end

return Library

