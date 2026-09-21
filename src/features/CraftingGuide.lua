-- Trailhead — src/features/CraftingGuide.lua
--
-- Loads a crafting guide, reads the player's live skill level from the WoW
-- profession API, and determines which step the player is currently on.

local _, ns = ...

local CraftingGuide = {}
ns.CraftingGuide = CraftingGuide

-- Current loaded guide state. nil when no guide is active.
CraftingGuide.current = nil

--- Load a guide by key and display it.
function CraftingGuide:Load(key)
    local guide, realKey = ns.Data:GetCraftingGuide(key)
    if not guide then
        ns:Print(ns:Str("CRAFT_GUIDE_NOT_FOUND", tostring(key)))
        return false
    end

    self.current = {
        key              = realKey,
        guide            = guide,
        skillLevel       = nil,
        currentStepIndex = nil,
    }

    self:Refresh()

    if self.current.skillLevel == nil then
        ns:Print(ns:Str("CRAFT_GUIDE_NO_SKILL", guide.name))
    else
        ns:Print(ns:Str(
            "CRAFT_GUIDE_LOADED",
            guide.name,
            self.current.skillLevel,
            guide.maxSkill
        ))
    end

    local header = guide.name
    if self.current.skillLevel then
        header = string.format("%s — %d/%d",
            guide.name, self.current.skillLevel, guide.maxSkill)
    end
    ns.MainFrame:ShowGuide(header)
    return true
end

--- Re-read the player's skill and recompute the current step.
function CraftingGuide:Refresh()
    if not self.current then return end
    local skill = self:GetSkill(self.current.guide)
    self.current.skillLevel       = skill
    self.current.currentStepIndex = self:FindStep(skill)
end

--- Query the player's live skill level for a profession.
-- Tries the guide's hard-coded skillLineID first, then falls back to
-- dynamically scanning all profession trade skill lines by name.
function CraftingGuide:GetSkill(guide)
    -- 1. Try the guide's configured skillLineID
    if guide.skillLineID then
        local skill = self:QuerySkillLine(guide.skillLineID)
        if skill then return skill end
    end

    -- 2. Fallback: scan all trade skill lines for a name match
    if C_TradeSkillUI and C_TradeSkillUI.GetAllProfessionTradeSkillLines then
        local lines = C_TradeSkillUI.GetAllProfessionTradeSkillLines()
        for _, lineID in ipairs(lines) do
            local info = self:QuerySkillLineInfo(lineID)
            if info and info.professionName == guide.name then
                -- Prefer the highest skill level found (handles Midnight vs base)
                local best = self:QuerySkillLine(lineID)
                if best and best > 0 then
                    return best
                end
            end
        end
    end

    return nil
end

--- Query a single skill line for its current skill level.
function CraftingGuide:QuerySkillLine(skillLineID)
    local info = self:QuerySkillLineInfo(skillLineID)
    if info and info.skillLevel and info.skillLevel > 0 then
        return info.skillLevel
    end
    return nil
end

--- Query raw profession info for a skill line.
function CraftingGuide:QuerySkillLineInfo(skillLineID)
    if not C_TradeSkillUI or not C_TradeSkillUI.GetProfessionInfoBySkillLineID then
        return nil
    end
    return C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
end

--- Find the index of the step matching the given skill level.
function CraftingGuide:FindStep(skill)
    if not skill or not self.current then return nil end
    local steps = self.current.guide.steps
    for i, step in ipairs(steps) do
        if skill >= step.startSkill and skill <= step.endSkill then
            return i
        end
    end
    -- Past the end of the guide: highlight the last step.
    if skill > (self.current.guide.maxSkill or 0) then
        return #steps
    end
    return nil
end

--- Clear the active guide.
function CraftingGuide:Unload()
    self.current = nil
    if ns.MainFrame then
        ns.MainFrame:HideGuide()
    end
end
