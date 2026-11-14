---@class Triangles
Triangles = {};
Triangles.__index = Triangles;
Triangles.__tostring = function(v)
    return "Triangles: {" .. table.concat(v, ", ") .. "}";
end

setmetatable(Triangles, {
    __call = function(_, ...)
        return setmetatable({...}, Triangles);
    end;
});

---@param ... integer # The number of passed arguments should be a multiple of 3
---@return Triangles
function Triangles:Create(...)
    if #{...} % 3 ~= 0 then
        print(string.format("%s You should not create a Triangles object while passing a non-multiple of 3 indices", ENCLOSED_LIB_NAME))
    end
    return Triangles(...);
end

---@param ... integer # The number of passed arguments should be a multiple of 3
function Triangles:Add(...)
    if #{...} % 3 ~= 0 then
        print(string.format("%s You should not add to a Triangles object while passing a non-multiple of 3 indices", ENCLOSED_LIB_NAME))
    end
    for _, p in ipairs({...}) do
        table.insert(self, p);
    end
end

---Returns the number of triangles
---@return integer
function Triangles:GetNumTriangles()
    return #self / 3;
end

---Copies the triangles object
---@return Triangles # Copy of the triangles object
function Triangles:Copy()
    local copy = Triangles:Create();
    copy:Add(table.unpack(self));
    return copy;
end