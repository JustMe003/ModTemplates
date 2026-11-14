---@class MinMax
---@field Min number # Minimum of all compared numbers
---@field Max number # Maximum of all compared numbers
MinMax = {};
MinMax.__index = MinMax;

setmetatable(MinMax, {
    __call = function(_)
        return setmetatable({}, MinMax);
    end
});

---Creates a MinMax object
---@return MinMax
function MinMax:Create()
    return MinMax();
end

---Compares the number against the already recorded minimum and maximum. Updates the minimum and maximum accordingly
---@param n number
function MinMax:Comp(n)
    self.Min = math.min(self.Min or n, n);
    self.Max = math.max(self.Max or n, n);
end

---Returns the maximum recorded number
---@return number
function MinMax:GetMax()
    return self.Max or 0;
end

---Returns the minimum recorded number
---@return number
function MinMax:GetMin()
    return self.Min or 0;
end