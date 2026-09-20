-- Trailhead — src/ui/MainFrame.lua
--
-- The main window: title bar, close button, content area.
-- Content shows either the placeholder (no guide) or a scrollable step list.

local _, ns = ...

local MainFrame = {}
ns.MainFrame = MainFrame

local FRAME_NAME = "TrailheadMainFrame"
local ROW_HEIGHT = 64
local ROW_GAP    = 4

--- Lazily create the main frame.
function MainFrame:Init()
    if self.frame then return self.frame end

    local f = CreateFrame("Frame", FRAME_NAME, UIParent, "BackdropTemplate")
    f:SetSize(480, 600)
    f:SetFrameStrata("MEDIUM")
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:Hide()
    ns.Theme:ApplyBackdrop(f, "background")

    -- ── Title bar ──────────────────────────────────────────────────────────
    local titleBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    titleBar:SetPoint("TOPLEFT", 0, 0)
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

    local title = titleBar:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.title)
    title:SetPoint("LEFT", 12, 0)
    title:SetText(ns.L["WINDOW_TITLE"] or "Trailhead")
    local accent = ns.Theme.Colors.accent
    title:SetTextColor(accent[1], accent[2], accent[3], accent[4])
    f.title = title

    local close = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    close:SetPoint("RIGHT", -2, 0)
    f.closeButton = close

    -- ── Placeholder body (shown when no guide is loaded) ───────────────────
    local body = f:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    body:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 16, -16)
    body:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -16, 16)
    body:SetJustifyH("LEFT")
    body:SetJustifyV("TOP")
    local muted = ns.Theme.Colors.textMuted
    body:SetTextColor(muted[1], muted[2], muted[3], muted[4])
    body:SetText(ns.L["WINDOW_BODY_PLACEHOLDER"] or "")
    f.body = body

    -- ── Scroll frame (shown when a guide is loaded) ────────────────────────
    local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -30, 8)
    scroll:Hide()
    f.scroll = scroll

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(400, 1)
    scroll:SetScrollChild(content)
    f.scrollContent = content

    self.rows = {}
    self.frame = f

    tinsert(UISpecialFrames, FRAME_NAME)
    self:RestorePosition()
    return f
end

function MainFrame:Toggle()
    local f = self.frame or self:Init()
    if f:IsShown() then f:Hide() else f:Show() end
end

--- Show the scrollable guide view.
function MainFrame:ShowGuide()
    local f = self.frame or self:Init()
    f.body:Hide()
    f.scroll:Show()
    self:RefreshRows()
    f:Show()
end

--- Return to the placeholder view.
function MainFrame:HideGuide()
    local f = self.frame
    if not f then return end
    f.scroll:Hide()
    f.body:Show()
end

--- Repopulate the scroll view from the currently loaded guide.
function MainFrame:RefreshRows()
    local f = self.frame
    if not f then return end

    local state = ns.CraftingGuide and ns.CraftingGuide.current
    if not state then
        self:HideGuide()
        return
    end

    local steps = state.guide.steps
    local content = f.scrollContent

    content:SetWidth(f.scroll:GetWidth() or 400)
    content:SetHeight(math.max(#steps * (ROW_HEIGHT + ROW_GAP), 1))

    for i, step in ipairs(steps) do
        local row = self.rows[i]
        if not row then
            row = ns.StepRow:Create(content)
            self.rows[i] = row
        end

        local y = -((i - 1) * (ROW_HEIGHT + ROW_GAP))
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT",  0, y)
        row:SetPoint("TOPRIGHT", 0, y)
        row:Show()

        local rowState = "future"
        if i < (state.currentStepIndex or 0) then
            rowState = "done"
        elseif i == state.currentStepIndex then
            rowState = "current"
        end

        row:SetStep(step, i, rowState)
    end

    -- Hide leftovers from a previous, longer guide
    for i = #steps + 1, #self.rows do
        self.rows[i]:Hide()
    end
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