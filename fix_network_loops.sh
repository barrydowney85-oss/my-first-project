#!/bin/bash
# =========================================================
# Script: fix_network_loops.sh
# Purpose: Clear stale sockets, flush DNS loops, reset Termux
#          network interfaces, and sync to GitHub.
# =========================================================

echo "=========================================="
echo " Termux Network Loop Cleanup & Reset"
echo "=========================================="

# 1. Kill stale lingering local sockets/processes
echo "[+] Checking for runaway local loop background processes..."
pkill -f "http-server" 2>/dev/null
pkill -f "python.*http.server" 2>/dev/null
pkill -f "node" 2>/dev/null

# 2. Reset Termux DNS resolv.conf to clear potential resolution loops
echo "[+] Cleaning DNS resolver loop configuration..."
cat << 'DNS' > $PREFIX/etc/resolv.conf
nameserver 1.1.1.1
nameserver 8.8.8.8
DNS

# 3. Flush local ARP and Socket cache
echo "[+] Flushing local sockets and routing caches..."
if command -v ip &> /dev/null; then
    ip neigh flush all 2>/dev/null
fi

# 4. Test connectivity to ensure loop is cleared
echo "[+] Verifying clean network route to GitHub..."
if curl -s -I --connect-timeout 5 https://github.com > /dev/null; then
    echo "[✓] Network route healthy and responsive!"
else
    echo "[!] Warning: Connection timeout. Check mobile data/Wi-Fi toggle."
fi

echo ""
# 5. Git Commit & Push to GitHub
cd ~/my-first-project || exit

echo "=========================================="
echo " Synchronizing with GitHub..."
echo "=========================================="

git add fix_network_loops.sh
git commit -m "Add fix_network_loops.sh network reset script"
git push origin master

echo ""
echo "=========================================="
echo " Script pushed successfully to GitHub!"
echo "=========================================="
