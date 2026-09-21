-- Trailhead — data/crafting/Tailoring.lua
--
-- PLACEHOLDER DATA. Real Midnight recipes must replace these names before
-- shipping. The STRUCTURE is final; only the contents need updating.

local _, ns = ...

local guide = {
    key         = "tailoring",
    name        = "Tailoring",
    skillLineID = 2918,          -- Midnight Tailoring skill line ID
    maxSkill    = 100,
    expansion   = "Midnight",
    steps = {
        {
            startSkill = 1,
            endSkill   = 15,
            recipe     = "Sample Pattern — Basic Cloth",
            materials  = {
                { name = "Midnight Cloth", count = 2 },
            },
            notes      = "Learn from your trainer. Cheap skill-ups.",
        },
        {
            startSkill = 15,
            endSkill   = 30,
            recipe     = "Sample Pattern — Cloth Gloves",
            materials  = {
                { name = "Midnight Cloth", count = 3 },
                { name = "Spool of Thread", count = 1 },
            },
            notes      = "Requires trainer training at skill 15.",
        },
        {
            startSkill = 30,
            endSkill   = 50,
            recipe     = "Sample Pattern — Cloth Bracers",
            materials  = {
                { name = "Midnight Cloth", count = 4 },
                { name = "Spool of Thread", count = 1 },
            },
            notes      = "Cheapest skill-ups in this range.",
        },
        {
            startSkill = 50,
            endSkill   = 70,
            recipe     = "Sample Pattern — Cloth Belt",
            materials  = {
                { name = "Midnight Cloth", count = 5 },
                { name = "Spool of Thread", count = 2 },
            },
            notes      = "Trainer training at skill 50 unlocks this.",
        },
        {
            startSkill = 70,
            endSkill   = 90,
            recipe     = "Sample Pattern — Cloth Boots",
            materials  = {
                { name = "Midnight Cloth", count = 6 },
                { name = "Spool of Thread", count = 2 },
                { name = "Fancy Trim", count = 1 },
            },
            notes      = "Requires specialization points.",
        },
        {
            startSkill = 90,
            endSkill   = 100,
            recipe     = "Sample Pattern — Cloth Robe",
            materials  = {
                { name = "Midnight Cloth", count = 8 },
                { name = "Spool of Thread", count = 3 },
                { name = "Fancy Trim", count = 2 },
            },
            notes      = "Final stretch. Auction house if you're in a hurry.",
        },
    },
}

ns.Data:RegisterCraftingGuide(guide.key, guide)
