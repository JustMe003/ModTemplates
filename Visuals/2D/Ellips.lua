require("Visuals.Visuals");


---@class Ellips: VisualObject
---@field Detail integer
---@field RadiusX number
---@field RadiusY number
---@field Percentage number
Ellips = {};
Ellips.__index = Ellips;
Ellips.__tostring = Ellips.ToString

---@overload fun(detail: number, rx: number, ry: number, p: number?): Ellips
setmetatable(Ellips, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})

---@param e Ellips
local function createEllipsVertices(e)
    e.Vertices:Add(Vertex(0, 0));
    local step = 1 / e.Detail * 2 * math.pi * e.Percentage;
    local currentStep = 0;
    for _ = 1, e.Detail + 1 do
        e.Vertices:Add(Vertex(math.sin(currentStep) * e.RadiusX, math.cos(currentStep) * e.RadiusY));
        currentStep = currentStep + step;
    end
end

---@param e Ellips
local function createEllipsTriangles(e)
    for i = 1, e.Detail do
        e.Triangles:Add(1, i + 1, i + 2);
    end
    return e.Triangles;
end

---Creates a Ellips. Use `Ellips:Create()` or `Ellips()` to create an ellips object
---@param det integer # The detail level of the ellips. The higher the detail, the more vertices/triangles
---@param rx number # The maximum radius from the center along the X-axis 
---@param ry number # The maximum radius from the center along the Y-axis
---@param p number? # Percentage of the ellips to be created. Must be between [0, 1], defaults to 1
---@return Ellips
---@private
function Ellips:New(det, rx, ry, p)
    Visuals.New(self);
    self.Detail = det;
    self.RadiusX = rx;
    self.RadiusY = ry;
    self.Percentage = math.min(1, p or 1);
    createEllipsVertices(self);
    createEllipsTriangles(self);
    self:InitColors();
    return self;
end

---Creates a Ellips
---@param det integer # The detail level of the ellips. The higher the detail, the more vertices/triangles
---@param rx number # The maximum radius from the center along the X-axis 
---@param ry number # The maximum radius from the center along the Y-axis
---@param p number? # Percentage of the ellips to be created. Must be between [0, 1], defaults to 1
---@return Ellips
function Ellips:Create(det, rx, ry, p)
    return Ellips(det, rx, ry, p);
end

---Sets the color of the ellips
---@param innerColor VisualColor # The color of the center vertex
---@param outerColor VisualColor # The color of the outer vertices
function Ellips:SetEllipsColors(innerColor, outerColor)
    local colors = ColorArray(innerColor);
    for _ = 1, self.Detail + 1 do
        colors:Add(outerColor);
    end
    self:SetColors(colors);
    return self;
end

---Copies the ellips object
---@return Ellips # Copy of the ellips object
function Ellips:Copy()
    return Ellips:Create(self.Detail, self.RadiusX, self.RadiusY):CopyFrom(self);
end

---Returns the ellips object as a string
---@param verbose boolean? # If true, prints all details of the ellips
function Ellips:ToString(verbose)
    return string.format("Ellips\nDetail: %d\nX-radius: %d\nY-radius: %d\nPercentage: %.2f\n%s", self.Detail, self.RadiusX, self.RadiusY, self.Percentage, Visuals.ToString(self, verbose));
end