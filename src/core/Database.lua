-- Trailhead — src/core/Database.lua
--
-- Saved variables: TrailheadDB
-- Schema versioning + forward-only migrations.
-- Add a new migration function to DB.migrations when the schema changes.

local _, ns = ...

local DB_VERSION = 1

local DB = {}
ns.DB = DB

-- ── Migrations ─────────────────────────────────────────────────────────────
-- Each entry [N] migrates the database from version N-1 to version N.
-- Migrations run in ascending order; the final version is set to DB_VERSION.
DB.migrations = {
    [1] = function(db)
        db.window = db.window or {
            point  = "CENTER",
            x      = 0,
            y      = 0,
            width  = 480,
            height = 600,
        }
        -- TODO(phase-2): seed guide progress table
        -- TODO(phase-3): seed route progress table
    end,
}

--- Initialize TrailheadDB. Call from ADDON_LOADED.
function DB:Init()
    if type(TrailheadDB) ~= "table" then
        TrailheadDB = {}
    end
    if type(TrailheadDB.version) ~= "number" then
        TrailheadDB.version = 0
    end

    for v = TrailheadDB.version + 1, DB_VERSION do
        local migrate = self.migrations[v]
        if migrate then migrate(TrailheadDB) end
    end

    TrailheadDB.version = DB_VERSION
end

--- Access the live database table.
function DB:Get()
    return TrailheadDB
end
