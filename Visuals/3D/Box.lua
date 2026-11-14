require("Visuals.Visuals");

---@class Box: VisualObject
---@field Width number
---@field Length number
---@field Height number
Box = {};
Box.__index = Box;
Box.__tostring = Box.ToString;

setmetatable(Box, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})

---Creates a rectangle
---@param b Box
local function createRectangle3D(b)
    local w = b.Width / 2;
    local l = b.Length / 2;
    local h = b.Height / 2;
    b.Vertices:Add(Vertex(-w, -l, -h), Vertex(-w, -l, h), Vertex(-w, l, -h), Vertex(w, -l, -h), Vertex(-w, l, h), Vertex(w, -l, h), Vertex(w, l, -h), Vertex(w, l, h));
    b.Triangles:Add(1, 4, 7, 1, 3, 7, 1, 2, 5, 1, 3, 5, 1, 2, 6, 1, 4, 6, 2, 5, 8, 2, 6, 8, 3, 5, 8, 3, 7, 8, 4, 7, 8, 4, 6, 8);
    b.Colors:Add(RGBA(0, 0, 0), RGBA(0, 0, 0xFF), RGBA(0, 0xFF, 0), RGBA(0xFF, 0, 0), RGBA(0, 0xFF, 0xFF), RGBA(0xFF, 0, 0xFF), RGBA(0xFF, 0xFF, 0), RGBA(0xFF, 0xFF, 0xFF))
end

---Creates a box. Use `Box:Create()` or `Box()` to create a new box object
---@param width number # Width of the box
---@param height number # Length of the box
---@param length number # Height of the box
---@return Box
---@private
function Box:New(width, length, height)
    Visuals.New(self);
    self.Width = width;
    self.Length = length;
    self.Height = height;
    createRectangle3D(self);
    return self;
end

---Creates a 3D rectangle
---@param width number # Width of the box
---@param height number # Length of the box
---@param length number # Height of the box
---@return Box
function Box:Create(width, height, length)
    return Box(width, height, length);
end

---Copies the box
---@return Box # Copy of the box object
function Box:Copy()
    return Box(self.Width, self.Length, self.Height):CopyFrom(self);
end

---Returns the box as a string
---@param verbose boolean? # If true, prints all details of the box
---@return string
function Box:ToString(verbose)
    return string.format("Box\nWidth: %d\nLength: %d\nHeight: %d\n%s", self.Width, self.Length, self.Height, Visuals.tostring(self, verbose)) 
end