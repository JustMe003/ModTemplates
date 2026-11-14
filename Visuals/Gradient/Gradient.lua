require("Visuals.Gradient.RGBA");

---@param class Gradient
---@return Gradient
local function create(class, ...)
    local self = setmetatable({}, class);
    ---@diagnostic disable-next-line: invisible
    self:New(...);      
    return self;
end

---@class Gradient
---@field FirstColor RGBAObject
---@field SecondColor RGBAObject
Gradient = {};
Gradient.__index = Gradient;

setmetatable(Gradient, {
    __call = function(class, ...)
        return create(class, ...);
    end;
    __add = ConcatTables;
});

---Creates a gradient. Use `Gradient:Create()` or `Gradient` to create a gradient object
---@param c1 VisualColor # First color
---@param c2 VisualColor # Second color, defaults to white
---@return Gradient
---@private
function Gradient:New(c1, c2)
    c2 = c2 or RGBA(0, 0, 0, 0xFF);
    if type(c1) == "string" then c1 = RGBA:FromString(c1); end
    if type(c2) == "string" then c2 = RGBA:FromString(c2); end
    self.FirstColor = c1;
    self.SecondColor = c2;
    return self;
end

---Creates a gradient
---@param c1 VisualColor # First color
---@param c2 VisualColor? # Second color, defaults to white
---@return Gradient
function Gradient:Create(c1, c2)
    return Gradient(c1, c2);
end

---Applies the gradient to the VisualObject
---@generic T: Gradient
---@param self T
---@param obj VisualObject
---@return T
function Gradient:Apply(obj)
    obj:SetColors(self:GetColors(obj));
    return self;
end

---Returns the gradient color based on p
---@param p number # Percentage of the colors to use
---@return RGBAObject
function Gradient:GetGradient(p)
    return RGBA(
        ((1 - math.cos(math.pi * (1 - p))) * self.FirstColor[1] + (1 - math.cos(math.pi * p)) * self.SecondColor[1]) / 2,
        ((1 - math.cos(math.pi * (1 - p))) * self.FirstColor[2] + (1 - math.cos(math.pi * p)) * self.SecondColor[2]) / 2,
        ((1 - math.cos(math.pi * (1 - p))) * self.FirstColor[3] + (1 - math.cos(math.pi * p)) * self.SecondColor[3]) / 2,
        ((1 - math.cos(math.pi * (1 - p))) * self.FirstColor[4] + (1 - math.cos(math.pi * p)) * self.SecondColor[4]) / 2
    );
end