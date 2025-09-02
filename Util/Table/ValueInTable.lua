---Checks whether the passed value is present in the passed table
---@param t table # The table
---@param v any # The value being looked up
---@return boolean # True if the value could be found in the table, false otherwise
function valueInTable(t, v)
    for _, e in pairs(t) do
        if v == e then return true; end
    end
    return false;
end