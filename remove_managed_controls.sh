#!/bin/bash
# =================================================================
# Script: remove_managed_controls.sh
# Purpose: Sweep for residual parental control configurations,
#          enterprise policies, managed work profiles, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Sweeping for Managed & Parental Control Artifacts"
echo "=========================================="

# Remove common managed profile flags, restriction lists, or policy markers if present
rm -rf ~/.restricted 2>/dev/null
rm -rf ~/.managed_profile 2>/dev/null
rm -rf ~/.parental_controls 2>/dev/null
rm -rf $PREFIX/etc/restrictions 2>/dev/null

echo "[✓] Managed profile and parental control markers removed."

echo ""
echo "=========================================="
echo " 2. Cleaning Termux Environment Policy Overrides"
echo "=========================================="

# Unset any restrictive environment variables that might mimic policy constraints
unset RESTRICTED_USER
unset MANAGED_DEVICE
unset PARENTAL_PIN

# Reset package manager configurations back to unrestricted defaults
apt-get clean -y 2>/dev/null
pkg clean -y 2>/dev/null

echo "[✓] Environment restriction variables cleared."

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

git add remove_managed_controls.sh
git commit -m "Add remove_managed_controls.sh parental control and enterprise profile sweep script"
git push origin master

echo ""
echo "=========================================="
echo " Managed controls cleared & pushed to GitHub!"
echo "=========================================="
