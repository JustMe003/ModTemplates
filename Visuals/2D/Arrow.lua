require("Visuals.Group");
require("Visuals.2D.Rectangle");
require("Visuals.2D.Triangle");

---@class Arrow: Group
---@field Size number
---@field Origin Vertex
---@field Destination Vertex
---@field Direction Vertex
Arrow = {};
Arrow.__index = Arrow;
Arrow.__tostring = Arrow.ToString;
setmetatable(Arrow, {
    __index = Group;
    __call = getmetatable(Visuals).__call;
})


---Creates the triangles and vertices of the arrow
---@param a Arrow
local function create(a)
    local tailLen = 2 * a.Size;
    a:Add(Rectangle:Create(tailLen, a.Size):MoveX(a.Size), Triangle:Create(Vertex(tailLen, a.Size), Vertex(tailLen, -a.Size), Vertex(tailLen + a.Size, 0)));
end

---@param a Arrow
local function calcDirectionVector(a)
    local v = a.Destination - a.Origin;
    local l = math.sqrt(v[1]^2 + v[2]^2 + v[3]^2);

    if l == 0 then return; end
    local new = Vertex(v[1] / l, v[2] / l, v[3] / l);       -- Normalized vector

    ---@param n1 number
    ---@param n2 number
    ---@return number
    local function getDegrees(n1, n2)
        if n1 ~= 0 then
            n2 = n2 / n1;
        end
        local r = math.atan(n2) / math.pi * 180;
        if n1 < 0 then r = r + 180; end
        return r;
    end

    if new[2] == 1 or new[2] == -1 then
        a:RotateZ(-getDegrees(a.Direction[1], a.Direction[2]));
        a:RevolveY(-(math.asin(new[3]) - math.asin(a.Direction[3])) / math.pi * 180):ApplyTransformation();
        a:RotateZ(new[2] * 90);
    else
        a:RotateZ(-getDegrees(a.Direction[1], a.Direction[2]));
        a:RevolveY(-(math.asin(new[3]) - math.asin(a.Direction[3])) / math.pi * 180):ApplyTransformation();
        a:RotateZ(getDegrees(new[1], new[2]));
    end
    a.Direction = new;
end

---Creates a Arrow. Use `Arrow:Create` or `Arrow()` to create an Arrow object 
---@param size number? # Size of the arrow, defaults to 20
---@return Arrow
---@private
function Arrow:New(size)
    Group.New(self);
    self.Size = size or 20;
    self.Origin = Vertex(0, 0);
    self.Destination = Vertex(100, 0);
    self.Direction = Vertex(1, 0, 0);
    create(self);
    return self;
end

---Creates an Arrow
---@param size number? # Size of the arrow, defaults to 20
---@return Arrow
function Arrow:Create(size)
    return Arrow(size);
end

---Sets the origin point of the arrow. Rotates the arrow if needed. Unless the arrow is moved, this will also be the point where the arrow trail starts
---@param x number # X coordinate
---@param y number # Y coordinate
---@param z number? # Z coordinate, defaults to 0
---@return Arrow
function Arrow:SetOrigin(x, y, z)
    self.Origin = Vertex(x, y, z);
    calcDirectionVector(self);
    return self:Move(x, y, z or 0);
end

---Sets the destination point of the arrow. Rotates the arrow if needed
---@param x number # X coordinate
---@param y number # Y coordinate
---@param z number? # Z coordinate, defaults to 0
---@return Arrow
function Arrow:SetDestination(x, y, z)
    self.Destination = Vertex(x, y, z);
    calcDirectionVector(self);
    return self;
end

---Returns the triangle of the tip
---@return Triangle
function Arrow:GetTip()
    return self.Objects[2] --[[@as Triangle]];
end

---Returns the rectangle of the trail
---@return Rectangle
function Arrow:GetTrail()
    return self.Objects[1] --[[@as Rectangle]]
end

---Copies the arrow object
---@return Arrow # Copy of the arrow object
function Arrow:Copy()
    local copy = Arrow:Create();
    return copy;
end

---Returns the arrow object as an string
---@param verbose boolean? # If true, prints all details of the arrow
---@return string
function Arrow:ToString(verbose)
    print(self.Size);
    return string.format("Arrow\nSize: %d\nOrigin: %s\nDestination: %s\nDirection: %s\n%s", self.Size, tostring(self.Origin), tostring(self.Destination), tostring(self.Direction), Group.ToString(self, verbose));
end