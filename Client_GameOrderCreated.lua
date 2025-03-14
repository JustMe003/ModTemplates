---Client_GameOrderCreated hook
---@param game GameClientHook
---@param order GameOrder # The order that was just created by the player
---@param skipOrder fun() # function that when invoked, will cancel the order actually being added to the orderlist of the player. When invoking this function, you should make sure that the player knows why their order was not added to the orderlist
function Client_GameOrderCreated(game, order, skipOrder)

end