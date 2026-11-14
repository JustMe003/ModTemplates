require("Visuals.Util");
require("Visuals.Animation.Animation");

---@class MoveAnimation: Animation
MoveAnimation = {};
MoveAnimation.__index = MoveAnimation

setmetatable(MoveAnimation, {
    __index = Animation;
    __call = getmetatable(Animation).__call;
});

---Creates a move animation. Use `MoveAnimation:Create()` or `MoveAnimation()` to create a move animation object
---@param x number # Amount of units to move along the X-axis
---@param y number? # Amount of units to move along the Y-axis. Defaults to 0
---@param z number? # Amount of units to move along the Z-axis. Defaults to 0
---@return MoveAnimation
---@private
function MoveAnimation:New(x, y, z)
    Animation.Create(self, Matrix4D(1, 0, 0, x, 0, 1, 0, y or 0, 0, 0, 1, z or 0));
    return self;
end

---Creates a move animation
---@param x number # Amount of units to move along the X-axis
---@param y number? # Amount of units to move along the Y-axis. Defaults to 0
---@param z number? # Amount of units to move along the Z-axis. Defaults to 0
---@return MoveAnimation
function MoveAnimation:Create(x, y, z)
    return MoveAnimation(x, y, z);
end