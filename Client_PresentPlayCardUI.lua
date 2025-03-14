---Client_PresentPlayCardUI
---@param game GameClientHook
---@param cardInstance CardInstance # Read-only data about the card that the player is attempting to play 
---@param playCard fun(orderListMessage: string, modData: string, turnPhase: EnumTurnPhase) # Function that when invoked, will make the player play the card
---@param close fun() # Function that when invoked will close this cards dialog
function Client_PresentPlayCardUI(game, cardInstance, playCard, close)

end