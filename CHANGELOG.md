# Changelog

All notable changes to Trailhead will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project scaffold: folder structure, `.toc`, license, docs.
- Core event dispatcher (`src/core/Events.lua`).
- Saved variables container (`src/core/Database.lua`).
- Slash command handler with `/th` toggle.
- Gathering route data schema and `RouteOverlay` feature stub.
- `data/crafting/`, `data/gathering/`, and `data/routes/` subfolders.

### Changed
- *(nothing yet)*

### Fixed
- *(nothing yet)*

---

## [0.1.0-alpha] — YYYY-MM-DD

### Added
- 🎉 First public alpha.
- Main window frame with custom theme colors.
- Basic addon lifecycle (load, enable, disable).
- Slash command `/th` toggles the main window.