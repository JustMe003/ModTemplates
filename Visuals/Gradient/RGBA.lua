
---@class RGBAObject
RGBA = {};
RGBA.__index = RGBA;
RGBA.__tostring = function(c)
    return string.format("{r: %d, g: %d, b: %d, a: %d}", c[1], c[2], c[3], c[4]);
end

---Creates a RGBAObject
---@param r number # Red tone, must be between 0-255 (included)
---@param g number # Green tone, must be between 0-255 (included)
---@param b number # Blue tone, must be between 0-255 (included)
---@param a number? # Transparancy, must be between 0-255 (included)
---@return RGBAObject
local function create(r, g, b, a)
    return setmetatable({r, g, b, a or 0xFF}, RGBA);
end

setmetatable(RGBA, {
    __call = function(_, r, g, b, a)
        return create(r, g, b, a);
    end
});

local function convert(n)
    if n <= 57 then
        return n - 48;
    else
        return n - 55;
    end
end

local function hexToDec(s)
    local n = 0;
    for i, c in ipairs({s:upper():reverse():byte(1, -1)}) do
        n = n + convert(c) * 16^(i - 1);
    end
    return n;
end

---Creates a RGBAObject
---@param r number # Red tone, must be between 0-255 (included)
---@param g number # Green tone, must be between 0-255 (included)
---@param b number # Blue tone, must be between 0-255 (included)
---@param a number? # Transparancy, must be between 0-255 (included). Defaults to 0xFF (255)
---@return RGBAObject
function RGBA:Create(r, g, b, a)
    return create(r, g, b, a);
end

---comment
---@param s string
---@return RGBAObject
function RGBA:FromString(s)
    if #s == 9 then
        return create(hexToDec(s:sub(4, 5)), hexToDec(s:sub(6, 7)), hexToDec(s:sub(8, 9)), hexToDec(s:sub(2, 3)));
    elseif #s == 7 then
        return create(hexToDec(s:sub(2, 3)), hexToDec(s:sub(4, 5)), hexToDec(s:sub(6, 7)), 255);
    else
        print(string.format("%s Wrong string length! Expected length is 7 or 9, got %d", ENCLOSED_LIB_NAME, #s));
        return create(0, 0, 0, 0);
    end
end

---Creates a copy of the RGBAObject
---@return RGBAObject
function RGBA:Copy()
    return create(self[1], self[2], self[3], self[4]);
end