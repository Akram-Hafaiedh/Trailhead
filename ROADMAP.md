# 🗺️ Trailhead Roadmap

A living document. Check items off as they ship.

---

## 🏗️ Phase 1 — Foundation (v0.1.x)
> *Goal: A working addon skeleton with a toggleable window.*

- [ ] Create `.toc` and folder structure
- [ ] Core event dispatcher (`ADDON_LOADED`, `PLAYER_LOGIN`)
- [ ] Saved variables schema + versioning
- [ ] Slash command handler (`/th`, `/trail`)
- [ ] Main frame: movable, closable, ESC-closable
- [ ] Theming module: colors, fonts, spacing tokens
- [ ] Basic localization scaffold (enUS only)
- [ ] `.luacheckrc` + GitHub Action for linting
- [ ] First tagged release: `v0.1.0-alpha`

---

## 🛠️ Phase 2 — Crafting Guide Engine (v0.2.x)
> *Goal: Read a crafting guide and display the current step.*

- [ ] Guide data schema (`startSkill`, `endSkill`, `recipe`, `materials`, `notes`)
- [ ] `Tailoring.lua` guide data (proof of concept)
- [ ] Hook `C_TradeSkillUI` to read current skill level
- [ ] Detect active profession window
- [ ] Step list UI (scrollable rows)
- [ ] Highlight current step based on skill
- [ ] Auto-advance when skill threshold is met
- [ ] `/reload`-safe progress persistence
- [ ] Release: `v0.2.0-beta`

---

## 🌿 Phase 3 — Gathering Routes (v0.3.x)
> *Goal: Guide the player through optimized farming loops in the open world.*

- [ ] Route data schema (`zone`, `waypoints`, `nodeTypes`, `estimatedYield`)
- [ ] `Mining_Midnight.lua` route data (proof of concept)
- [ ] Route list UI (scrollable, grouped by zone)
- [ ] Waypoint storage & retrieval via `C_Map` / `C_Navigation`
- [ ] In-world arrow overlay pointing to next waypoint
- [ ] Auto-advance to next waypoint on arrival
- [ ] Node counter (nodes hit this session)
- [ ] Yield estimator (nodes/hr, gold/hr if AH data available)
- [ ] TomTom integration (soft dependency)
- [ ] Release: `v0.3.0-beta`

---

## 🛒 Phase 4 — Shopping List (v0.4.x)
> *Goal: Never alt-tab to a spreadsheet again.*

- [ ] Aggregate materials across all remaining crafting steps
- [ ] Subtract materials already in bags/bank
- [ ] Live-updating shopping list panel
- [ ] Click material → link in chat
- [ ] Optional: Auction House price estimates
- [ ] Export list to clipboard

---

## 🧠 Phase 5 — Knowledge & Specialization (v0.5.x)
> *Goal: Guide the player beyond just skill points.*

- [ ] Knowledge Point source tracker
- [ ] Weekly KP checklist (quests, treasures, drops)
- [ ] Specialization tree recommendation engine
- [ ] Per-profession "build" presets (e.g., "Gold build", "Raid build")
- [ ] Import/export spec builds via string

---

## 🎨 Phase 6 — Polish & Scale (v1.0.0)
> *Goal: Ship-quality release.*

- [ ] Localization: deDE, frFR, esES, ruRU, zhCN, koKR, ptBR
- [ ] Options panel (native Settings API)
- [ ] Skinnable UI (ElvUI / Masque support)
- [ ] Full data coverage: every profession, every expansion
- [ ] Performance audit (zero taint, <1ms frame time)
- [ ] CurseForge + Wago release
- [ ] Comprehensive user docs & video guide
- [ ] **v1.0.0 launch** 🚀

---

## 🔮 Future Ideas
- Companion web app that syncs guide + route progress
- In-game "guided mode" that auto-opens the profession window
- Route sharing via import strings
- Bag addon integration for farming (auto-sell greys, restock)
- Mobile-friendly guide viewer (out of game)