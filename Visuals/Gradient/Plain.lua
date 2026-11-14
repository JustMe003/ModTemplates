require("Visuals.Gradient.Gradient");
require("Visuals.Visuals");


---@class Plain: Gradient
GradientPlain = {};
GradientPlain.__index = GradientPlain;

setmetatable(GradientPlain, {
    __index = Gradient;
    __call = getmetatable(Gradient).__call;
});

---Creates a plain gradient. Use `GradientPlain:Create()` or `GradientPlain()` to create a plain gradient 
---@param c VisualColor # The color
---@return Plain
function GradientPlain:New(c)
    Gradient.New(self, c, c);
    return self;
end

---Creates a plain gradient
---@param c VisualColor # The color
---@return Plain
function GradientPlain:Create(c)
    return GradientPlain(c);
end


---Returns the gradient colors for the passed VisualObject
---@param obj VisualObject
---@return ColorArray
function GradientPlain:GetColors(obj)
    local colors = ColorArray();
    for _, _ in ipairs(obj.Vertices) do
        colors:Add(self.FirstColor:Copy());
    end
    return colors;
end