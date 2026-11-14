local mt_vector4D;

---@class Vector4D
Vector4D = {};
Vector4D.__index = Vector4D;
Vector4D.__tostring = function(v)
    return string.format("( %.2f, %.2f, %.2f, %.2f )", table.unpack(v));
end;
Vector4D.    __sub = function(v1, v2)
    return Vector4D(v1[1] - v2[1], v1[2] - v2[2], v1[3] - v2[3], v1[4] - v2[4]);
end;
Vector4D.__add = function(v1, v2)
    return Vector4D(v1[1] + v2[1], v1[2] + v2[2], v1[3] + v2[3], v1[4] + v2[4]);
end

setmetatable(Vector4D, {
    __call = function(_, a, b, c, d)
        return setmetatable({a or 0, b or 0, c or 0, d or 1}, Vector4D);
    end;
});

---Creates a 4d vector object
---@param n1 number
---@param n2 number
---@param n3 number
---@param n4 number? # Defaults to 1
---@return Vector4D
function Vector4D:Create(n1, n2, n3, n4)
    return Vector4D(n1, n2, n3, n4);
end

---Creates a 4d vector from a vertex object
---@param v Vertex
---@return Vector4D
function Vector4D:FromVertex(v)
    return Vector4D(v[1], v[2], v[3], 1);
end