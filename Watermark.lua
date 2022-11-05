local V2 = Vector2.new

if getgenv().WatermarkRemove then
    getgenv().WatermarkRemove()
end

local function newDrawing(type, prop)
    local obj = Drawing.new(type)
    if prop then
        for i,v in next, prop do
            obj[i] = v
        end
    end
    return obj  
end

local Watermark = {
    Border = newDrawing("Square", {
        Visible = true,
        Color = getgenv().Theme.Border,
        Filled = true,
    }),
    Accent = newDrawing("Square", {
        Visible = true,
        Color = getgenv().Theme.Accent,
        Filled = true,
    }),
    Border2 = newDrawing("Square", {
        Visible = true,
        Color = getgenv().Theme.Border2,
        Filled = true,
    }),
    Background = newDrawing("Square", {
        Visible = true,
        Color = getgenv().Theme.Background,
        Filled = true,
    }),
    Gradient = newDrawing("Image", {
        Visible = true,
        Data = getgenv().Theme.Gradient,
        Transparency = 1,
    }),
    Text = newDrawing("Text", {
        Visible = true,
        Color = getgenv().Theme.TextColor,
        OutlineColor = getgenv().Theme.TextOutline,
        Font = getgenv().Theme.Font,
        Size = getgenv().Theme.Size,
        Outline = true,
        Text = "alsike | v2.6 [dev] | FPS: 00 | Ping: 00",
    })
}

local Loop = game:GetService("RunService").RenderStepped:Connect(function(step)
    do
        d
        Watermark.Text.Text = string.formate("%s | v%s [%s] | FPS: %s | Ping: %sms", getgenv().Name, getgenv().Versio, getgenv().Build, math.floor(1/step), math.floor(game:GetService('Stats').Network.ServerStatsItem["Data Ping"]:GetValue()))

        Watermark.Border.Position = V2(10, 10)
        Watermark.Accent.Position = Watermark.Border.Position + V2(1, 1)
        Watermark.Border2.Position = Watermark.Accent.Position + V2(1, 1)
        Watermark.Background.Position = Watermark.Border2.Position + V2(1, 1)
        Watermark.Gradient.Position = Watermark.Border2.Position + V2(1, 1)

        Watermark.Border.Size = V2(Watermark.Text.TextBounds.X + 16, Watermark.Text.TextBounds.Y + 16)
        Watermark.Accent.Size = V2(Watermark.Text.TextBounds.X + 14, Watermark.Text.TextBounds.Y + 14)
        Watermark.Border2.Size = V2(Watermark.Text.TextBounds.X + 12, Watermark.Text.TextBounds.Y + 12)
        Watermark.Background.Size = V2(Watermark.Text.TextBounds.X + 10, Watermark.Text.TextBounds.Y + 10)
        Watermark.Gradient.Size = V2(Watermark.Text.TextBounds.X + 10, Watermark.Text.TextBounds.Y + 10)

        Watermark.Text.Position = Watermark.Background.Position + V2(5, 5)
    end
end)

function WatermarkRemove()
    for i,v in pairs(Watermark) do	
        if v ~= nil then
            v:Remove()
        end
    end

    Loop:Disconnect()
end

getgenv().WatermarkRemove = WatermarkRemove
