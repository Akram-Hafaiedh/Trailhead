-- locales/enUS.lua
-- English (US) — source of truth.
--
-- This file ALWAYS loads, on every client. It populates the base string table.
-- Other locale files (frFR, deDE, ...) load AFTER this one and override keys
-- they've translated. Any key they don't override falls back to English.

local _, ns = ...

local L = {}
ns.L = L

-- ── Addon metadata ────────────────────────────────────────────────────────
L["ADDON_NAME"]    = "Trailhead"
L["ADDON_TAGLINE"] = "Every journey starts somewhere. Start here."

-- ── Load / unload messages ────────────────────────────────────────────────
L["MSG_LOADED"]  = "|cff33ff99Trailhead|r loaded. Type |cffffff00/th|r to open."
L["MSG_ENABLED"] = "|cff33ff99Trailhead|r enabled."

-- ── Slash command feedback ────────────────────────────────────────────────
L["SLASH_TOGGLE"]       = "Toggling window."
L["SLASH_UNKNOWN"]      = "Unknown command: |cffffff00%s|r. Type |cffffff00/th help|r."
L["SLASH_HELP_HEADER"]  = "Available commands:"
L["SLASH_HELP_TOGGLE"]  = "  /th            — Toggle the main window"
L["SLASH_HELP_CRAFT"]   = "  /th craft <p>  — Load a crafting guide (e.g. /th craft tailoring)"
L["SLASH_HELP_FARM"]    = "  /th farm <p>   — Load a gathering route (e.g. /th farm mining)"
L["SLASH_HELP_ROUTE"]   = "  /th route      — Start or stop the active route overlay"
L["SLASH_HELP_OPTIONS"] = "  /th options    — Open the options panel"
L["SLASH_HELP_RESET"]   = "  /th reset      — Reset guide/route progress"
L["SLASH_HELP_VERSION"] = "  /th version    — Show the addon version"
L["SLASH_HELP_HELP"]    = "  /th help       — Show this message"
L["SLASH_HELP_RESET_POS"] = "  /th reset-position — Recenter the window"

-- ── Main window ───────────────────────────────────────────────────────────
L["WINDOW_TITLE"] = "Trailhead"
L["WINDOW_BODY_PLACEHOLDER"] = "Phase 1 skeleton — no guides loaded yet.\n\nCheck back soon."
-- ── Crafting guide ─────────────────────────────────────────────────────────
L["CRAFT_GUIDE_NOT_FOUND"] = "No guide found for |cffffff00%s|r."
L["CRAFT_GUIDE_LOADED"]    = "Loaded %s guide (skill %d/%d)."
L["CRAFT_GUIDE_NO_SKILL"]  = "You haven't learned %s on this character."

-- ── TODO(phase-3): gathering route strings ────────────────────────────────
-- ── TODO(phase-4): shopping list strings ──────────────────────────────────
-- ── TODO(phase-5): knowledge / spec strings ───────────────────────────────