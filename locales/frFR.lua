-- locales/frFR.lua
-- Français (France)
--
-- Only loads on French clients. Overrides individual keys from enUS.lua.
-- Any key not present here falls back to the English value.

local _, ns = ...

if GetLocale() ~= "frFR" then return end

local L = ns.L

-- ── Addon metadata ────────────────────────────────────────────────────────
L["ADDON_TAGLINE"] = "Chaque voyage commence quelque part. Commencez ici."

-- ── Load / unload messages ────────────────────────────────────────────────
L["MSG_LOADED"]  = "|cff33ff99Trailhead|r chargé. Tapez |cffffff00/th|r pour ouvrir."
L["MSG_ENABLED"] = "|cff33ff99Trailhead|r activé."

-- ── Slash command feedback ────────────────────────────────────────────────
L["SLASH_TOGGLE"]       = "Ouverture/fermeture de la fenêtre."
L["SLASH_UNKNOWN"]      = "Commande inconnue : |cffffff00%s|r. Tapez |cffffff00/th help|r."
L["SLASH_HELP_HEADER"]  = "Commandes disponibles :"
L["SLASH_HELP_TOGGLE"]  = "  /th            — Basculer la fenêtre principale"
L["SLASH_HELP_CRAFT"]   = "  /th craft <m>  — Charger un guide de métier (ex : /th craft coutellerie)"
L["SLASH_HELP_FARM"]    = "  /th farm <m>   — Charger une route de collecte (ex : /th farm minage)"
L["SLASH_HELP_ROUTE"]   = "  /th route      — Activer/désactiver la superposition d'itinéraire"
L["SLASH_HELP_OPTIONS"] = "  /th options    — Ouvrir le panneau d'options"
L["SLASH_HELP_RESET"]   = "  /th reset      — Réinitialiser la progression du guide/itinéraire"
L["SLASH_HELP_VERSION"] = "  /th version    — Afficher la version du complément"
L["SLASH_HELP_HELP"]    = "  /th help       — Afficher ce message"
L["SLASH_HELP_RESET_POS"] = "  /th reset-position - Recentrer la fenetre"



-- ── Main window ───────────────────────────────────────────────────────────
L["WINDOW_TITLE"] = "Trailhead"
L["WINDOW_BODY_PLACEHOLDER"] = "Squelette de la phase 1 — aucun guide chargé pour l'instant.\n\nÀ bientôt."
-- ── TODO(phase-2): crafting guide strings ─────────────────────────────────
-- ── TODO(phase-3): gathering route strings ────────────────────────────────
-- ── TODO(phase-4): shopping list strings ──────────────────────────────────
-- ── TODO(phase-5): knowledge / spec strings ───────────────────────────────