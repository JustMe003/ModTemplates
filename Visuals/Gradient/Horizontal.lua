require("Visuals.Gradient.Gradient");
require("Visuals.Gradient.MinMax");
require("Visuals.Visuals");


---@class GradientHorizontal: Gradient
GradientHorizontal = {};
GradientHorizontal.__index = GradientHorizontal;

setmetatable(GradientHorizontal, {
    __index = Gradient;
    __call = getmetatable(Gradient).__call;
})

---Creates a horizontal gradient. Use `GradientHorizontal:Create()` or `GradientHorizontal()` to create a horizontal gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientHorizontal
---@private
function GradientHorizontal:New(c1, c2)
    Gradient.New(self, c1, c2);
    return self;
end

---Creates a horizontal gradient object
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientHorizontal
function GradientHorizontal:Create(c1, c2)
    return GradientHorizontal(c1, c2);
end

---Returns the gradient colors for the passed VisualObject
---@param obj VisualObject
---@return ColorArray
function GradientHorizontal:GetColors(obj)
    local vertices = obj:GetVertices();
    
    local minMaxX = MinMax();
    for _, v in ipairs(vertices) do
        minMaxX:Comp(v:GetX());
    end

    local minX = minMaxX:GetMin();
    local offset = minMaxX:GetMax() - minX;
    local colors = ColorArray();
    for _, v in ipairs(vertices) do
        local x = v:GetX();
        colors:Add(self:GetGradient((x - minX) / offset))
    end
    return colors;
end
