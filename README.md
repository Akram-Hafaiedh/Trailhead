<div align="center">

# 🥾 Trailhead

**A beautiful profession companion for World of Warcraft — crafting *and* gathering.**

*Every journey starts somewhere. Start here.*

[![Version](https://img.shields.io/badge/version-0.1.0--alpha-blue?style=flat-square)](CHANGELOG.md)
[![WoW](https://img.shields.io/badge/WoW-Retail-orange?style=flat-square)](https://worldofwarcraft.blizzard.com)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)
[![Lua](https://img.shields.io/badge/Lua-5.1-purple?style=flat-square)](https://www.lua.org/manual/5.1/)

</div>

---

## ✨ What is Trailhead?

Trailhead walks you through **every profession** in World of Warcraft — whether you're hammering a sword or picking a flower. Two guides in one addon:

- 🛠️ **Crafting Guides** — Step-by-step leveling paths from skill 1 to cap, with live shopping lists.
- 🌿 **Gathering Routes** — Optimized farming routes with waypoint arrows, node density maps, and yield estimates.

It's designed to be:

- 🎯 **Accurate** — Verified paths, updated every major patch.
- 🪶 **Lightweight** — No bloat. The route overlay only runs when you ask it to.
- 🎨 **Beautiful** — A UI that feels native to the game, not bolted on.
- 🧠 **Smart** — Tracks knowledge points, suggests specializations, learns your farming loop.

---

## 🚀 Features

### Current (v0.1.0-alpha)
- [x] Addon skeleton & event system
- [x] Slash command `/th` to toggle the main window
- [x] Basic UI frame with custom theme

### Coming Soon
- [ ] **Crafting:** step-by-step leveling guides for all 8 crafting professions
- [ ] Live shopping list with material counts
- [ ] Knowledge Point tracker
- [ ] Specialization tree advisor
- [ ] Auction House price integration (optional)
- [ ] Localization support (enUS, deDE, frFR, esES, ruRU, zhCN)

See [ROADMAP.md](ROADMAP.md) for the full plan.

---

## 📦 Installation

### CurseForge / WoWUp / Wago (Recommended)
1. Install the [CurseForge app](https://www.curseforge.com/download/app), 
   [WoWUp](https://wowup.io/), or the [Wago app](https://addons.wago.io/).
2. Search for **Trailhead** and click **Install**.
3. Restart the game or type `/reload`.

The app handles updates automatically — you'll never manually extract a zip again.

### Manual (from GitHub Releases)
1. Go to the [Releases page](https://github.com/Akram-Hafaiedh/Trailhead/releases).
2. Download the latest `Trailhead-x.y.z.zip`. **Do not download the GitHub
   "Source code" zip** — it has the wrong folder structure.
3. Extract the zip. You should end up with a folder called `Trailhead`:

Trailhead/
├── Trailhead.toc
├── src/
├── data/
└── locales/

4. Move that **`Trailhead` folder** into:
- **Windows:** `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\`
- **macOS:** `/Applications/World of Warcraft/_retail_/Interface/AddOns/`
5. The final path must look like:

Interface/AddOns/Trailhead/Trailhead.toc

If you see `Trailhead/Trailhead-x.y.z/Trailhead.toc`, you extracted one level too deep — pull the inner folder up.
6. Restart the game or type `/reload`.

### Verifying It Worked
- The AddOns list on the character-select screen should show **Trailhead**.
- In-game, type `/th` — the main window should appear.
- If the addon shows as "out of date," that's cosmetic — check **Load out of date AddOns** on the character screen, or wait for a version bump.

### Troubleshooting
- **Nothing happens when I type `/th`:** Check `/console scriptErrors 1` and look for a red Lua error. Report it on the [issue tracker](https://github.com/Akram-Hafaiedh/Trailhead/issues).
- **"Missing or corrupt .toc file":** You extracted the zip incorrectly — see step 5.
- **Wrong profession data:** Open an issue with your WoW build number and the profession affected.

---

## 🎮 Usage

| Command | Description |
|---------|-------------|
| `/th` | Toggle the main Trailhead window |
| `/th craft <profession>` | Load a crafting guide (e.g., `/th craft tailoring`) |
| `/th options` | Open the options panel |
| `/th reset` | Reset guide progress |
| `/th help` | Show available commands |

*`/trail` works as an alias for `/th` if you prefer typing it out.*

---

## 🛠️ Development

Trailhead is open source and contributions are welcome.

```bash
# Clone
git clone https://github.com/Akram-Hafaiedh/Trailhead.git

# Symlink into your WoW AddOns folder (Windows)
mklink /D "C:\Path\To\WoW\_retail_\Interface\AddOns\Trailhead" "C:\Path\To\Trailhead"

# Or on macOS/Linux
ln -s ~/projects/Trailhead ~/WoW/_retail_/Interface/AddOns/Trailhead