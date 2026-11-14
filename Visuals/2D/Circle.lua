require("Visuals.Visuals");


---@class Circle: VisualObject
---@field Detail integer
---@field Radius number
---@field Percentage number
Circle = {};
Circle.__index = Circle;
Circle.__tostring = Circle.ToString;

---@overload fun(detail: integer, range: number, p: number?): Circle
setmetatable(Circle, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})


---@param c Circle
local function createCircleVertices(c)
    c.Vertices:Add(Vertex(0, 0));
    local step = 1 / c.Detail * 2 * math.pi * c.Percentage;
    local currentStep = 0;
    for _ = 1, c.Detail + 1 do
        c.Vertices:Add(Vertex(math.sin(currentStep) * c.Radius, math.cos(currentStep) * c.Radius));
        currentStep = currentStep + step;
    end
end

---@param c Circle
local function createCircleTriangles(c)
    for i = 1, c.Detail do
        c.Triangles:Add(1, i + 1, i + 2);
    end
    return c.Triangles;
end

---Creates a Circle. Use `Circle:Create()` or `Circle()` to create a new Circle
---@param det integer # The detail level of the circle. The higher the detail, the more vertices/triangles
---@param r number # Radius of the circle
---@param p number? # Percentage of the circle to be created. Must be between [0, 1], defaults to 1
---@return Circle
---@private
function Circle:New(det, r, p)
    Visuals.New(self);
    self.Detail = det;
    self.Radius = r;
    self.Percentage = math.min(1, p or 1);
    self.__index = self;
    createCircleVertices(self);
    createCircleTriangles(self);
    self:InitColors();
    return self;
end

---Creates a Circle
---@param det integer # The detail level of the circle. The higher the detail, the more vertices/triangles
---@param r number # Radius of the circle
---@param p number? # Percentage of the circle to be created. Must be between [0, 1], defaults to 1
---@return Circle
function Circle:Create(det, r, p)
    return Circle(det, r, p);
end

---Sets the color of all vertices in the circle. 
---@param innerColor VisualColor # The color of the center vertex
---@param outerColor VisualColor # The color of the outer vertices
function Circle:SetCircleColors(innerColor, outerColor)
    local colors = ColorArray(innerColor);
    for _ = 1, self.Detail + 1 do
        colors:Add(outerColor);
    end
    self:SetColors(colors);
    return self;
end

---Returns the middle vertex of the circle
---@return Vertex
function Circle:GetMiddleVertex()
    return self.Vertices[1];
end

---Copies the circle object
---@return Circle # Copy of the circle object
function Circle:Copy()
    return Circle:Create(self.Detail, self.Radius, self.Percentage):CopyFrom(self);
end

---Returns the circle object as a string
---@param verbose boolean? # If true, prints all details of the circle
---@return string
function Circle:ToString(verbose)
    return string.format("Circle\nDetail: %d\nRadius: %d\nPercentage: %.2f\n%s", self.Detail, self.Radius, self.Percentage, Visuals.ToString(self, verbose));
end