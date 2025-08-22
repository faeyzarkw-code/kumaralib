-- Library GUI mirip Rayfield (versi simple)
local Library = {}
Library.__index = Library

-- Fungsi buat bikin window utama
function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = MainFrame

    local TabHolder = Instance.new("Frame")
    TabHolder.Size = UDim2.new(0, 100, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHolder.Parent = MainFrame

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -100, 1, -40)
    ContentFrame.Position = UDim2.new(0, 100, 0, 40)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ContentFrame.Parent = MainFrame

    local Window = {
        Main = MainFrame,
        Tabs = {},
        Content = ContentFrame,
        TabHolder = TabHolder
    }
    setmetatable(Window, Library)

    return Window
end

-- Fungsi buat tambah tab
function Library:AddTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Text = tabName
    TabButton.Parent = self.TabHolder

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.CanvasSize = UDim2.new(0,0,0,0)
    TabContent.Visible = false
    TabContent.BackgroundTransparency = 1
    TabContent.Parent = self.Content

    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(self.Content:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        TabContent.Visible = true
    end)

    local Tab = {
        Content = TabContent
    }

    table.insert(self.Tabs, Tab)
    return Tab
end

-- Fungsi buat tambah button di tab
function Library:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = text
    Button.Parent = tab.Content

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
end

-- Contoh Pemakaian
local MyUI = Library:CreateWindow("My Custom UI")

local Tab1 = MyUI:AddTab("Main")
local Tab2 = MyUI:AddTab("Settings")

MyUI:AddButton(Tab1, "Click Me!", function()
    print("Button clicked!")
end)

MyUI:AddButton(Tab2, "Another Button", function()
    print("Settings button clicked!")
end)
