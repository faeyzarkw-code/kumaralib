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
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TitleBar.BorderSizePixel = 0
    TitleBar.BackgroundTransparency = 0
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
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.ZIndex = 3
    CloseBtn.Parent = TitleBar
    CloseBtn.TextScaled = true
    CloseBtn.AutoButtonColor = true
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Tombol Minimize
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 25, 0, 25)
    MinBtn.Position = UDim2.new(1, -60, 0, 7)
    MinBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.ZIndex = 3
    MinBtn.Parent = TitleBar
    CloseBtn.TextScaled = true
    CloseBtn.AutoButtonColor = true

    btn.TextXAlignment = Enum.TextXAlignment.Left
    local padding = Instance.new("UIPadding")
    padding.Parent = btn
    padding.PaddingLeft = UDim.new(0, 15)

    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 170, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Sidebar.ZIndex = 1

    local list = Instance.new("UIListLayout", Sidebar)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 5)
    
local function createCard(parent, title, desc)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, -20, 0, 120)
    Card.Position = UDim2.new(0, 10, 0, 10)
    Card.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Card.BackgroundTransparency = 0.1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", Card)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 8)
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(230,230,230)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Desc = Instance.new("TextLabel", Card)
    Desc.Size = UDim2.new(1, -20, 0, 50)
    Desc.Position = UDim2.new(0, 10, 0, 40)
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(180,180,180)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 13
    Desc.BackgroundTransparency = 1
    Desc.TextWrapped = true
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
end

    
-- fungsi buat tombol sidebar dengan highlight
local function createSidebarButton(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -15, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.BackgroundTransparency = 0.3
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    -- padding kiri
    local padding = Instance.new("UIPadding")
    padding.Parent = btn
    padding.PaddingLeft = UDim.new(0, 12)

    -- hover animasi
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55,55,65)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30,30,35)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(callback)

    return btn
end

local function createCategory(name, parent)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -15, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(150,150,150)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = parent

    local padding = Instance.new("UIPadding")
    padding.Parent = label
    padding.PaddingLeft = UDim.new(0, 8)
end


-- fungsi buat tombol toggle gaya Voidware
local function createToggle(parent, text, callback)
    local Holder = Instance.new("Frame", parent)
    Holder.Size = UDim2.new(1,-20,0,40)
    Holder.Position = UDim2.new(0,10,0,0)
    Holder.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1,-60,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(230,230,230)

    local ToggleBtn = Instance.new("Frame", Holder)
    ToggleBtn.Size = UDim2.new(0,45,0,22)
    ToggleBtn.Position = UDim2.new(1,-50,0.5,-11)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame", ToggleBtn)
    Knob.Size = UDim2.new(0,18,0,18)
    Knob.Position = UDim2.new(0,2,0.5,-9)
    Knob.BackgroundColor3 = Color3.fromRGB(200,200,200)
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local State = false
    local function setToggle(newState)
        State = newState
        if State then
            TweenService:Create(ToggleBtn, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(60,200,120)
            }):Play()
            TweenService:Create(Knob, TweenInfo.new(0.25), {
                Position = UDim2.new(1,-20,0.5,-9),
                BackgroundColor3 = Color3.fromRGB(255,255,255)
            }):Play()
        else
            TweenService:Create(ToggleBtn, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(60,60,60)
            }):Play()
            TweenService:Create(Knob, TweenInfo.new(0.25), {
                Position = UDim2.new(0,2,0.5,-9),
                BackgroundColor3 = Color3.fromRGB(200,200,200)
            }):Play()
        end
        callback(State)
    end

    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            setToggle(not State)
        end
    end)
end

local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(1, -10, 0, 35) -- full panjang
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.AutoButtonColor = true
    button.BorderSizePixel = 0
    button.BackgroundTransparency = 0.1
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    -- biar ada padding kiri
    local padding = Instance.new("UIPadding")
    padding.Parent = button
    padding.PaddingLeft = UDim.new(0, 10)

    -- icon di kanan
    local icon = Instance.new("ImageLabel")
    icon.Parent = button
    icon.AnchorPoint = Vector2.new(1, 0.5)
    icon.Position = UDim2.new(1, -10, 0.5, 0)
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://7072706625" -- contoh icon, bisa diganti

    -- action kalau di klik
    button.MouseButton1Click:Connect(function()
        callback()
    end)

    return button
end




    -- contoh isi sidebar
    createSidebarButton("Home", function()
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

    createSidebarButton("Farming", function()
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

    -- Auto Buy logic
    local RS = game:GetService("ReplicatedStorage")
    local EventShop = RS.NetworkContainer.RemoteEvents.EventShop
    local boxes = {"Common Box", "Rare Box", "Epic Box", "Legendary Box"}
    local autoBuy = false

-- Auto Buy tab di sidebar
createSidebarButton("Auto Buy", function()
    Content:ClearAllChildren()

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Content

    -- panggil toggle switch gaya Voidware
    createToggle(Content, "Auto Buy Event Box", function(state)
        autoBuy = state
    end)


createButton(Content, "Open Unlock Box", function()
    task.spawn(function()
        local prompt
        for i = 1, 20 do -- coba maksimal 20x (2 detik total)
            prompt = workspace:FindFirstChild("Event") 
                     and workspace.Event:FindFirstChild("Unlock Box") 
                     and workspace.Event["Unlock Box"]:FindFirstChild("OpenKeyMaster")
            if prompt then break end
            task.wait(0.1)
        end

        if prompt then
            pcall(function()
                fireproximityprompt(prompt)
            end)
        else
            warn("⚠️ Prompt Unlock Box ga ketemu setelah 2 detik.")
        end
    end)
end)

end)



    -- Loop Auto Buy
    task.spawn(function()
        while true do
            if autoBuy then
                for _, box in ipairs(boxes) do
                    for i = 1, 4 do
                        EventShop:FireServer(box)
                        print(">> Membeli:", box, "ke-", i)
                        task.wait(0.2)
                    end
                end
                print("✅ Selesai beli semua box, tunggu 2 menit...")
                task.wait(120)
            else
                task.wait(1)
            end
        end
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

