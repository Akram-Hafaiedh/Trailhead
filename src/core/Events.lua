-- Trailhead — src/core/Events.lua
--
-- Namespace bootstrap + event dispatcher.
-- MUST load first among core files: it publishes the shared namespace,
-- defines ns:Print, sets ns.version, and provides ns.Events.

local ADDON_NAME, ns = ...

-- ── Namespace bootstrap ────────────────────────────────────────────────────
ns.addonName = ADDON_NAME

local function getVersion()
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
    end
    if GetAddOnMetadata then
        return GetAddOnMetadata(ADDON_NAME, "Version")
    end
    return "dev"
end

ns.version = getVersion() or "dev"

-- Expose the namespace as a global for convenience in-game (e.g. /dump Trailhead).
_G[ADDON_NAME] = ns

-- ── Chat helper ────────────────────────────────────────────────────────────
local PREFIX = "|cff33ff99Trailhead|r: "

function ns:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. tostring(msg))
end

--- Safe localized string accessor.
-- Usage: ns:Str("SLASH_UNKNOWN", "foo")
function ns:Str(key, ...)
    local L = ns.L or {}
    local str = L[key]
    if str == nil then
        return "[" .. tostring(key) .. "]"
    end
    if select("#", ...) > 0 then
        return str:format(...)
    end
    return str
end

-- ── Event dispatcher ───────────────────────────────────────────────────────
local Events = {}
ns.Events = Events

local frame    = CreateFrame("Frame")
local handlers = {}

--- Register a callback for a WoW event. Multiple callbacks per event allowed.
function Events:Register(event, callback)
    if type(event) ~= "string" or type(callback) ~= "function" then
        error("Events:Register(event:string, callback:function)")
    end
    if not handlers[event] then
        handlers[event] = {}
        frame:RegisterEvent(event)
    end
    handlers[event][#handlers[event] + 1] = callback
end

--- Fire all callbacks for an event (useful for testing).
function Events:Fire(event, ...)
    local list = handlers[event]
    if not list then return end
    for i = 1, #list do
        list[i](event, ...)
    end
end

frame:SetScript("OnEvent", function(_, event, ...)
    Events:Fire(event, ...)
end)
