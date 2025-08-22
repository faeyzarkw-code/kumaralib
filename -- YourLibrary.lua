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

    -- Tombol Close
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.ZIndex = 3
    CloseBtn.Parent = TitleBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Tombol Minimize
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 25, 0, 25)
    MinBtn.Position = UDim2.new(1, -60, 0, 7)
    MinBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 250)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.ZIndex = 3
    MinBtn.Parent = TitleBar
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
    
    -- Status minimize
    local isMinimized = false
    
    -- Tween configs
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tweenMinimize = TweenService:Create(Main, tweenInfo, { Size = UDim2.new(0, 650, 0, 40) })
    local tweenRestore = TweenService:Create(Main, tweenInfo, { Size = UDim2.new(0, 650, 0, 420) })

    
    -- Sidebar (taruh ini dulu baru bikin fungsi minimize)
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 170, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Sidebar.ZIndex = 1
    
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
    
    -- Baru tambahin fungsi minimize setelah Sidebar & Content ada
    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Sidebar.Visible = false
            Content.Visible = false
            Main.Size = UDim2.new(0, 250, 0, 40) -- shrink biar cuma titlebar
        else
            Sidebar.Visible = true
            Content.Visible = true
            Main.Size = UDim2.new(0, 650, 0, 420) -- balikin ukuran normal
        end
    end)


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







