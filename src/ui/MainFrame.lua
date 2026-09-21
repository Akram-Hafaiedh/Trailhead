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

        -- ── Header strip (shows loaded guide name + skill) ─────────────────────
    local header = CreateFrame("Frame", nil, f, "BackdropTemplate")
    header:SetPoint("TOPLEFT",  titleBar, "BOTTOMLEFT",  0, 0)
    header:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", 0, 0)
    header:SetHeight(24)
    header:Hide()
    ns.Theme:ApplyBackdrop(header, "panelAlt")
    f.header = header

    local headerText = header:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
    headerText:SetPoint("LEFT", 12, 0)
    headerText:SetPoint("RIGHT", -12, 0)
    headerText:SetJustifyH("LEFT")
    headerText:SetTextColor(accent[1], accent[2], accent[3], accent[4])
    f.headerText = headerText


    -- ── Tab bar (Steps / Shopping List) ────────────────────────────────────
    local tabBar = CreateFrame("Frame", nil, f)
    tabBar:SetPoint("TOPLEFT",  header, "BOTTOMLEFT",  0, -4)
    tabBar:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, -4)
    tabBar:SetHeight(22)
    tabBar:Hide()
    f.tabBar = tabBar

    local function makeTab(id, label, xOffset)
        local btn = CreateFrame("Button", nil, tabBar, "BackdropTemplate")
        btn:SetPoint("LEFT", xOffset, 0)
        btn:SetSize(120, 22)
        btn:SetBackdrop({
            bgFile   = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
            insets   = { left = 0, right = 0, top = 0, bottom = 0 },
        })
        btn:SetBackdropColor(0.10, 0.10, 0.13, 1)
        btn:SetBackdropBorderColor(0.22, 0.22, 0.27, 1)

        local txt = btn:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.body)
        txt:SetAllPoints(btn)
        txt:SetJustifyH("CENTER")
        txt:SetText(label)
        btn.text = txt
        btn.tabID = id

        -- Accent underline shown only for the active tab
        local underline = btn:CreateTexture(nil, "OVERLAY")
        underline:SetPoint("BOTTOMLEFT",  1, 0)
        underline:SetPoint("BOTTOMRIGHT", -1, 0)
        underline:SetHeight(2)
        underline:SetColorTexture(0.2, 1, 0.6, 1)
        underline:Hide()
        btn.underline = underline

        btn:SetScript("OnClick", function()
            ns.MainFrame:SetActiveTab(id)
        end)

        btn:SetScript("OnEnter", function(b)
            b:SetBackdropColor(0.18, 0.18, 0.22, 1)
        end)

        btn:SetScript("OnLeave", function(b)
            if ns.MainFrame.activeTab == id then
                b:SetBackdropColor(0.18, 0.18, 0.22, 1)
            else
                b:SetBackdropColor(0.10, 0.10, 0.13, 1)
            end
        end)

        return btn
    end

    f.tabSteps    = makeTab("steps",    ns:Str("TAB_STEPS"),    8)
    f.tabShopping = makeTab("shopping", ns:Str("TAB_SHOPPING"), 132)

    local close = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    close:SetPoint("RIGHT", -2, 0)
    close:SetScript("OnClick", function() f:Hide() end)   -- ← add this
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
    scroll:SetPoint("TOPLEFT", tabBar, "BOTTOMLEFT", 8, -4)
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
function MainFrame:ShowGuide(headerText)
    local f = self.frame or self:Init()
    f.body:Hide()
    f.header:Show()
    f.tabBar:Show()
    f.headerText:SetText(headerText or "")
    f.scroll:Show()
    self.activeTab = self.activeTab or "steps"
    self:SetActiveTab(self.activeTab)
    f:Show()
end


--- Return to the placeholder view.
function MainFrame:HideGuide()
    local f = self.frame
    if not f then return end
    f.header:Hide()
    f.tabBar:Hide()
    f.scroll:Hide()
    f.body:Show()
end

--- Repopulate the scroll view with the crafting step list.
function MainFrame:RefreshRows()
    local f = self.frame
    if not f then return end

    local state = ns.CraftingGuide and ns.CraftingGuide.current
    if not state then
        self:HideGuide()
        return
    end

    self:ClearRows()

    local steps   = state.guide.steps
    local content = f.scrollContent

    content:SetWidth(f.scroll:GetWidth() or 400)
    content:SetHeight(math.max(#steps * (ROW_HEIGHT + ROW_GAP), 1))

    for i, step in ipairs(steps) do
        local row = ns.StepRow:Create(content)
        local y = -((i - 1) * (ROW_HEIGHT + ROW_GAP))
        row:SetPoint("TOPLEFT",  0, y)
        row:SetPoint("TOPRIGHT", 0, y)

        local rowState = "future"
        if i < (state.currentStepIndex or 0) then
            rowState = "done"
        elseif i == state.currentStepIndex then
            rowState = "current"
        end

        row:SetStep(step, i, rowState)
        self.rows[i] = row
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

--- Switch which tab is active.
-- @param id  "steps" | "shopping"
function MainFrame:SetActiveTab(id)
    local f = self.frame
    if not f then return end
    self.activeTab = id or "steps"

    local accent = ns.Theme.Colors.accent
    local muted  = ns.Theme.Colors.textMuted

    local function paint(btn, active)
        if active then
            btn.text:SetTextColor(accent[1], accent[2], accent[3], accent[4])
            btn:SetBackdropColor(0.18, 0.18, 0.22, 1)
            btn:SetBackdropBorderColor(accent[1], accent[2], accent[3], 1)
            btn.underline:Show()
        else
            btn.text:SetTextColor(muted[1], muted[2], muted[3], muted[4])
            btn:SetBackdropColor(0.10, 0.10, 0.13, 1)
            btn:SetBackdropBorderColor(0.22, 0.22, 0.27, 1)
            btn.underline:Hide()
        end
    end

    paint(f.tabSteps,    self.activeTab == "steps")
    paint(f.tabShopping, self.activeTab == "shopping")

    if self.activeTab == "shopping" then
        self:RenderShopping()
    else
        self:RenderSteps()
    end
end

--- Render the crafting step list.
function MainFrame:RenderSteps()
    self:RefreshRows()
end

--- Render the shopping list.
function MainFrame:RenderShopping()
    local f = self.frame
    if not f then return end

    local state = ns.CraftingGuide and ns.CraftingGuide.current
    if not state then
        self:HideGuide()
        return
    end

    self:ClearRows()

    local list    = ns.ShoppingList:Generate(state)
    local content = f.scrollContent

    content:SetWidth(f.scroll:GetWidth() or 400)
    content:SetHeight(math.max(#list * (28 + 4), 1))

    for i, mat in ipairs(list) do
        local row = ns.ShoppingRow:Create(content)
        row:SetPoint("TOPLEFT",  0, -((i - 1) * (28 + 4)))
        row:SetPoint("TOPRIGHT", 0, -((i - 1) * (28 + 4)))
        row:SetMaterial(mat)
        self.rows[i] = row
    end

    if #list == 0 then
        local lbl = content:CreateFontString(nil, "OVERLAY", ns.Theme.Fonts.muted)
        lbl:SetPoint("TOPLEFT", 8, -8)
        lbl:SetText(ns:Str("SHOPPING_EMPTY"))
        self.rows.emptyLabel = lbl
    end
end

--- Detach and hide every row. Called at the start of each render.
function MainFrame:ClearRows()
    for _, row in ipairs(self.rows) do
        row:Hide()
        row:SetParent(nil)
    end
    self.rows = {}
end