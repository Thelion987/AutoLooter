-- Using: https://github.com/Auctionator/Auctionator

function AuctionPrice(itemLink)
  local auctionPrice
  --make sure addon exists
  if not Auctionator then 
    DEFAULT_CHAT_FRAME:AddMessage("Error 1: addon Auctionator not found", 1.0, 0.0, 0.0) 
    return  
  end
  
  --Getting uniek id of auctionator DB table
  if Auctionator.Utilities.DBKeyFromLink then
    dbKeys = Auctionator.Utilities.DBKeyFromLink(itemLink, function(dbKeys)

      --Getting prices with the previous gotten uniek id
      if Auctionator.Database and type(dbKeys) == "table" then
        auctionPrice = Auctionator.Database:GetFirstPrice(dbKeys)
      else
        DEFAULT_CHAT_FRAME:AddMessage("Error 3: GetFirstPrice not found", 1.0, 0.0, 0.0)
      end

    end)
  else
      DEFAULT_CHAT_FRAME:AddMessage("Error 2: DBKeyFromLink not found", 1.0, 0.0, 0.0)
  end

  return auctionPrice

end