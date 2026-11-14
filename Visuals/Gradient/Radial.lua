require("Visuals.Gradient.Gradient");
require("Visuals.Gradient.MinMax");
require("Visuals.Visuals");


---@class GradientRadial: Gradient
GradientRadial = {};
GradientRadial.__index = GradientRadial;

setmetatable(GradientRadial, {
    __index = Gradient;
    __call = getmetatable(Gradient).__call;
});

---Creates a radial gradient. Use `GradientRadial:Create()` or `GradientRadial()` to create a radial gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientRadial
---@private
function GradientRadial:New(c1, c2)
    Gradient.New(self, c1, c2);
    return self;
end

---Creates a radial gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientRadial
function GradientRadial:Create(c1, c2)
    return GradientRadial(c1, c2);
end

---Returns the gradient colors for the passed VisualObject
---@param obj VisualObject
---@return ColorArray
function GradientRadial:GetColors(obj)
    local vertices = obj:GetVertices();
    
    local minMaxX = MinMax();
    local minMaxY = MinMax();
    local minMaxZ = MinMax();
    for _, v in ipairs(vertices) do
        minMaxX:Comp(v:GetX());
        minMaxY:Comp(v:GetY());
        minMaxZ:Comp(v:GetZ());
    end

    local midX = (minMaxX:GetMax() - minMaxX:GetMin()) / 2 + minMaxX:GetMin();
    local midY = (minMaxY:GetMax() - minMaxY:GetMin()) / 2 + minMaxY:GetMin();
    local midZ = (minMaxZ:GetMax() - minMaxZ:GetMin()) / 2 + minMaxZ:GetMin();
    local maxDistance = math.sqrt((minMaxX:GetMax() - midX)^2 + (minMaxY:GetMax() - midY)^2 + (minMaxZ:GetMax() - midZ)^2);
    local colors = ColorArray();
    for _, v in ipairs(vertices) do
        colors:Add(self:GetGradient(math.sqrt((v:GetX() - midX)^2 + (v:GetY() - midY)^2 + (v:GetZ() - midZ)^2) / maxDistance));
    end
    return colors;
end