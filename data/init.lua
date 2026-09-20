-- Trailhead — data/init.lua
--
-- Central registry for guide + route data.
-- Profession files call ns.Data:RegisterCraftingGuide / :RegisterGatheringRoute.

local _, ns = ...

local Data = {}
ns.Data = Data

Data.craftingGuides  = {} -- [professionKey] = guideTable
Data.gatheringRoutes = {} -- [professionKey] = routeTable

--- Register a crafting guide.
function Data:RegisterCraftingGuide(key, guide)
    self.craftingGuides[key] = guide
end

--- Register a gathering route.
function Data:RegisterGatheringRoute(key, route)
    self.gatheringRoutes[key] = route
end

--- Look up a crafting guide by key (case-insensitive).
function Data:GetCraftingGuide(key)
    if not key then return nil end
    key = key:lower()
    for k, v in pairs(self.craftingGuides) do
        if k:lower() == key then return v, k end
    end
    return nil
end

--- Look up a gathering route by key (case-insensitive).
function Data:GetGatheringRoute(key)
    if not key then return nil end
    key = key:lower()
    for k, v in pairs(self.gatheringRoutes) do
        if k:lower() == key then return v, k end
    end
    return nil
end