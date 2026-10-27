#!/bin/bash
# =================================================================
# Script: purge_on_device_configs.sh
# Purpose: Purge local device configuration files, preference backups,
#          device overrides, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Purging On-Device Configurations & Settings"
echo "=========================================="

# Remove common local configuration and preference storage directories if present
rm -rf ~/.config/settings 2>/dev/null
rm -rf ~/.local/share/settings 2>/dev/null
rm -rf ~/.cache/settings 2>/dev/null
rm -rf $PREFIX/etc/conf.d 2>/dev/null

# Remove residual device configuration properties, property lists, and XML settings backups
find ~ -type f \( -name "*.cfg" -o -name "*.conf" -o -name "*.properties" -o -name "*settings*.xml" \) -not -path "*/.git/*" -exec rm -f {} + 2>/dev/null

echo "[✓] On-device configurations and preference files purged."

echo ""
echo "=========================================="
echo " 2. Cleaning System Caches & Temp Archives"
echo "=========================================="

pkg clean -y 2>/dev/null
apt-get clean -y 2>/dev/null
rm -rf ~/.cache/* 2>/dev/null
rm -rf $PREFIX/tmp/* 2>/dev/null

echo "[✓] System caches and temp archives cleared."

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

git add purge_on_device_configs.sh
git commit -m "Add purge_on_device_configs.sh on-device configuration cleanup script"
git push origin master

echo ""
echo "=========================================="
echo " On-device configurations cleared & pushed to GitHub!"
echo "=========================================="
