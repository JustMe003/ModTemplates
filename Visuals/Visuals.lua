require("Visuals.Globals")
require("Visuals.Util");
require("Visuals.Math.Matrix4D");
require("Visuals.Math.Vector4D");
require("Visuals.ColorArray")
require("Visuals.VertexArray");
require("Visuals.Triangles");
require("Visuals.Animation.Animation");
require("Visuals.Gradient.MinMax");

local UNIQUE_ID = 0;

---@class VisualObject
---@field ID integer
---@field Vertices VertexArray # Array containing all vertices of the object
---@field Triangles Triangles # Must be a multiple of 3
---@field Colors ColorArray # A list of colors for each vertex
---@field Transformation Matrix4D
---@field Animations Animation[]
---@field Center Vector4D
Visuals = {}
Visuals.__index = Visuals;
Visuals.__tostring = Visuals.ToString;

setmetatable(Visuals, {
    __add = ConcatTables;
    __call = function(class, ...)
        local self = setmetatable({}, class);
        self:New(...);
        return self;
    end
})

---@return VisualObject
function Visuals:New()
    self.ID = UNIQUE_ID;
    UNIQUE_ID = UNIQUE_ID + 1;
    self.Vertices = VertexArray();
    self.Triangles = Triangles();
    self.Colors = ColorArray:Create();
    self.Transformation = Matrix4D();
    self.Animations = {};
    self.Center = Vector4D();
    return self;
end

---@param c VisualColor
---@return RGBAObject
local function getRGBAColor(c)
    if type(c) == "string" then
        return RGBA:FromString(c);
    end
    return c;
end

---@generic T: VisualObject
---@param self T
---@param color VisualColor?
---@return T
function Visuals:InitColors(color)
    color = getRGBAColor(color or "#FFFFFF");
    for i, _ in ipairs(self.Vertices) do
        self.Colors[i] = RGBA(color[1], color[2], color[3], color[4]);
    end
    return self;
end

---Sets the color of the visual
---@generic T: VisualObject
---@param self T
---@param color VisualColor
---@return T
function Visuals:SetColor(color)
    local c = color;
    if type(color) == "string" then
        c = RGBA:FromString(color);
    end
    for _, vc in ipairs(self.Colors) do
        vc[1] = c[1];
        vc[2] = c[2];
        vc[3] = c[3];
        vc[4] = c[4];
    end
    return self;
end

---Sets the color of the visual. Colors must be an array of the same size of the number of vertices the object has
---@generic T: VisualObject
---@param self T
---@param colors VisualColor[]
---@return T
function Visuals:SetColors(colors)
    if #colors == #self.Vertices then
        for i, vc in ipairs(self.Colors) do
            local c = colors[i];
            if type(c) == "string" then
                c = RGBA:FromString(c);
            end
            vc[1] = c[1];
            vc[2] = c[2];
            vc[3] = c[3];
            vc[4] = c[4];
        end
    else
        print(string.format("Warning: SetColors recieved an array of size %d, expected an array of size %d", #colors, #self.Vertices));
    end
    return self;
end

---Returns the colors of the VisualObject
---@return RGBObject[]
function Visuals:GetColors()
    return self.Colors;
end

---Moves the whole visual along the x axis
---@generic T: VisualObject
---@param self T
---@param n number
---@return T
function Visuals:MoveX(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, n));
    return self;
end

---Moves the whole visual along the y axis
---@generic T: VisualObject
---@param self T
---@param n number
---@return T
function Visuals:MoveY(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, 0, n));
    return self;
end

---Moves the whole visual along the z axis
---@generic T: VisualObject
---@param self T
---@param n number
---@return T
function Visuals:MoveZ(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, n));
    return self;
end

---@generic T: VisualObject
---@param self T
---@param x number # Amount of units to move the object along the X-axis
---@param y number # Amount of units to move the object along the Y-axis
---@param z number? # Amount of units to move the object along the Z-axis. Defaults to 0
---@return T
function Visuals:Move(x, y, z)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z or 0));
    return self;
end

local function getRadians(n)
    return n / 180 * math.pi;
end

---Rotates the visual object around the X = 0 axis
---@generic T: VisualObject
---@param self T
---@param r number # Degrees in which to turn the visual object. Must be between 180 and -180
---@return T
function Visuals:RevolveX(r)
    r = getRadians(r);
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, math.cos(r), -math.sin(r), 0, 0, math.sin(r), math.cos(r)));
    return self;
end

---Rotates the visual object around the Y = 0 axis
---@generic T: VisualObject
---@param self T
---@param r number # Degrees in which to turn the visual object. Must be between 180 and -180
---@return T
function Visuals:RevolveY(r)
    r = getRadians(r);
    self.Transformation:MultMatrix(Matrix4D(math.cos(r), 0, math.sin(r), 0, 0, 1, 0, 0, -math.sin(r), 0, math.cos(r)))
    return self;
end

---Rotates the visual object around the Z = 0 axis
---@generic T: VisualObject
---@param self T
---@param r number # Degrees in which to turn the visual object. Must be between 180 and -180
---@return T
function Visuals:RevolveZ(r)
    r = getRadians(r);
    self.Transformation:MultMatrix(Matrix4D(math.cos(r), -math.sin(r), 0, 0, math.sin(r), math.cos(r), 0, 0, 0, 0, 1))
    return self;
end

---Scales the visual object on the X axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ScaleX(n)
    self.Transformation:MultMatrix(Matrix4D(n));
    return self;
end

---Scales the visual object on the Y axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ScaleY(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, n));
    return self;
end

---Scales the visual object on the Z axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ScaleZ(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, n))
    return self;
end

---Scales the visual object on the Z axis
---@generic T: VisualObject
---@param self T
---@param x number # Scaling relative to the X-axis
---@param y number # Scaling relative to the Y-axis
---@param z number? # Scaling relative to the Z-axis, defaults to 1
---@return T
function Visuals:Scale(x, y, z)
    self.Transformation:MultMatrix(Matrix4D(x, 0, 0, 0, 0, y, 0, 0, 0, 0, z or 1));
    return self
end

---Shears the visual object on the X axis relative to the Z axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearXAlongZ(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, n))
    return self;
end

---Shears the visual object on the X axis relative to the Y axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearXAlongY(n)
    self.Transformation:MultMatrix(Matrix4D(1, n))
    return self;
end

---Shears the visual object on the Y axis relative to the X axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearYAlongX(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, n))
    return self;
end

---Shears the visual object on the Y axis relative to the Z axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearYAlongZ(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, n))
    return self;
end

---Shears the visual object on the Z axis relative to the X axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearZAlongX(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, 0, 0, n))
    return self;
end

---Shears the visual object on the Z axis relative to the X axis
---@generic T: VisualObject
---@param self T
---@param n number # Scale
---@return T
function Visuals:ShearZAlongY(n)
    self.Transformation:MultMatrix(Matrix4D(1, 0, 0, 0, 0, 1, 0, 0, 0, n))
    return self;
end

---Rotates the object around its center in the X-axis
---@generic T: VisualObject
---@param self T
---@param r number # Radians to rotate
---@return T
function Visuals:RotateX(r)
    r = getRadians(r);
    local mat = Matrix4D(1, 0, 0, 0, 0, math.cos(r), -math.sin(r), 0, 0, math.sin(r), math.cos(r));
    for _, v in pairs(self.Vertices) do
        local v2 = mat:MultVector(Vector4D:FromVertex(v - self.Center)) + Vector4D:FromVertex(self.Center);
        v[1] = v2[1];
        v[2] = v2[2];
        v[3] = v2[3];
    end
    return self;
end

---Rotates the object around its center in the Y-axis
---@generic T: VisualObject
---@param self T
---@param r number # Radians to rotate
---@return T
function Visuals:RotateY(r)
    r = getRadians(r);
    local mat = Matrix4D(math.cos(r), 0, math.sin(r), 0, 0, 1, 0, 0, -math.sin(r), 0, math.cos(r));
    for _, v in pairs(self.Vertices) do
        local v2 = mat:MultVector(Vector4D:FromVertex(v - self.Center)) + Vector4D:FromVertex(self.Center);
        v[1] = v2[1];
        v[2] = v2[2];
        v[3] = v2[3];
    end
    return self;
end

---Rotates the object around its center in the Z-axis
---@generic T: VisualObject
---@param self T
---@param r number # Radians to rotate
---@return T
function Visuals:RotateZ(r)
    r = getRadians(r);
    local mat = Matrix4D(math.cos(r), -math.sin(r), 0, 0, math.sin(r), math.cos(r), 0, 0, 0, 0, 1);
    for _, v in pairs(self.Vertices) do
        local v2 = mat:MultVector(Vector4D:FromVertex(v - self.Center)) + Vector4D:FromVertex(self.Center);
        v[1] = v2[1];
        v[2] = v2[2];
        v[3] = v2[3];
    end
    return self;
end


---Centers the visual around the x and y coordinates. If no coordinates are passed, it centers around {0, 0}
---@generic T: VisualObject
---@param self T
---@param x number?
---@param y number?
---@return T
function Visuals:CenterAround(x, y)
    x = x or 0;
    y = y or 0;
    local firstVertex = self.Vertices[1];
    local minX = firstVertex[1];
    local maxX = firstVertex[1];
    local minY = firstVertex[2];
    local maxY = firstVertex[2];

    for _, vertex in ipairs(self.Vertices) do
        minX = math.min(minX, vertex[1]);
        maxX = math.max(maxX, vertex[1]);
        minY = math.min(minY, vertex[2]);
        maxY = math.max(maxY, vertex[2]);
    end

    local xOffset = (maxX + minX) / 2 - x;
    local yOffset = (maxY + minY) / 2 - y;
    for _, vertex in ipairs(self.Vertices) do
        vertex[1] = vertex[1] - xOffset;
        vertex[2] = vertex[2] - yOffset;
    end
    return self;
end

---Updates the center of the object
---@generic T: VisualObject
---@param self T
---@return T
function Visuals:UpdateCenter()
    local x = MinMax:Create();
    local y = MinMax:Create();
    local z = MinMax:Create();
    for _, v in ipairs(self.Vertices) do
        x:Comp(v[1]);
        y:Comp(v[2]);
        z:Comp(v[3]);
    end
    self.Center[1] = x:GetMin() + ((x:GetMax() - x:GetMin()) / 2);
    self.Center[2] = y:GetMin() + ((y:GetMax() - y:GetMin()) / 2);
    self.Center[3] = z:GetMin() + ((z:GetMax() - z:GetMin()) / 2);
    return self;
end

---Applies the transformation matrix to the vertices. This will be called when `GetVertices` is called
---@generic T: VisualObject
---@param self T
---@return T
function Visuals:ApplyTransformation()
    for _, v in pairs(self.Vertices) do
        local vec = self.Transformation:MultVector(Vector4D:FromVertex(v));
        v[1] = vec[1];
        v[2] = vec[2];
        v[3] = vec[3];
    end
    self.Center = Vector4D(self.Center[1] + self.Transformation[4], self.Center[2] + self.Transformation[8], self.Center[3] + self.Transformation[12]);
    self.Transformation = Matrix4D();
    return self;
end

---Returns all vertices. Will transform all vertices accordingly to the transformation matrix
---@return VertexArray
function Visuals:GetVertices()
    self:ApplyTransformation();
    return self.Vertices;
end

---Returns the triangles
---@return Triangles
function Visuals:GetTriangles()
    return self.Triangles;
end

---@generic T: VisualObject
---@param self T
---@param ... Animation
---@return T
function Visuals:AddAnimation(...)
    for _, animation in ipairs({...}) do
        table.insert(self.Animations, animation);
    end
    return self;
end

---Sets the start of all animations
---@generic T: VisualObject
---@param self T
---@param t number # Must be between [0, 1]
---@return T
function Visuals:SetAnimationsStart(t)
    for _, animation in ipairs(self.Animations) do
        animation:SetStart(t)
    end
    return self
end

---Sets the end of all animations
---@generic T: VisualObject
---@param self T
---@param t number # Must be between [0, 1]
---@return T
function Visuals:SetAnimationsEnd(t)
    for _, animation in ipairs(self.Animations) do
        animation:SetEnd(t)
    end
    return self;
end

---Copies all VisualObject fields to the new object
---@generic T: VisualObject
---@param self T
---@param obj T # Scale
---@return T
function Visuals:CopyFrom(obj)
    self.Vertices = obj.Vertices:Copy();
    self.Triangles = obj.Triangles:Copy();
    self.Colors = obj.Colors:Copy();
    return self;
end

---Returns a string of the object, handy for debugging
---@param verbose boolean?
---@return string
function Visuals:ToString(verbose)
    if verbose then
        return string.format("ID: %d\nVertices: %d\n%s\nTriangles: %d\nColors: %d\n%s\nCenter: %s\nTrans matrix: %s\nAnimations: %d", self.ID, #self.Vertices, tostring(self.Vertices), #self.Triangles / 3, #self.Colors, tostring(self.Colors), tostring(self.Center), tostring(self.Transformation), #self.Animations)
    else
        return string.format("ID: %d\nVertices: %d\nTriangles: %d\nColors: %d\nCenter: %s\nTrans matrix: %s\nAnimations: %d", self.ID, #self.Vertices, #self.Triangles / 3, #self.Colors, tostring(self.Center), tostring(self.Transformation), #self.Animations);
    end
end