---@class Vertex
Vertex = setmetatable({}, {
    __call = function(_, x, y, z)
        return Vertex:Create(x or 0, y or 0, z or 0); 
    end;
});

local vertexMetaTable = {
    __tostring = function(v)
        return "Vertex: {" .. table.concat(v, ", ") .. "}";
    end,
    __index = Vertex;
    __sub = function(v1, v2)
        return Vertex(v1[1] - v2[1], v1[2] - v2[2], v1[3] - v2[3]);
    end;
    __add = function(v1, v2)
        return Vertex(v1[1] + v2[1], v1[2] + v2[2], v1[3] + v2[3]);
    end
};


function Vertex:Create(x, y, z)
    return setmetatable({x, y, z or 0}, vertexMetaTable);
end

function Vertex:GetX()
    return self[1];
end

function Vertex:GetY()
    return self[2];
end

function Vertex:GetZ()
    return self[3];
end

function Vertex:Copy()
    return Vertex(self[1], self[2], self[3]);
end
