-- Trailhead — src/ui/RouteRow.lua
--
-- Row widget for a single gathering route.
-- Phase 1: minimal factory stub. Real implementation lands in Phase 3.

local _, ns = ...

local RouteRow = {}
ns.RouteRow = RouteRow

--- Create a route row.
-- @param parent  the scroll child / container frame
function RouteRow:Create(parent)
    local row = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    row:SetHeight(48)
    ns.Theme:ApplyBackdrop(row, "panel")

    local label = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    label:SetPoint("LEFT", 8, 0)
    label:SetText("—")
    row.label = label

    -- TODO(phase-3): render zone name, node types, yield estimate.
    row.SetRoute = function(_, route)
        row.label:SetText(route and (route.zone or "?") or "—")
    end

    return row
end