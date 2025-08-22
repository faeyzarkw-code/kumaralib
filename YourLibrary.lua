-- YourLibrary.lua (versi dengan Toggle, Slider, TextBox, dan tema simpel)
local Library = {}
Library.__index = Library

-- Default theme settings (bisa di-overwrite)
Library.Theme = {
    WindowBg = Color3.fromRGB(30, 30, 30),
    TabBg = Color3.fromRGB(25, 25, 25),
    ContentBg = Color3.fromRGB(40, 40, 40),
    ButtonBg = Color3.fromRGB(70, 70, 70),
    TextColor = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 170, 255)
}

function Library:SetTheme(theme)
    for k, v in pairs(theme) do
        self.Theme[k] = v
    end
end

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = self.Theme.WindowBg
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = self.Theme.TextColor
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = MainFrame

    local TabHolder = Instance.new("Frame")
    TabHolder.Size = UDim2.new(0, 120, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.BackgroundColor3 = self.Theme.TabBg
    TabHolder.Parent = MainFrame

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -120, 1, -40)
    ContentFrame.Position = UDim2.new(0, 120, 0, 40)
    ContentFrame.BackgroundColor3 = self.Theme.ContentBg
    ContentFrame.Parent = MainFrame

    local Window = {Main = MainFrame, Tabs = {}, Content = ContentFrame, TabHolder = TabHolder}
    setmetatable(Window, Library)
    return Window
end

function Library:AddTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundColor3 = self.Theme.ButtonBg
    TabButton.TextColor3 = self.Theme.TextColor
    TabButton.Text = tabName
    TabButton.Parent = self.TabHolder

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = self.Content

    TabButton.MouseButton1Click:Connect(function()
        for _, v in ipairs(self.Content:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        TabContent.Visible = true
    end)

    local Tab = {Content = TabContent}
    table.insert(self.Tabs, Tab)
    return Tab
end

function Library:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 30)
    Button.BackgroundColor3 = self.Theme.ButtonBg
    Button.TextColor3 = self.Theme.TextColor
    Button.Text = text
    Button.Parent = tab.Content
    Button.MouseButton1Click:Connect(function() if callback then callback() end end)
end

function Library:AddToggle(tab, text, default, callback)
    local toggle = default and true or false

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 200, 0, 30)
    Container.BackgroundTransparency = 1
    Container.Parent = tab.Content

    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.TextColor3 = self.Theme.TextColor
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0.3, -5, 1, 0)
    Switch.Position = UDim2.new(0.7, 5, 0, 0)
    Switch.BackgroundColor3 = toggle and self.Theme.Accent or self.Theme.ButtonBg
    Switch.Text = toggle and "ON" or "OFF"
    Switch.TextColor3 = self.Theme.TextColor
    Switch.Parent = Container

    Switch.MouseButton1Click:Connect(function()
        toggle = not toggle
        Switch.Text = toggle and "ON" or "OFF"
        Switch.BackgroundColor3 = toggle and self.Theme.Accent or self.Theme.ButtonBg
        if callback then callback(toggle) end
    end)
end

function Library:AddSlider(tab, text, min, max, default, callback)
    local dragging = false
    local value = math.clamp(default or min, min, max)

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 200, 0, 50)
    Container.BackgroundTransparency = 1
    Container.Parent = tab.Content

    local Label = Instance.new("TextLabel")
    Label.Text = text.." ("..value..")"
    Label.TextColor3 = self.Theme.TextColor
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local Bg = Instance.new("Frame")
    Bg.Size = UDim2.new(1, 0, 0, 10)
    Bg.Position = UDim2.new(0, 0, 0, 25)
    Bg.BackgroundColor3 = self.Theme.ButtonBg
    Bg.Parent = Container

    local Thumb = Instance.new("Frame")
    Thumb.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    Thumb.BackgroundColor3 = self.Theme.Accent
    Thumb.Parent = Bg

    Bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    Bg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    Bg.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - Bg.AbsolutePosition.X) / Bg.AbsoluteSize.X, 0, 1)
            value = min + rel * (max - min)
            Thumb.Size = UDim2.new(rel, 0, 1, 0)
            Label.Text = text.." ("..math.floor(value*100)/100..")"
            if callback then callback(value) end
        end
    end)
end

function Library:AddTextBox(tab, placeholder, callback)
    local TextBox = Instance.new("TextBox")
    TextBox.PlaceholderText = placeholder
    TextBox.TextColor3 = self.Theme.TextColor
    TextBox.BackgroundColor3 = self.Theme.ButtonBg
    TextBox.Size = UDim2.new(0, 200, 0, 30)
    TextBox.Parent = tab.Content

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(TextBox.Text)
        end
    end)
end

return Library
