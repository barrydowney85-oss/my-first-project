#!/bin/bash
# =================================================================
# Script: remove_developer_and_offloaded_apps.sh
# Purpose: Uninstall developer utilities, purge offloaded app packages,
#          clean application remnants, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Removing Developer & Non-Standard Tools"
echo "=========================================="

# Remove common developer/debugging packages if present in Termux
pkg uninstall -y strace gdb valgrind clang make cmake 2>/dev/null
apt-get purge -y strace gdb valgrind clang make cmake 2>/dev/null

echo "[✓] Developer packages uninstalled."

echo ""
echo "=========================================="
echo " 2. Purging Offloaded Apps & Application Remnants"
echo "=========================================="

# Remove cached APKs, offloaded application archives, and user share directories
rm -rf ~/.local/share/applications/* 2>/dev/null
rm -rf ~/.cache/apk/* 2>/dev/null
rm -rf $PREFIX/tmp/*.apk 2>/dev/null

# Clean package manager caches
pkg clean -y 2>/dev/null
apt-get clean -y 2>/dev/null

echo "[✓] Offloaded app packages and installation archives purged."

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

git add remove_developer_and_offloaded_apps.sh
git commit -m "Add remove_developer_and_offloaded_apps.sh developer and offloaded app cleanup script"
git push origin master

echo ""
echo "=========================================="
echo " Developer & offloaded apps cleared & pushed to GitHub!"
echo "=========================================="
