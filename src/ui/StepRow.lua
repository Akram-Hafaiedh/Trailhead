-- Trailhead — src/ui/StepRow.lua
--
-- Row widget for a single crafting guide step.
-- Phase 1: minimal factory so MainFrame can render placeholder rows.
-- Phase 2: implement SetStep(step) to render recipe + materials + notes.

local _, ns = ...

local StepRow = {}
ns.StepRow = StepRow

--- Create a step row.
-- @param parent  the scroll child / container frame
function StepRow:Create(parent)
    local row = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    row:SetHeight(48)
    ns.Theme:ApplyBackdrop(row, "panel")

    local label = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    label:SetPoint("LEFT", 8, 0)
    label:SetText("—")
    row.label = label

    -- TODO(phase-2): render recipe name, materials, notes, done checkmark.
    row.SetStep = function(_, step)
        row.label:SetText(step and (step.recipe or "?") or "—")
    end

    return row
end