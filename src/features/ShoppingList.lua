-- Trailhead — src/features/ShoppingList.lua
--
-- Aggregates materials required across the current step and every step after
-- it in the active crafting guide. One line per distinct material, with the
-- total count summed across all remaining steps.

local _, ns = ...

local ShoppingList = {}
ns.ShoppingList = ShoppingList

--- Build a shopping list from the current guide state.
-- @param state  ns.CraftingGuide.current
-- @return array of { name = string, count = number }, in first-seen order
function ShoppingList:Generate(state)
    if not state or not state.guide then return {} end

    local steps     = state.guide.steps or {}
    local startIdx  = state.currentStepIndex or 1
    if startIdx > #steps then startIdx = #steps end

    local totals = {}   -- [name] = { name=, count= }
    local order  = {}   -- preserve first-seen order

    for i = startIdx, #steps do
        local step = steps[i]
        for _, mat in ipairs(step.materials or {}) do
            if not totals[mat.name] then
                totals[mat.name] = { name = mat.name, count = 0 }
                order[#order + 1] = mat.name
            end
            totals[mat.name].count = totals[mat.name].count + (mat.count or 0)
        end
    end

    local list = {}
    for i, name in ipairs(order) do
        list[i] = totals[name]
    end
    return list
end

-- TODO(phase-4b): subtract items already in bags/bank.
--   Requires item IDs, not names. Data schema will need:
--     materials = { { itemID = 12345, name = "Midnight Cloth", count = 2 } }
--   Then: owned = C_Item.GetItemCount(itemID, true, false, true, true)
--         remaining = math.max(0, total - owned)
-- TODO(phase-4c): export list to clipboard via /th list copy
