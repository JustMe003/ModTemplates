require("Visuals.Visuals");
require("Visuals.VertexArray");

---@class Rectangle: VisualObject
---@field Width number
---@field Length number
Rectangle = {};
Rectangle.__index = Rectangle;
Rectangle.__tostring = Rectangle.ToString;

---@overload fun(width: number, height: number?): Rectangle
setmetatable(Rectangle, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
});

---@param r Rectangle
local function createRectangle(r)
    r.Vertices:Add(Vertex(-(r.Width / 2), -(r.Length / 2)), Vertex(-(r.Width / 2), r.Length / 2), Vertex(r.Width / 2, -(r.Length / 2)), Vertex((r.Width / 2), r.Length / 2));
    r.Triangles:Add(1, 2, 3,  2, 3, 4);
end

---Creates a Rectangle. Use `Rectangle:Create()` or `Rectangle()` to create a rectangle object 
---@param width number # The width of the rectangle
---@param length number? # The length of the rectangle. Defaults to the width
---@return Rectangle
---@private
function Rectangle:New(width, length)
    Visuals.New(self);
    self.Width = width;
    self.Length = length or width;
    createRectangle(self);
    self:InitColors();
    return self;
end

---Creates a Rectangle
---@param width number # The width of the rectangle
---@param height number? # The length of the rectangle. Defaults to the width
---@return Rectangle
function Rectangle:Create(width, height)
    return Rectangle(width, height);
end

---Sets the colors of the rectangle
---@param tl VisualColor # The color of the top-left vertex
---@param tr VisualColor? # The color of the top-right vertex, defaults to top-left's color
---@param bl VisualColor? # The color of the bottom-left vertex, defaults to the top-left's color
---@param br VisualColor? # The color of the bottom-right vertex, defaults to the top-left's color
---@return Rectangle
function Rectangle:SetRectangleColors(tl, tr, bl, br)
    return self:SetColors(ColorArray(tl, tr or tl, bl or tl, br or tl));
end

---Copies the rectangle
---@return Rectangle # Copy of the rectangle object
function Rectangle:Copy()
    return Rectangle:Create(self.Width, self.Length):CopyFrom(self);
end

---Returns the rectangle object as a string
---@param verbose boolean # If true, prints all details of the rectangle
---@return string
function Rectangle:ToString(verbose)
    return string.format("Rectangle\nWidth: %d\nHeight: %d\n%s", self.Width, self.Length, Visuals.ToString(self, verbose));
end