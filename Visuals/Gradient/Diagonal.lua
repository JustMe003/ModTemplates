require("Visuals.Gradient.Gradient");
require("Visuals.Gradient.MinMax");
require("Visuals.Visuals");


---@class GradientDiagonal: Gradient
GradientDiagonal = {};
GradientDiagonal.__index = GradientDiagonal;

setmetatable(GradientDiagonal, {
    __index = Gradient;
    __call = getmetatable(Gradient).__call;
})

---Creates a diagonal gradient. Use `GradientDiagonal:Create()` or `GradientDiagonal()` to create a diagonal gradient object
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientDiagonal
---@private
function GradientDiagonal:New(c1, c2)
    Gradient.New(self, c1, c2);
    return self
end

---Creates a diagonal gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color
---@return GradientDiagonal
function GradientDiagonal:Create(c1, c2)
    return GradientDiagonal(c1, c2);
end

---Returns the gradient colors for the passed VisualObject
---@param obj VisualObject
---@return ColorArray
function GradientDiagonal:GetColors(obj)
    local vertices = obj:GetVertices();
    
    local minMaxX = MinMax();
    local minMaxY = MinMax();
    local minMaxZ = MinMax();
    for _, v in ipairs(vertices) do
        minMaxX:Comp(v:GetX());
        minMaxY:Comp(v:GetY());
        minMaxZ:Comp(v:GetZ());
    end

    local minX = minMaxX:GetMin();
    local minY = minMaxY:GetMin();
    local minZ = minMaxZ:GetMin();
    local offset = math.sqrt((minMaxX:GetMax() - minX)^2 + (minMaxY:GetMax() - minY)^2 + (minMaxZ:GetMax() - minZ)^2);
    local colors = ColorArray();
    for _, v in ipairs(vertices) do
        colors:Add(self:GetGradient(math.sqrt((v:GetX() - minX)^2 + (v:GetY() - minY)^2 + (v:GetZ() - minZ)) / offset))
    end
    return colors;
end
