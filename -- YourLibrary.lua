-- YourLibrary.lua
-- Custom UI Library mirip Voidware/Fluent

local TweenService = game:GetService("TweenService")

local Library = {}

-- === Create Window ===
function Library:CreateWindow(title, subtitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Name = "YourLibrary"

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

    -- Titlebar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
    TitleBar.Parent = Main
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)
    TitleBar.Active = true
    TitleBar.Draggable = true

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = title .. " - " .. (subtitle or "")
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = TitleBar

    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Parent = TitleBar
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Minimize button
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 30, 1, 0)
    MinBtn.Position = UDim2.new(1, -70, 0, 0)
    MinBtn.Text = "-"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 14
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Parent = TitleBar

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Main.Size = minimized and UDim2.new(0, 600, 0, 40) or UDim2.new(0, 600, 0, 400)
    end)

    -- fungsi drag
local UIS = game:GetService("UserInputService")
local dragToggle, dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
        updateInput(input)
    end
end)


    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 150, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(35, 39, 55)
    Sidebar.Parent = Main

    local SidebarList = Instance.new("UIListLayout")
    SidebarList.Padding = UDim.new(0, 5)
    SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarList.Parent = Sidebar

    -- Content Area
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -150, 1, -40)
    Content.Position = UDim2.new(0, 150, 0, 40)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    -- Tabs Storage
    local Tabs = {}

    function Library:AddTab(tabName)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -10, 0, 30)
        Button.Position = UDim2.new(0, 5, 0, 0)
        Button.Text = tabName
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.TextColor3 = Color3.fromRGB(220, 220, 220)
        Button.BackgroundColor3 = Color3.fromRGB(45, 49, 65)
        Button.Parent = Sidebar
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 4
        TabPage.Visible = false
        TabPage.Parent = Content

        local UIList = Instance.new("UIListLayout")
        UIList.Padding = UDim.new(0, 10)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Parent = TabPage

        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingTop = UDim.new(0, 10)
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.PaddingRight = UDim.new(0, 10)
        UIPadding.Parent = TabPage

        Tabs[tabName] = TabPage
        Button.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Visible = false end
            TabPage.Visible = true
        end)

        local Tab = {}

        -- === Add Section ===
        function Tab:AddSection(title)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 25)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabPage

            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, 0, 1, 0)
            SectionLabel.Text = title
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextSize = 14
            SectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = SectionFrame

            return Tab
        end

        -- === Add Button ===
        function Tab:AddButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 35)
            Btn.Text = text
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            Btn.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
            Btn.Parent = TabPage
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        -- === Add Toggle ===
        function Tab:AddToggle(text, default, callback)
            local Toggle = Instance.new("Frame")
            Toggle.Size = UDim2.new(1, -10, 0, 35)
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
            Toggle.Parent = TabPage
            Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -40, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(230, 230, 230)
            Label.BackgroundTransparency = 1
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Toggle

            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 20, 0, 20)
            Button.Position = UDim2.new(1, -30, 0.5, -10)
            Button.BackgroundColor3 = default and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
            Button.Text = ""
            Button.Parent = Toggle
            Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)

            local state = default
            Button.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(100,100,100)
                }):Play()
                pcall(callback, state)
            end)
        end

        -- === Add Dropdown ===
        function Tab:AddDropdown(text, list, default, callback)
            local Dropdown = Instance.new("Frame")
            Dropdown.Size = UDim2.new(1, -10, 0, 40)
            Dropdown.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
            Dropdown.Parent = TabPage
            Instance.new("UICorner", Dropdown).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.5, -10, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(230, 230, 230)
            Label.BackgroundTransparency = 1
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Dropdown

            local DropButton = Instance.new("TextButton")
            DropButton.Size = UDim2.new(0.5, -20, 1, -10)
            DropButton.Position = UDim2.new(0.5, 10, 0, 5)
            DropButton.Text = default or "Select..."
            DropButton.Font = Enum.Font.Gotham
            DropButton.TextSize = 14
            DropButton.TextColor3 = Color3.fromRGB(230, 230, 230)
            DropButton.BackgroundColor3 = Color3.fromRGB(40, 44, 60)
            DropButton.Parent = Dropdown
            Instance.new("UICorner", DropButton).CornerRadius = UDim.new(0, 6)

            DropButton.MouseButton1Click:Connect(function()
                for _, option in ipairs(list) do
                    DropButton.Text = option
                    pcall(callback, option)
                    break -- simple dropdown
                end
            end)
        end

        return Tab
    end

    return Library
end

return Library

