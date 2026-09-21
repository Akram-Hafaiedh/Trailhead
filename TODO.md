# ✅ Trailhead — Launch TODO

The checklist to go from "fresh clone" to "shipped v0.1.0-alpha".
Check items off as you complete them.

---

## 🪪 Identity

- [x] Replace `YourName` with your name/handle in:
  - [x] `Trailhead.toc` → `## Author:`
  - [x] `LICENSE` → copyright line
  - [x] `README.md` → footer + license section
- [x] Replace `yourname` with your GitHub handle in:
  - [x] `README.md` (badges, clone URL, issue links)
  - [x] `Trailhead.toc` → `## X-Website:`
  - [x] `.github/ISSUE_TEMPLATE/config.yml`
  - [x] `.github/FUNDING.yml` (optional)

## 🌐 Distribution

- [ ] Create the GitHub repo and push the skeleton
- [ ] Create the CurseForge project
  - [ ] Copy the **Project ID** → `Trailhead.toc` → `## X-Curse-Project-ID:`
- [ ] Create the Wago project (optional)
  - [ ] Copy the **Project ID** → `Trailhead.toc` → `## X-Wago-ID:`
- [ ] Add GitHub repo secrets:
  - [ ] `CF_API_KEY` (from https://curseforge.com/account/api-tokens)
  - [ ] `WAGO_API_TOKEN` (from https://addons.wago.io/account/apikeys)
- [ ] Enable GitHub Discussions (for the issue-template config link)

## 🎨 Assets

- [ ] Design a logo (`assets/logo.png`, 256×256 recommended)
  - [ ] A simple boot print, trail marker, or mountain glyph works
- [ ] Take a screenshot of the main frame for the README
  - [ ] Place in `assets/screenshots/main.png`
- [ ] Add the screenshot to README under "What is Trailhead?"

## 📝 Documentation

- [ ] Fill in `CHANGELOG.md` → `[0.1.0-alpha]` → `YYYY-MM-DD` with the release date
- [ ] Proofread `README.md` end-to-end
- [ ] Review `ROADMAP.md` and confirm Phase 1 items are accurate

- [x] Convert issue templates to YAML issue forms
  - [x] `bug_report.yml`
  - [x] `feature_request.yml`
  - [x] `config.yml`
  - [ ] Delete any leftover `.md` templates if they exist
  - [ ] Verify `bug` and `enhancement` labels exist in the repo (Settings → Labels)
  - [x] Confirm PR template format — Markdown only (GitHub has no YAML PR forms)
- [ ] Consider splitting into `.github/PULL_REQUEST_TEMPLATE/` folder later if
      code vs. data PRs need different checklists (not needed for v0.x)

## 🌍 Localization

- [x] Scaffold `enUS.lua` as source of truth (always loads)
- [x] Scaffold `frFR.lua` with fallback pattern (loads only on frFR clients)
- [ ] Recruit translators for: deDE, esES, esMX, ruRU, zhCN, zhTW, koKR, ptBR, itIT
- [ ] Add each locale file to `Trailhead.toc` in order (enUS first)
- [ ] Verify fallback works with `/console cvar_locale`

## 💤 Deferred / Future
- Gathering routes + waypoint navigation (removed in v0.3.x, may return)

## 🚦 Pre-Release

- [ ] `luacheck src/ data/ locales/` passes with zero warnings
- [ ] Tested in-game: `/reload`, `/th`, close window, reopen — no errors
- [ ] Tested with only Trailhead enabled (isolate from other addons)
- [ ] Tested with TomTom enabled (verify no conflict)
- [ ] Update `## Interface:` in `Trailhead.toc` to current live build
- [ ] Bump `## Version:` in `Trailhead.toc` to `0.1.0-alpha`
- [ ] Tag: `git tag v0.1.0-alpha && git push --tags`
- [ ] Watch the GitHub Actions release job → confirm CurseForge upload

## 🔮 Post-Release

- [ ] Post announcement (Reddit r/wow, Discord communities, etc.)
- [ ] Monitor the issue tracker for the first 48 hours
- [ ] Add project to your profile README / addon portfolio