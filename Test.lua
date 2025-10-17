if not isfile("epstein.png") then
    writefile("epstein.png", game:HttpGet("https://github.com/krampus-organization/Division/blob/main/1.png?raw=true"))
end

local sgui = Instance.new("ScreenGui", gethui())
local image = Instance.new("ImageLabel", sgui)
image.Position = UDim2.new(0.5, 0, 0.5, 0)
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Size = UDim2.new(0, 464, 0, 277)
image.Image = getcustomasset("epstein.png")
