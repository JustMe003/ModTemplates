require("Visuals.Visuals");
require("Visuals.Gradient.RGBA");

---@class Group: VisualObject
---@field Objects VisualObject[]
---@field VertexOffset integer[]
Group = {};
Group.__index = Group;
Group.__tostring = Group.ToString;

setmetatable(Group, {
    __index = Visuals;
    __call = getmetatable(Visuals).__call;
});

---Creates a grouped VisualObject
---@return Group
function Group:New(...)
    Visuals.New(self);
    self.Objects = {};
    self.VertexOffset = {};
    self:Add(...);
    return self;
end

---Creates a grouped VisualObject
---@param ... VisualObject
---@return Group
function Group:Create(...)
    return Group(...);
end

---Adds all the passed VisualObject to the group
---@param ... VisualObject
---@return Group
function Group:Add(...)
    local vertexOffset = #self.Vertices;

    ---@param obj VisualObject
    local addObject = function(obj)
        table.insert(self.Objects, obj);
        table.insert(self.VertexOffset, vertexOffset + 1);
        
        for _, n in ipairs(obj.Triangles) do
            table.insert(self.Triangles, n + vertexOffset);
        end

        local vs = obj:GetVertices();
        self.Vertices:Add(table.unpack(vs));
        vertexOffset = vertexOffset + #vs;

        for _, c in ipairs(obj.Colors) do
            self.Colors:Add(c);
        end
    end

    local checkObject;
    ---@param obj VisualObject
    checkObject = function(obj)
        if not ValueInTable(self.Objects, obj) then
            if IsChildClass(obj, Group) then
                table.insert(self.Objects, obj);
                for _, o in ipairs(obj.Objects) do
                    checkObject(o);
                end
            else
                addObject(obj);
            end
        end
    end

    for _, obj in ipairs({...}) do
        checkObject(obj);
    end

    self:UpdateCenter();
    
    return self;
end

---Returns a copy of the group object. It will copy all its child objects
---@return Group # Copy of the group object
function Group:Copy()
    local g = Group:Create();
    for _, obj in ipairs(self.Objects) do
        g:Add(obj:Copy());
    end
    return g;
end

---Returns the group object as a string
---@param verbose boolean? # If true, returns all details of the object
---@return string
function Group:ToString(verbose)
    if verbose then
        local s = string.format("Group\nObjects: %d\n", #self.Objects);
        for _, obj in ipairs(self.Objects) do
            s = s .. string.format("  %s\n", tostring(obj));
        end
        return s .. string.format("%s", Visuals.ToString(self, verbose));
    else
        return string.format("Group\nObjects: %d\n%s", #self.Objects, Visuals.ToString(self, verbose));
    end
end
