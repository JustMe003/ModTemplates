---@class ColorArray
ColorArray = {};
ColorArray.__index = ColorArray;
ColorArray.__tostring = function(c)
    local s = "ColorArray: [";
    for i = 1, #c - 1 do
        s = s .. tostring(c[i]) .. ", ";
    end
    return s .. tostring(c[#c] or "") .. "]";
end

---Creates a ColorArray object
---@param ... RGBAObject
---@return ColorArray
local function create(...)
    return setmetatable({...}, ColorArray);
end

setmetatable(ColorArray, {
    __call = function(_, ...)
        return create(...);
    end
});

---Creates a ColorArray object
---@param ... RGBAObject
---@return ColorArray
function ColorArray:Create(...)
    return create(...);
end

---Adds RGBAObjects to the ColorArray
---@param ... RGBAObject
---@return ColorArray
function ColorArray:Add(...)
    for _, c in ipairs({...}) do
        table.insert(self, c);
    end
    return self;
end

---Returns the length of the color array
---@return integer
function ColorArray:GetLength()
    return #self;
end

---Copies the color array
---@return ColorArray # Copy of the color array object
function ColorArray:Copy()
    local copy = ColorArray:Create();
    for _, c in ipairs(self) do
        copy:Add(c:Copy());
    end
    return copy;
end