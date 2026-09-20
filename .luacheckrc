std = "lua51"
max_line_length = 120

-- Globals we both read and write
globals = {
    "Trailhead",
    "TrailheadDB",
    "SLASH_TRAILHEAD1",
    "SLASH_TRAILHEAD2",
    "SlashCmdList",
}

-- WoW API — read-only from our perspective
read_globals = {
    "C_AddOns",
    "CreateFrame",
    "DEFAULT_CHAT_FRAME",
    "GetAddOnMetadata",
    "GetLocale",
    "UIParent",
    "UISpecialFrames",
    "tinsert",
}

ignore = {
    "212", -- unused argument
}