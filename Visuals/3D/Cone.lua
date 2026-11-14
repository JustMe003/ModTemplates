require("Visuals.Visuals");
require("Visuals.2D.Circle");

---@class Cone: Circle
---@field Height number
Cone = {};
Cone.__index = Cone;
Cone.__tostring = Cone.ToString;

setmetatable(Cone, {
    __index = Circle;
    __call = getmetatable(Visuals).__call;
});

---Creates a cone. Use `Cone:Create()` or `Cone()` to create a cone object
---@param detail integer # The detail level of the cone. The higher the detail, the more vertices/triangles
---@param radius number # The radius of the base of the cone
---@param height number # The height of the top of the cone
---@return Cone
---@private
function Cone:New(detail, radius, height)
    Circle.New(self, detail, radius);
    self.Height = height;
    local m = self:GetMiddleVertex();
    m[3] = m[3] + height;
    self:InitColors();
    return self;
end

---Creates a cone
---@param detail integer # The detail level of the cone. The higher the detail, the more vertices/triangles
---@param radius number # The radius of the base of the cone
---@param height number # The height of the top of the cone
---@return Cone
function Cone:Create(detail, radius, height);
    return Cone(detail, radius, height);
end

---Copies the cone object
---@return Cone # Copy of the cone object
function Cone:Copy()
    return Cone:Create(self.Detail, self.Radius, self.Height):CopyFrom(self);
end

---Returns the cone as a string
---@param verbose boolean? # If true, prints all details of the cone
---@return string
function Cone:ToString(verbose)
    return string.format("Cone\nDetail: %d\nRadius: %d\nHeight: %d\n%s", self.Detail, self.Radius, self.Height, Visuals.ToString(self, verbose))
end