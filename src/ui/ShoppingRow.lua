-- Trailhead — src/ui/ShoppingRow.lua
--
-- Row widget for a single material in the shopping list.

local _, ns = ...

local ShoppingRow = {}
ns.ShoppingRow = ShoppingRow

local ROW_HEIGHT = 28

function ShoppingRow:Create(parent)
    local row = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    row:SetHeight(ROW_HEIGHT)
    ns.Theme:ApplyBackdrop(row, "panel")

    local name = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    name:SetPoint("LEFT", 10, 0)
    name:SetJustifyH("LEFT")
    row.name = name

    local count = row:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    count:SetPoint("RIGHT", -10, 0)
    count:SetJustifyH("RIGHT")
    row.count = count

    row.SetMaterial = function(_, material)
        local text = ns.Theme.Colors.text
        local accent = ns.Theme.Colors.accent
        row.name:SetText(material.name)
        row.name:SetTextColor(text[1], text[2], text[3], text[4])
        row.count:SetText(string.format("×%d", material.count))
        row.count:SetTextColor(accent[1], accent[2], accent[3], accent[4])
    end

    return row
end
