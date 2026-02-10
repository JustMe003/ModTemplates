---Returns true if only one of the arguments is true
---```
---   b2  |  T  |  F  |
--- b1    |     |     |
--- T     |  F  |  T  |
--- F     |  T  |  F  |
---```
---@param b1 boolean
---@param b2 boolean
---@return boolean
function Xor(b1, b2)
    return b1 ~= b2;
end