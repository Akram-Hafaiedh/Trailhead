-- Trailhead — data/init.lua
--
-- Registry for crafting guide data.
-- Profession files call ns.Data:RegisterCraftingGuide as they load.

local _, ns = ...

local Data = {}
ns.Data = Data

Data.craftingGuides = {} -- [professionKey] = guideTable

function Data:RegisterCraftingGuide(key, guide)
    self.craftingGuides[key] = guide
end

function Data:GetCraftingGuide(key)
    if not key then return nil end
    key = key:lower()
    for k, v in pairs(self.craftingGuides) do
        if k:lower() == key then return v, k end
    end
    return nil
end