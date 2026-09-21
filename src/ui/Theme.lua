-- Trailhead — src/ui/Theme.lua
--
-- Design tokens. UI modules pull from here instead of hard-coding values.

local _, ns = ...

local Theme = {}
ns.Theme = Theme

Theme.Colors = {
    background = { 0.055, 0.055, 0.075, 0.96 }, -- near-black, slight blue tilt
    panel      = { 0.100, 0.100, 0.130, 1.00 },
    panelAlt   = { 0.140, 0.140, 0.170, 1.00 },
    border     = { 0.220, 0.220, 0.270, 1.00 },
    accent     = { 0.200, 1.000, 0.600, 1.00 }, -- Trailhead green
    accentDim  = { 0.150, 0.700, 0.450, 1.00 },
    text       = { 0.920, 0.920, 0.940, 1.00 },
    textMuted  = { 0.600, 0.600, 0.650, 1.00 },
    danger     = { 1.000, 0.350, 0.350, 1.00 },
}

Theme.Fonts = {
    title  = "GameFontNormalLarge",
    header = "GameFontNormal",
    body   = "GameFontHighlight",
    muted  = "GameFontDisableSmall",
}

Theme.Spacing = {
    xs = 2,
    sm = 4,
    md = 8,
    lg = 16,
    xl = 24,
}

--- Apply a themed backdrop to a frame.
-- @param frame    the frame to style
-- @param variant  "background" (default), "panel", or "panelAlt"
function Theme:ApplyBackdrop(frame, variant)
    variant = variant or "background"
    local bg = self.Colors[variant] or self.Colors.background

    frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile     = false,
        tileSize = 0,
        edgeSize = 1,
        insets   = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    frame:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    frame:SetBackdropBorderColor(
        self.Colors.border[1], self.Colors.border[2],
        self.Colors.border[3], self.Colors.border[4]
    )
end
