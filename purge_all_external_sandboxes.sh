#!/bin/bash
# =================================================================
# Script: purge_all_external_sandboxes.sh
# Purpose: Terminate all external sandboxes, cloud automation deamons,
#          local test containers, CLI tokens, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Terminating Background Automation Daemons"
echo "=========================================="

# Kill active background node, python, docker, or sandbox runners
pkill -f "node" 2>/dev/null
pkill -f "python3" 2>/dev/null
pkill -f "flask" 2>/dev/null
pkill -f "uvicorn" 2>/dev/null
pkill -f "ngrok" 2>/dev/null
pkill -f "localtunnel" 2>/dev/null

echo "[✓] Local automation daemons and tunnels stopped."

echo ""
echo "=========================================="
echo " 2. Purging Cloud CLI Configs & Local Sandboxes"
echo "=========================================="

# Remove cloud CLI config directories and credentials if present
rm -rf ~/.vercel 2>/dev/null
rm -rf ~/.heroku 2>/dev/null
rm -rf ~/.docker 2>/dev/null
rm -rf ~/.aws 2>/dev/null
rm -rf ~/.kube 2>/dev/null
rm -rf ~/sandbox 2>/dev/null
rm -rf ~/cloud_workspace 2>/dev/null

echo "[✓] External cloud CLIs, tokens, and sandbox folders purged."

echo ""
echo "=========================================="
echo " 3. Cleaning Package Caches & Temp Artifacts"
echo "=========================================="

apt-get clean -y 2>/dev/null
pkg clean -y 2>/dev/null
rm -rf ~/.cache/* 2>/dev/null
rm -rf $PREFIX/tmp/* 2>/dev/null

echo "[✓] System caches and temp archives cleared."

echo ""
echo "=========================================="
echo " 4. Verifying Git Identity & Repository State"
echo "=========================================="

git config --global user.name "Barry Downey"
git config --global user.email "barrydowney85@googlemail.com"

cd ~/my-first-project || exit

echo ""
echo "=========================================="
echo " 5. Synchronizing Final Cleanup to GitHub"
echo "=========================================="

git add purge_all_external_sandboxes.sh
git commit -m "Add purge_all_external_sandboxes.sh master cleanup script"
git push origin master

echo ""
echo "=========================================="
echo " All external sandboxes & clouds cleaned!"
echo "=========================================="
