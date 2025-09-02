---Counts and returns the size of the passed table
---@param t table # The table to get the size from
---@return integer # The length of the passed table
function getTableSize(t)
    local c = 0;
    for _, _ in pairs(t) do
        c = c + 1;
    end
    return c;
end