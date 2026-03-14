# Houdini GitHub Setup Instructions

These instructions walk you from local files to a clean private GitHub repo.

---
## 1. Create the GitHub repository

1. Sign in to GitHub.
2. Click **New repository**.
3. Repository name: `houdini-ios`
4. Description: `Local-first iPhone writing app for structured creative organization.`
5. Set visibility to **Private**.
6. Do **not** initialize with a README, .gitignore, or license if you are uploading this setup pack and your source kit manually.
7. Click **Create repository**.

---
## 2. Prepare your local project folder

Recommended local folder structure:

```text
houdini-ios/
  App/
  Models/
  Persistence/
  Services/
  ViewModels/
  Views/
  Commands/
  AI/
  Maps/
  Export/
  Docs/
  README.md
  .gitignore
```

If you already downloaded the Phase 2 source kit:
1. Unzip it.
2. Rename the root folder to `houdini-ios` if you want consistency.
3. Copy the files from this GitHub setup pack into that same root folder.

---
## 3. Open Terminal and initialize git

Change into your project folder:

```bash
cd /path/to/houdini-ios
```

Initialize git:

```bash
git init
```

Check status:

```bash
git status
```

---
## 4. Create the first commit

Add all files:

```bash
git add .
```

Create the first commit:

```bash
git commit -m "Initial Houdini Phase 2 foundation"
```

---
## 5. Connect your local repo to GitHub

Copy the HTTPS URL from your GitHub repo page, then run:

```bash
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/houdini-ios.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username.

---
## 6. Create a development branch

Keep `main` stable and do active work in `dev`.

```bash
git checkout -b dev
git push -u origin dev
```

Recommended usage:
- `main` = stable code
- `dev` = daily build work
- optional future feature branches:
  - `feature/map-engine`
  - `feature/voice`
  - `feature/export-backup`
  - `feature/monetization`

---
## 7. Suggested commit rhythm

Commit after each meaningful milestone.

Good examples:
- `Set up SwiftData models`
- `Add project list and detail views`
- `Implement OTC and Creative mode switching`
- `Add chapter detail and content editor`
- `Add large text preview flow`
- `Build character map MVP`

---
## 8. Suggested GitHub milestone sequence

Recommended milestone order:

1. Foundation
2. Editing + writing
3. Large text parsing
4. Map engine MVP
5. Backup and export
6. Voice integration
7. Monetization
8. TestFlight build

---
## 9. Recommended branch workflow

Simple workflow for solo development:

1. checkout `dev`
2. make changes
3. commit locally
4. push to `dev`
5. when stable, merge `dev` into `main`

Example:

```bash
git checkout dev
git add .
git commit -m "Add character detail editing"
git push
```

When stable:

```bash
git checkout main
git merge dev
git push
```

---
## 10. Recommended backup habit

Even with GitHub:
- keep a local copy
- keep GitHub private repo updated
- occasionally zip the project folder separately

GitHub is excellent version control, but it should not be your only backup.

---
## 11. What to upload first

Upload:
- Phase 2 source kit files
- this setup pack
- starter documentation

Do not upload:
- DerivedData
- build folders
- secrets
- provisioning files not meant for source control

---
## 12. First practical workflow in Xcode

1. Create the Xcode project
2. Add the Houdini source folders
3. Confirm the app builds
4. Commit the working state
5. Push to GitHub
6. Continue development from `dev`

---
## 13. First merge target

Your first real success milestone should be:

**Houdini compiles and runs with:**
- project list
- project detail
- command parser
- OTC / Creative mode switching
- character and chapter storage
- basic map generation

Once that works, merge `dev` into `main`.
