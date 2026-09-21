-- Trailhead — src/Slash.lua
--
-- Registers /th and /trail.
-- Phase 1: toggle, help, version. Other subcommands are stubs.

local _, ns = ...

local function printHelp()
    ns:Print(ns:Str("SLASH_HELP_HEADER"))
    ns:Print(ns:Str("SLASH_HELP_TOGGLE"))
    ns:Print(ns:Str("SLASH_HELP_CRAFT"))
    ns:Print(ns:Str("SLASH_HELP_LIST"))
    ns:Print(ns:Str("SLASH_HELP_OPTIONS"))
    ns:Print(ns:Str("SLASH_HELP_RESET"))
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
        if rest == "" then
            ns:Print("Usage: /th craft <profession>")
        else
            ns.CraftingGuide:Load(rest)
        end

    elseif cmd == "list" then
        if ns.CraftingGuide.current then
            ns.MainFrame:ShowGuide(ns.MainFrame.headerText:GetText())
            ns.MainFrame:SetActiveTab("shopping")
        else
            ns:Print(ns:Str("SHOPPING_NO_GUIDE"))
        end

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
