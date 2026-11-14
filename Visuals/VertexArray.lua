require("Visuals.Util");

---@class VertexArray
VertexArray = setmetatable({}, {
    __call = function(_)
        return VertexArray:Create();
    end
});

function VertexArray:Create()
    local vertexArrayMetaTable = {
        __index = self;
        __tostring = function(t)
            local s = "VertexArray: [";
            for i = 1, #t - 1 do
                s = s .. tostring(t[i]) .. ", ";
            end
            return s .. tostring(t[#t] or "") .. "]";
        end;
    }
    return setmetatable({}, vertexArrayMetaTable);
end

---Adds all vertices to the array
---@param ... Vertex
---@return VertexArray
function VertexArray:Add(...)
    for _, v in pairs({...}) do
        table.insert(self, v);
    end
    return self;
end

---Copies the VertexArray
---@return VertexArray
function VertexArray:Copy()
    local copy = VertexArray:Create();
    for _, v in ipairs(self) do
        copy:Add(v:Copy());
    end
    return copy;
end