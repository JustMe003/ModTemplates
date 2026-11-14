require("Visuals.Util");
require("Visuals.Animation.Animation");

---@class ColorAnimation: Animation
---@field Colors RGBAObject | RGBAObject[]
ColorAnimation = {};
ColorAnimation.__index = ColorAnimation

setmetatable(ColorAnimation, {
    __index = Animation;
    __call = getmetatable(Animation).__call;
});

---Creates a ColorAnimation. Use `ColorAnimation:Create()` or `ColorAnimation()` to create a color animation object
---@param color VisualColor | VisualColor[]
---@return ColorAnimation
---@private
function ColorAnimation:New(color)
    Animation.New(self, Matrix4D());
    if type(color) == "string" then
        self.Colors = RGBA:FromString(color);
    else
        self.Colors = color;
    end
    return self;
end

---Creates a ColorAnimation
---@param color VisualColor | VisualColor[]
---@return ColorAnimation
function ColorAnimation:Create(color)
    return ColorAnimation(color);
end

function ColorAnimation:Interpolate(t)
    return self.Transformation;
end