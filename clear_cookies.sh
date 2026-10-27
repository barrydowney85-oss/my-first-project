#!/bin/bash
# =========================================================
# Script: clear_cookies.sh
# Purpose: Clean local caches, session temp files, and push
#          updates to GitHub.
# =========================================================

echo "=========================================="
echo " Starting Cleanup in Termux..."
echo "=========================================="

# 1. Clear GitHub CLI cache & auth sessions
if command -v gh &> /dev/null; then
    echo "[+] Clearing GitHub CLI cache..."
    gh config clear-cache 2>/dev/null
fi

# 2. Clear Termux package cache & temp files
echo "[+] Clearing package cache and temporary directories..."
apt-get clean -y 2>/dev/null
pkg clean -y 2>/dev/null
rm -rf ~/.cache/* 2>/dev/null
rm -rf $PREFIX/tmp/* 2>/dev/null

# 3. Unset active environment session keys
unset HTTP_COOKIE
unset HTTPS_COOKIE

echo "[+] Cleanup complete!"
echo ""

# 4. Git Add, Commit, and Push to GitHub
cd ~/my-first-project || exit

echo "=========================================="
echo " Synchronizing with GitHub..."
echo "=========================================="

git add clear_cookies.sh
git commit -m "Add clear_cookies.sh session cleanup script"
git push origin master

echo ""
echo "=========================================="
echo " Successfully pushed to GitHub!"
echo "=========================================="
