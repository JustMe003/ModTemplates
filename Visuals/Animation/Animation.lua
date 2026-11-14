require("Visuals.Math.Matrix4D");

---@class Animation
---@field Transformation Matrix4D
---@field Start number
---@field End number
Animation = {};
Animation.__index = Animation;

setmetatable(Animation, {
    __call = function (class, ...)
        local self = setmetatable({}, class);
        self:New(...);
        return self;
    end
})

---Creates an animation. Use `Animation:Create` or `Animation` to create an animation object
---@param mat Matrix4D # Transformation matrix
---@param start number # The start of this animation. Must be between [0, 1], defaults to 0
---@param fin number # The end of this animation. Must be between [0, 1], defaults to 1
---@return Animation
---@private
function Animation:New(mat, start, fin)
    self.Transformation = mat;
    self.Start = start or 0;
    self.End = fin or 1;
    return self;
end

---Creates an animation. Use `Animation:Create` or `Animation` to create an animation object
---@param mat Matrix4D # Transformation matrix
---@param start number # The start of this animation. Must be between [0, 1], defaults to 0
---@param fin number # The end of this animation. Must be between [0, 1], defaults to 1
---@return Animation
function Animation:Create(mat, start, fin)
    return Animation(mat, start, fin);
end

---Updates the start of this animation
---@param t number # The start of this animation. Must be between [0, 1]
---@return Animation
function Animation:SetStart(t)
    self.Start = t;
    return self;
end

---Updates the end of this animation
---@param t number # The end of this animation. Must be between [0, 1]
---@return Animation
function Animation:SetEnd(t)
    self.End = t;
    return self;
end

---Calculates the transformation matrix based on p (percentage). 
---@param p number # The percentage of the animation 
---@return Matrix4D
function Animation:Interpolate(p)
    if p == 0 then 
        return Matrix4D(); 
    elseif p == 1 then 
        return self.Transformation;
    else
        local iMat = Matrix4D();
        return self.Transformation:Copy():SubtractMatrix(iMat):MultNumber(p):AddMatrix(iMat);
    end
end