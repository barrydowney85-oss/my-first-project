#!/bin/bash
# =================================================================
# Script: restore_original_apps.sh
# Purpose: Clean extra packages, reinstall core Termux utilities,
#          restore pristine application state, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Purging Non-Standard Packages & Caches"
echo "=========================================="

# Clean package manager cache archives
apt-get clean -y 2>/dev/null
pkg clean -y 2>/dev/null

# Remove residual temp files and caches
rm -rf ~/.cache/* 2>/dev/null
rm -rf $PREFIX/tmp/* 2>/dev/null

echo "[✓] Temporary caches and archives cleared."

echo ""
echo "=========================================="
echo " 2. Updating Package Database & Repositories"
echo "=========================================="

# Refresh package lists from official mirrors
pkg update -y || apt-get update -y

echo ""
echo "=========================================="
echo " 3. Restoring Core Default Termux Packages"
echo "=========================================="

# Reinstall core base applications and utilities to factory state
pkg install --reinstall -y \
    termux-tools \
    coreutils \
    bash \
    git \
    curl \
    wget \
    openssh \
    dnsutils \
    procps

echo "[✓] Core Termux applications restored to default."

echo ""
echo "=========================================="
echo " 4. Verifying Git Identity & Repository State"
echo "=========================================="

git config --global user.name "Barry Downey"
git config --global user.email "barrydowney85@googlemail.com"

cd ~/my-first-project || exit

echo ""
echo "=========================================="
echo " 5. Synchronizing Script to GitHub"
echo "=========================================="

git add restore_original_apps.sh
git commit -m "Add restore_original_apps.sh package reset script"
git push origin master

echo ""
echo "=========================================="
echo " System apps restored & pushed to GitHub!"
echo "=========================================="
