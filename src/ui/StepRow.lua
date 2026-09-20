-- Trailhead — src/ui/StepRow.lua
--
-- Row widget for a single crafting guide step.

local _, ns = ...

local StepRow = {}
ns.StepRow = StepRow

local ROW_HEIGHT = 64

--- Create a step row.
function StepRow:Create(parent)
    local row = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    row:SetHeight(ROW_HEIGHT)
    ns.Theme:ApplyBackdrop(row, "panel")

    -- Skill range (right-aligned)
    local skillRange = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.muted)
    skillRange:SetPoint("TOPRIGHT", -8, -6)
    skillRange:SetJustifyH("RIGHT")
    row.skillRange = skillRange

    -- Recipe name (top-left, spans to skill range)
    local recipe = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    recipe:SetPoint("TOPLEFT", 8, -6)
    recipe:SetPoint("TOPRIGHT", skillRange, "TOPLEFT", -8, 0)
    recipe:SetJustifyH("LEFT")
    row.recipe = recipe

    -- Materials (below recipe)
    local materials = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.muted)
    materials:SetPoint("TOPLEFT", recipe, "BOTTOMLEFT", 0, -4)
    materials:SetPoint("TOPRIGHT", skillRange, "BOTTOMRIGHT", 0, -4)
    materials:SetJustifyH("LEFT")
    row.materials = materials

    -- Populate the row.
    -- @param step   the guide step table
    -- @param index  step number (1-based)
    -- @param state  "done" | "current" | "future"
    row.SetStep = function(_, step, index, state)
        local accent = ns.Theme.Colors.accent
        local muted  = ns.Theme.Colors.textMuted
        local text   = ns.Theme.Colors.text
        local border = ns.Theme.Colors.border

        row.skillRange:SetText(string.format("%d–%d", step.startSkill, step.endSkill))

        if state == "done" then
            row.recipe:SetText("|cff00ff00*|r " .. step.recipe)
            row.recipe:SetTextColor(muted[1], muted[2], muted[3], muted[4])
            row.materials:SetTextColor(muted[1], muted[2], muted[3], muted[4])
            row:SetBackdropBorderColor(border[1], border[2], border[3], border[4])

        elseif state == "current" then
            row.recipe:SetText("|cff00ff00>|r " .. step.recipe)
            row.recipe:SetTextColor(accent[1], accent[2], accent[3], accent[4])
            row.materials:SetTextColor(text[1], text[2], text[3], text[4])
            row:SetBackdropBorderColor(accent[1], accent[2], accent[3], accent[4])

        else
            row.recipe:SetText(step.recipe)
            row.recipe:SetTextColor(text[1], text[2], text[3], text[4])
            row.materials:SetTextColor(muted[1], muted[2], muted[3], muted[4])
            row:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
        end

        if step.materials and #step.materials > 0 then
            local parts = {}
            for _, mat in ipairs(step.materials) do
                parts[#parts + 1] = string.format("%dx %s", mat.count, mat.name)
            end
            row.materials:SetText(table.concat(parts, "  ·  "))
        else
            row.materials:SetText("")
        end
    end

    return row
end