require("Visuals.Visuals");
require("Visuals.VertexArray");

---@class Triangle: VisualObject
Triangle = {};
Triangle.__index = Triangle;
Triangle.__tostring = Triangle.ToString;

---@overload fun(v1: Vertex, v2: Vertex, v3: Vertex): Triangle
setmetatable(Triangle, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})

---Creates a new trianle. Use `Triangle:Create` or `Triangle` to create a new triangle object
---@param v1 Vertex
---@param v2 Vertex
---@param v3 Vertex
---@return Triangle
function Triangle:New(v1, v2, v3)
    Visuals.New(self);
    self.Vertices:Add(v1, v2, v3);
    self.Triangles:Add(1, 2, 3);
    self:UpdateCenter();
    self.Colors = ColorArray(RGBA(0xFF, 0, 0), RGBA(0, 0xFF, 0), RGBA(0, 0, 0xFF));
    return self;
end

---Creates a new triangle
---@param v1 Vertex
---@param v2 Vertex
---@param v3 Vertex
---@return Triangle
function Triangle:Create(v1, v2, v3)
    return Triangle(v1, v2, v3);
end

---Sets the colors of the triangle
---@param c1 VisualColor # Color of the first vertex
---@param c2 VisualColor # Color of the second vertex, defaults to the color of the first vertex
---@param c3 VisualColor # Color of the third vertex, defaults to the color of the first vertex
---@return Triangle
function Triangle:SetTriangleColors(c1, c2, c3)
    return self:SetColors(ColorArray(c1, c2 or c1, c3 or c1));
end

---Copies the triangle
---@return Triangle # Copy of the triangle object
function Triangle:Copy()
    local vertices = self.Vertices;
    return Triangle:Create(vertices[1]:Copy(), vertices[2]:Copy(), vertices[3]:Copy()):CopyFrom(self);
end

---Returns the triangle as a string
---@param verbose boolean? # If true, prints all details of the triangle
---@return string
function Triangle:ToString(verbose)
    return string.format("Triangle\n%s", Visuals.ToString(self, verbose));
end