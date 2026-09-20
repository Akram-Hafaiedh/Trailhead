-- locales/frFR.lua
-- Français (France)
--
-- Only loads on French clients. Overrides individual keys from enUS.lua.
-- Any key not present here falls back to the English value.

local ADDON_NAME, ns = ...

if GetLocale() ~= "frFR" then return end

local L = ns.L

-- ── Addon metadata ────────────────────────────────────────────────────────
L["ADDON_TAGLINE"] = "Chaque voyage commence quelque part. Commencez ici."

-- ── Load / unload messages ────────────────────────────────────────────────
L["MSG_LOADED"] = "|cff33ff99Trailhead|r chargé. Tapez |cffffff00/th|r pour ouvrir."

-- ── Slash command feedback ────────────────────────────────────────────────
L["SLASH_TOGGLE"]  = "Ouverture/fermeture de la fenêtre Trailhead."
L["SLASH_UNKNOWN"] = "Commande inconnue : %s. Tapez |cffffff00/th help|r pour les options."

-- ── Main window ───────────────────────────────────────────────────────────
L["WINDOW_TITLE"] = "Trailhead"

-- ── TODO(localization): translate remaining keys as phases ship ───────────
-- Untranslated keys will display in English until translated.