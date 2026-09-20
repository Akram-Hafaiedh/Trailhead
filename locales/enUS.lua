-- locales/enUS.lua
-- English (US) — source of truth.
--
-- This file ALWAYS loads, on every client. It populates the base string table.
-- Other locale files (frFR, deDE, ...) load AFTER this one and override keys
-- they've translated. Any key they don't override falls back to English.

local ADDON_NAME, ns = ...

local L = {}
ns.L = L

-- ── Addon metadata ────────────────────────────────────────────────────────
L["ADDON_NAME"]    = "Trailhead"
L["ADDON_TAGLINE"] = "Every journey starts somewhere. Start here."

-- ── Load / unload messages ────────────────────────────────────────────────
L["MSG_LOADED"]  = "|cff33ff99Trailhead|r loaded. Type |cffffff00/th|r to open."
L["MSG_ENABLED"] = "|cff33ff99Trailhead|r enabled."

-- ── Slash command feedback ────────────────────────────────────────────────
L["SLASH_TOGGLE"]  = "Toggling Trailhead window."
L["SLASH_UNKNOWN"] = "Unknown command: %s. Type |cffffff00/th help|r for options."

-- ── Main window ───────────────────────────────────────────────────────────
L["WINDOW_TITLE"] = "Trailhead"

-- ── TODO(phase-2): crafting guide strings ─────────────────────────────────
-- ── TODO(phase-3): gathering route strings ────────────────────────────────
-- ── TODO(phase-4): shopping list strings ──────────────────────────────────
-- ── TODO(phase-5): knowledge / spec strings ───────────────────────────────