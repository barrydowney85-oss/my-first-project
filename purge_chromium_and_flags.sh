#!/bin/bash
# =================================================================
# Script: purge_chromium_and_flags.sh
# Purpose: Uninstall Chromium/browsers, purge configuration profiles,
#          local state flags, chrome:// caches, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Removing Chromium Package & Dependencies"
echo "=========================================="

# Remove chromium or related browser packages if present in Termux environments
pkg uninstall -y chromium 2>/dev/null
apt-get purge -y chromium 2>/dev/null
pkg clean -y 2>/dev/null
apt-get clean -y 2>/dev/null

echo "[✓] Chromium package purged."

echo ""
echo "=========================================="
echo " 2. Purging Browser Profiles, Flags & Local State"
echo "=========================================="

# Remove Chrome/Chromium config, flags, local state, and chrome:// caches
rm -rf ~/.config/chromium 2>/dev/null
rm -rf ~/.config/google-chrome 2>/dev/null
rm -rf ~/.cache/chromium 2>/dev/null
rm -rf ~/.cache/google-chrome 2>/dev/null
rm -rf ~/.local/share/applications/chromium* 2>/dev/null

# Clean general user temp files
rm -rf $PREFIX/tmp/* 2>/dev/null

echo "[✓] Browser configuration flags and local state wiped."

echo ""
echo "=========================================="
echo " 3. Verifying Git Identity & Repository State"
echo "=========================================="

git config --global user.name "Barry Downey"
git config --global user.email "barrydowney85@googlemail.com"

cd ~/my-first-project || exit

echo ""
echo "=========================================="
echo " 4. Synchronizing Cleanup Script to GitHub"
echo "=========================================="

git add purge_chromium_and_flags.sh
git commit -m "Add purge_chromium_and_flags.sh browser and flag cleanup script"
git push origin master

echo ""
echo "=========================================="
echo " Chromium, flags & caches purged & pushed to GitHub!"
echo "=========================================="
