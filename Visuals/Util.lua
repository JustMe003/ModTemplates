---Concats two tables. Elements of the second table are added to the first table, returns the first table
---@param t1 table
---@param t2 table
---@return table
function ConcatTables(t1, t2)
    for i, v in pairs(t2) do
        t1[i] = v;
    end
    return t1;
end

---Concats two arrays. Elements of the second array are added to the first array, returns the first array
---@param a1 any[]
---@param a2 any[]
---@return any[]
function ConcatArrays(a1, a2)
    for _, v in pairs(a2) do
        table.insert(a1, v);
    end
    return a1;
end

---Returns the super or parent class
---@param class table
---@return table?
function Super(class)
    return (getmetatable(class) or {}).__index
end

---Returns true if the passed value is in the passed table, false otherwise
---@param t table
---@param v any
---@return boolean
function ValueInTable(t, v)
    for _, v2 in pairs(t) do
        if v == v2 then return true; end
    end
    return false;
end

---Returns true if the passed object is a child class of the passed parent, meaning that the child class "inherits" the parent class
---@param obj table
---@param parent table
---@return boolean
function IsChildClass(obj, parent)
    while obj ~= nil do
        if obj == parent then return true; end
        obj = (getmetatable(obj) or {}).__index;
    end
    return false;
end

---Returns true if the passed object is the same type as the passed class
---@param obj table
---@param class table
---@return boolean
function IsClass(obj, class)
    return getmetatable(obj).__index == class;
end

---Adds the second table to the meta table of the first table. Returns the first table
---@param t table
---@param t2 table
---@return table
function AddToMetaTable(t, t2)
    local meta = getmetatable(t);
    for i, v in pairs(t2) do
        meta[i] = v;
    end
    setmetatable(t, meta);
    return t;
end
