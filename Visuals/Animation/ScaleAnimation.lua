require("Visuals.Util");
require("Visuals.Animation.Animation");

---@class ScaleAnimation: Animation
ScaleAnimation = {};
ScaleAnimation.__index = ScaleAnimation

setmetatable(ScaleAnimation, {
    __index = Animation;
    __call = getmetatable(Animation).__call;
});

---Creates a scaling animation. Use `ScaleAnimation:Create()` or `ScaleAnimation` to create a scaling animation
---@param x number # Scaling multiplier relative to the X-axis
---@param y number # Scaling multiplier relative to the Y-axis. Defaults to 1
---@param z number # Scaling multiplier relative to the Z-axis. Defaults to 1
---@return ScaleAnimation
---@private
function ScaleAnimation:New(x, y, z)
    Animation.Create(self, Matrix4D(x, 0, 0, 0, 0, y or 1, 0, 0, 0, 0, z or 1));
    return self;
end

---Creates a scaling animation
---@param x number # Scaling multiplier relative to the X-axis
---@param y number # Scaling multiplier relative to the Y-axis. Defaults to 1
---@param z number # Scaling multiplier relative to the Z-axis. Defaults to 1
---@return ScaleAnimation
function ScaleAnimation:Create(x, y, z)
    return ScaleAnimation(x, y, z);
end