---Checks if the passed special unit is a custom special unit
---@param sp SpecialUnit # The special unit
---@return boolean # True if the unit is a custom special unit, false otherwise
function isCustomSpecialUnit(sp)
    return sp.proxyType == "CustomSpecialUnit";
end