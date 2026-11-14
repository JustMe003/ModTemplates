require("Visuals.Visuals");
require("Visuals.Gradient.RGBA");

---@class Sphere: VisualObject
Sphere = {};
Sphere.__index = Sphere;
Sphere.__tostring = Sphere.ToString;


setmetatable(Sphere, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})

---@param s Sphere
local function setColors(s)
    local cls = ColorArray:Create();
    for _, v in ipairs(s.Vertices) do
        cls:Add(RGBA((v:GetX() + s.Range) / s.Range / 2 * 0xFF, (v:GetY() + s.Range) / s.Range / 2 * 0xFF, (v:GetZ() + s.Range) / s.Range / 2 * 0xFF));
    end
    s.Colors = cls;
end

---@param s Sphere
local function createVertices(s)
    local theta = 1 / s.Detail * math.pi * s.Percentage;
    local phi = 1 / s.Detail * 2 * math.pi;
    local currentTheta = 0;
    s.Vertices:Add(Vertex(0, 0, s.Range))
    for _ = 1, s.Detail - 1 do
        currentTheta = currentTheta + theta;
        local z = s.Range * math.cos(currentTheta);
        for i = 1, s.Detail do
            local x = s.Range * math.sin(currentTheta) * math.cos(phi * i);
            local y = s.Range * math.sin(currentTheta) * math.sin(phi * i);
            s.Vertices:Add(Vertex(x, y, z));
        end
    end
    if s.Percentage == 1 then
        s.Vertices:Add(Vertex(0, 0, -s.Range));
    end
end

---@param s Sphere
local function createTriangles(s)
    -- Top
    for i = 1, s.Detail - 1 do
        s.Triangles:Add(1, i + 1, i + 2);
    end
    s.Triangles:Add(1, 2, s.Detail + 1);

    local startPolygons = 1;
    for i = 0, s.Detail - 3 do
        for j = 1, s.Detail - 1 do
            s.Triangles:Add(startPolygons + (i * s.Detail) + j, startPolygons + (i * s.Detail) + j + 1, startPolygons + (i * s.Detail) + j + s.Detail);
            s.Triangles:Add(startPolygons + (i * s.Detail) + j + 1, startPolygons + (i * s.Detail) + j + s.Detail, startPolygons + (i * s.Detail) + j + s.Detail + 1);
        end
        s.Triangles:Add(startPolygons + (i * s.Detail) + 1, startPolygons + (i * s.Detail) + s.Detail, startPolygons + (i * s.Detail) + s.Detail + 1);
        s.Triangles:Add(startPolygons + (i * s.Detail) + s.Detail, startPolygons + (i * s.Detail) + s.Detail + 1, startPolygons + ((i + 1) * s.Detail) + s.Detail);
    end

    --bottom
    if s.Percentage == 1 then
        local bottom = s.Detail * (s.Detail - 1) + 2
        for i = 0, s.Detail - 1 do
            s.Triangles:Add(bottom, bottom - s.Detail + i, bottom - s.Detail + i + 1);
        end
        s.Triangles:Add(bottom, bottom - s.Detail, bottom - 1);
    end
end

---Creates a sphere. Use `Sphere:Create()` or `Sphere` to create a sphere object
---@param detail number # The detail level of the sphere. The higher the detail, the more vertices/triangles
---@param r number # Radius of the sphere
---@param p number? # Percentage of the sphere to be created. Must be between [0, 1], defaults to 1
---@return Sphere
---@private
function Sphere:New(detail, r, p)
    Visuals.New(self);
    self.Detail = detail;
    self.Range = r;
    self.Percentage = math.min(1, p or 1);
    createVertices(self);
    createTriangles(self);
    setColors(self);
    return self;
end

---Creates a sphere
---@param det number # The detail level of the sphere. The higher the detail, the more vertices/triangles
---@param r number # Radius of the sphere
---@param p number? # Percentage of the sphere to be created. Must be between [0, 1], defaults to 1
---@return Sphere
function Sphere:Create(det, r, p)
    return Sphere(det, r, p);
end

---Copies the sphere
---@return Sphere # Copy of the sphere object
function Sphere:Copy()
    return Sphere(self.Detail, self.Range, self.Percentage):CopyFrom(self);
end

---Returns the string of the sphere
---@param verbose boolean # If true, prints all details of the sphere
---@return string
function Sphere:ToString(verbose)
    return string.format("Sphere\nDetail: %d\nRadius: %d\nPercentage: %.2f\n%s", self.Detail, self.Range, self.Percentage, Visuals.ToString(self, verbose))
end