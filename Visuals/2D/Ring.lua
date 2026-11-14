require("Visuals.Visuals");

---@class Ring: VisualObject
---@field Detail integer
---@field OuterRadius number
---@field InnerRadius number
---@field Percentage number
Ring = {};
Ring.__index = Ring;
Ring.__tostring = Ring.ToString;

---@overload fun(detail: number, outer: number, inner: number, p: number?): Ring
setmetatable(Ring, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
})

---Creates a ring
---@param r Ring
local function createRing(r)
    local step = 1 / r.Detail * 2 * math.pi * r.Percentage;
    local currentStep = step;
    r.Vertices:Add(Vertex(math.sin(0) * r.OuterRadius, math.cos(0) * r.OuterRadius), Vertex(math.sin(0) * r.InnerRadius, math.cos(0) * r.InnerRadius));
    for _ = 2, r.Detail + 1 do
        r.Vertices:Add(Vertex(math.sin(currentStep) * r.OuterRadius, math.cos(currentStep) * r.OuterRadius), Vertex(math.sin(currentStep) * r.InnerRadius, math.cos(currentStep) * r.InnerRadius));
        currentStep = currentStep + step;
    end
end

---@param r Ring
local function createTriangles(r)
    for i = 1, (r.Detail) * 2, 2 do
        r.Triangles:Add(i, i + 1, i + 2, i + 1, i + 2, i + 3);
    end
end

---Creates the new ring. Use `Ring:Create()` or `Ring()` to create a ring object
---@param detail integer # The detail level of the ring. The higher the detail, the more vertices/triangles
---@param outer number # The radius of the outer circle
---@param inner number # The radius of the inner circle
---@param p number? # Percentage of the ellips to be created. Must be between [0, 1], defaults to 1
---@return Ring
---@private
function Ring:New(detail, outer, inner, p)
    Visuals.New(self);
    self.Detail = detail;
    self.OuterRadius = outer;
    self.InnerRadius = inner;
    self.Percentage = math.min(1, p or 1);
    createRing(self);
    createTriangles(self)
    self:InitColors();
    return self;
end

---Creates a new ring object
---@param detail integer # The detail level of the ring. The higher the detail, the more vertices/triangles
---@param outer number # The radius of the outer circle
---@param inner number # The radius of the inner circle
---@param p number? # Percentage of the ellips to be created. Must be between [0, 1], defaults to 1
---@return Ring
function Ring:Create(detail, outer, inner, p)
    return Ring(detail, outer, inner, p);
end

---Copies the ring object
---@return Ring # Copy of the ring object
function Ring:Copy()
    return Ring:Create(self.Detail, self.OuterRadius, self.InnerRadius, self.Percentage):CopyFrom(self);
end

---Returns the ring object as a string
---@param verbose boolean? # If true, prints all details of the ring
---@return string
function Ring:ToString(verbose)
    return string.format("Ring\nDetail: %d\nOuter radius: %d\nInner radius: %d\nPercentage: %.2f\n%s", self.Detail, self.OuterRadius, self.InnerRadius, self.Percentage, Visuals.ToString(self, verbose));
end