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
L["SLASH_HELP_CRAFT"]   = "  /th craft <m>  — Charger un guide de métier (ex : /th craft couture)"
L["SLASH_HELP_ROUTE"] = "  /th route      — Arrêter l'itinéraire actif"
L["SLASH_HELP_OPTIONS"] = "  /th options    — Ouvrir le panneau d'options"
L["SLASH_HELP_RESET"]   = "  /th reset      — Réinitialiser la progression du guide/itinéraire"
L["SLASH_HELP_VERSION"] = "  /th version    — Afficher la version de l'addon"
L["SLASH_HELP_HELP"]    = "  /th help       — Afficher ce message"
L["SLASH_HELP_RESET_POS"] = "  /th reset-position — Réinitialiser la position de la fenêtre"
-- ── Main window ───────────────────────────────────────────────────────────
L["WINDOW_TITLE"] = "Trailhead"
L["WINDOW_BODY_PLACEHOLDER"] = "Squelette de la phase 1 — aucun guide chargé pour l'instant.\n\nÀ bientôt."
L["CRAFT_GUIDE_NOT_FOUND"] = "Aucun guide trouvé pour |cffffff00%s|r."
L["CRAFT_GUIDE_LOADED"]    = "Guide %s chargé (compétence %d/%d)."
L["CRAFT_GUIDE_NO_SKILL"]  = "Vous n'avez pas appris %s avec ce personnage."
-- ── Shopping list ──────────────────────────────────────────────────────────
L["TAB_STEPS"]         = "Étapes"
L["TAB_SHOPPING"]      = "Liste de courses"
L["SHOPPING_EMPTY"]    = "Rien à acheter — vous avez terminé !"
L["SHOPPING_NO_GUIDE"] = "Chargez d'abord un guide de métier (/th craft couture)."

-- ── Slash help ─────────────────────────────────────────────────────────────
L["SLASH_HELP_LIST"]   = "  /th list       — Ouvrir la liste de courses"

-- ── TODO(phase-5): knowledge / spec strings ───────────────────────────────
