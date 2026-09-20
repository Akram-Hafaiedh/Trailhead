-- Trailhead — src/Slash.lua
--
-- Registers /th and /trail.
-- Phase 1: toggle, help, version. Other subcommands are stubs.

local _, ns = ...

local function printHelp()
    ns:Print(ns:Str("SLASH_HELP_HEADER"))
    ns:Print(ns:Str("SLASH_HELP_TOGGLE"))
    ns:Print(ns:Str("SLASH_HELP_CRAFT"))
    ns:Print(ns:Str("SLASH_HELP_FARM"))
    ns:Print(ns:Str("SLASH_HELP_ROUTE"))
    ns:Print(ns:Str("SLASH_HELP_OPTIONS"))
    ns:Print(ns:Str("SLASH_HELP_RESET"))
    ns:Print(ns:Str("SLASH_HELP_RESET_POS"))
    ns:Print(ns:Str("SLASH_HELP_VERSION"))
    ns:Print(ns:Str("SLASH_HELP_HELP"))
end

local function handleCommand(msg)
    msg = (msg or ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()
    local cmd, rest = msg:match("^(%S*)%s*(.*)$")

    if cmd == "" or cmd == "toggle" then
        ns.MainFrame:Toggle()
        ns:Print(ns:Str("SLASH_TOGGLE"))

    elseif cmd == "help" then
        printHelp()

    elseif cmd == "version" then
        ns:Print(ns.version)

    elseif cmd == "craft" then
        -- TODO(phase-2): load crafting guide by name (rest)
        ns:Print("Crafting guides arrive in Phase 2. (requested: " .. tostring(rest) .. ")")

    elseif cmd == "farm" then
        -- TODO(phase-3): load gathering route by name (rest)
        ns:Print("Gathering routes arrive in Phase 3. (requested: " .. tostring(rest) .. ")")

    elseif cmd == "route" then
        -- TODO(phase-3): start/stop route overlay
        ns:Print("Route overlay arrives in Phase 3.")

    elseif cmd == "options" then
        -- TODO(phase-6): open options panel
        ns:Print("Options panel arrives in Phase 6.")

    elseif cmd == "reset" then
        -- TODO(phase-2): reset guide/route progress
        ns:Print("Reset will be implemented alongside guides.")

    elseif cmd == "reset-position" then
        local db = ns.DB:Get()
        db.window = nil
        ns.MainFrame.frame:ClearAllPoints()
        ns.MainFrame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        ns:Print("Window position reset.")
    else
        ns:Print(ns:Str("SLASH_UNKNOWN", cmd))
    end
end

SLASH_TRAILHEAD1 = "/th"
SLASH_TRAILHEAD2 = "/trail"
SlashCmdList["TRAILHEAD"] = handleCommand