-- Trailhead — src/core/Init.lua
--
-- Final bootstrap. MUST load last (see Trailhead.toc).
-- Wires up the addon lifecycle by registering event callbacks.

local ADDON_NAME, ns = ...

-- ── ADDON_LOADED: initialize saved variables ───────────────────────────────
ns.Events:Register("ADDON_LOADED", function(_, name)
    if name ~= ADDON_NAME then return end
    ns.DB:Init()
end)

-- ── PLAYER_LOGIN: build the UI, announce ───────────────────────────────────
ns.Events:Register("PLAYER_LOGIN", function()
    ns.MainFrame:Init()
    ns:Print(ns.version .. " " .. ns:Str("MSG_LOADED"))
end)