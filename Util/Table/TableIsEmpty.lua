---Checks whether the passed table is empty or not
---@param t table # The table to be checked
---@return boolean # True if the table is empty, false otherwise
function tableIsEmpty(t)
    for _, _ in pairs(t) do return false; end
    return true;
end