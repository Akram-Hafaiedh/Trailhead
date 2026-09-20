-- Trailhead — src/ui/MainFrame.lua
--
-- The main window: title bar, close button, content area.
-- Movable, ESC-closable. Position saved to TrailheadDB.window.

local _, ns = ...

local MainFrame = {}
ns.MainFrame = MainFrame

local FRAME_NAME = "TrailheadMainFrame"

--- Lazily create the main frame. Called once from Init.lua on PLAYER_LOGIN.
function MainFrame:Init()
    if self.frame then return self.frame end

    local f = CreateFrame("Frame", FRAME_NAME, UIParent, "BackdropTemplate")
    f:SetSize(480, 600)
    f:SetFrameStrata("MEDIUM")
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:Hide()
    ns.Theme:ApplyBackdrop(f, "background")

    -- ── Title bar (drag handle) ────────────────────────────────────────────
    local titleBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    titleBar:SetPoint("TOPLEFT",  0, 0)
    titleBar:SetPoint("TOPRIGHT", 0, 0)
    titleBar:SetHeight(32)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() f:StartMoving() end)
    titleBar:SetScript("OnDragStop", function()
        f:StopMovingOrSizing()
        self:SavePosition()
    end)
    ns.Theme:ApplyBackdrop(titleBar, "panel")
    f.titleBar = titleBar

    -- ── Title text ─────────────────────────────────────────────────────────
    local title = titleBar:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.title)
    title:SetPoint("LEFT", 12, 0)
    title:SetText(ns.L["WINDOW_TITLE"] or "Trailhead")
    title:SetTextColor(
        ns.Theme.Colors.accent[1], ns.Theme.Colors.accent[2],
        ns.Theme.Colors.accent[3], ns.Theme.Colors.accent[4]
    )
    f.title = title

    -- ── Close button ───────────────────────────────────────────────────────
    local close = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    close:SetPoint("RIGHT", -2, 0)
    f.closeButton = close

    -- ── Content area (placeholder for Phase 2+) ────────────────────────────
    local body = f:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    body:SetPoint("TOPLEFT",     titleBar, "BOTTOMLEFT",  16, -16)
    body:SetPoint("BOTTOMRIGHT", f,        "BOTTOMRIGHT", -16,  16)
    body:SetJustifyH("LEFT")
    body:SetJustifyV("TOP")
    body:SetTextColor(
        ns.Theme.Colors.textMuted[1], ns.Theme.Colors.textMuted[2],
        ns.Theme.Colors.textMuted[3], ns.Theme.Colors.textMuted[4]
    )
    body:SetText(ns.L["WINDOW_BODY_PLACEHOLDER"] or "")
    f.body = body

    -- ── ESC dismisses the window ───────────────────────────────────────────
    tinsert(UISpecialFrames, FRAME_NAME)

    self.frame = f
    self:RestorePosition()
    return f
end

--- Toggle visibility.
function MainFrame:Toggle()
    local f = self.frame or self:Init()
    if f:IsShown() then f:Hide() else f:Show() end
end

--- Save the current frame position + size to the database.
function MainFrame:SavePosition()
    local f = self.frame
    if not f then return end
    local db = ns.DB:Get()
    local point, _, _, x, y = f:GetPoint(1)
    db.window = db.window or {}
    db.window.point  = point
    db.window.x      = x
    db.window.y      = y
    db.window.width  = f:GetWidth()
    db.window.height = f:GetHeight()
end

--- Restore position + size from the database.
function MainFrame:RestorePosition()
    local f = self.frame
    if not f then return end
    local win = ns.DB:Get().window or {}
    f:ClearAllPoints()
    f:SetPoint(win.point or "CENTER", UIParent, win.point or "CENTER", win.x or 0, win.y or 0)
    if win.width  then f:SetWidth(win.width)   end
    if win.height then f:SetHeight(win.height) end
end