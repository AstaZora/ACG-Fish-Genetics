-- Helper function to check if a table contains a certain value
local function contains(table, val)
    for i=1,#table do
       if table[i] == val then 
          return true
       end
    end
    return false
 end
 
 local fishTypes = {
     "glowfin-trenchers",
     "mukmoux",
     "silverscale-glider"
 }
 
 local geneticCombinations = {
     "g", "y", "b", "gb", "gy", "yb"
 }
 
 for moduleName, module in pairs(data.raw["module"]) do
     -- Extract the fish type and genetic combination from the module name
     local extractedFishType, geneticCombination, tier = moduleName:match("^(.-)%-(.-)%-module%-tier%-(%d+)$")
     -- Check if the extracted fish type is in the fishTypes table and the genetic combination is valid
     if contains(fishTypes, extractedFishType) and contains(geneticCombinations, geneticCombination) then
         -- Set the limitations
         module.limitations = {
             "ac-breed-" .. extractedFishType,
             "ac-breed-" .. extractedFishType .. "-egg",
             "ac-process-" .. extractedFishType .. "-eggs-for-fish"
         }
         -- Set the limitation message key
         module.limitation_message_key = "module-limitation-" .. extractedFishType
     end
 end
 