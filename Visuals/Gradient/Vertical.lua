require("Visuals.Gradient.Gradient");
require("Visuals.Gradient.MinMax");
require("Visuals.Visuals");


---@class GradientVertical: Gradient
GradientVertical = {};
GradientVertical.__index = GradientVertical;

setmetatable(GradientVertical, {
    __index = Gradient;
    __call = getmetatable(Gradient).__call;
})

---Creates a vertical gradient. Use `GradientVertical:Create()` or `GradientVertical()` to create a vertical gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientVertical
---@private
function GradientVertical:New(c1, c2)
    Gradient.New(self, c1, c2);
    return self;
end

---Creates a vertical gradient
---@param c1 VisualColor
---@param c2 VisualColor
---@return GradientVertical
function GradientVertical:Create(c1, c2)
    return GradientVertical(c1, c2);
end

---Returns the gradient colors for the passed VisualObject
---@param obj VisualObject
---@return ColorArray
function GradientVertical:GetColors(obj)
    local vertices = obj:GetVertices();
    
    local minMaxY = MinMax();
    for _, v in ipairs(vertices) do
        minMaxY:Comp(v:GetY());
    end

    local minY = minMaxY:GetMin();
    local offset = minMaxY:GetMax() - minY;
    local colors = ColorArray();
    for _, v in ipairs(vertices) do
        local y = v:GetY();
        colors:Add(self:GetGradient((y - minY) / offset))
    end
    return colors;
end
