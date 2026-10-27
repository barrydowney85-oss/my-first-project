#!/bin/bash
# =================================================================
# Script: cleanup_workspace_and_routes.sh
# Purpose: Remove guest workspace directories, clear HTTP/HTTPS
#          proxies, flush VPN/eSIM static routes, and push to GitHub.
# =================================================================

echo "=========================================="
echo " 1. Cleaning Guest Workspaces & Temp Files"
echo "=========================================="

# Remove guest/temp workspaces if present
rm -rf ~/guest 2>/dev/null
rm -rf ~/guest_workspace 2>/dev/null
rm -rf ~/tmp_workspace 2>/dev/null
rm -rf $PREFIX/tmp/* 2>/dev/null

echo "[✓] Guest workspace directories removed."

echo ""
echo "=========================================="
echo " 2. Clearing Proxy & Redirect Variables"
echo "=========================================="

# Unset proxy/redirect environment variables across current session
unset http_proxy https_proxy ftp_proxy all_proxy
unset HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY
unset NO_PROXY no_proxy

# Remove proxy configurations from Git global config if set
git config --global --unset http.proxy 2>/dev/null
git config --global --unset https.proxy 2>/dev/null

echo "[✓] All HTTP/HTTPS proxy overrides removed."

echo ""
echo "=========================================="
echo " 3. Flushing VPN, eSIM & Managed Routes"
echo "=========================================="

# Reset DNS to direct public resolvers (bypassing managed network/VPN DNS loops)
cat << 'DNS' > $PREFIX/etc/resolv.conf
nameserver 1.1.1.1
nameserver 8.8.8.8
DNS

# Flush IP neighbor/routing cache if iproute2 is available
if command -v ip &> /dev/null; then
    ip neigh flush all 2>/dev/null
    ip route flush cache 2>/dev/null
fi

echo "[✓] Local routing caches and DNS resolvers reset."

echo ""
echo "=========================================="
echo " 4. Verifying Clean Network Route to GitHub"
echo "=========================================="

if curl -s -I --connect-timeout 5 https://github.com > /dev/null; then
    echo "[✓] Network route healthy and directly connected to GitHub!"
else
    echo "[!] Warning: Connection failed. Verify Wi-Fi or Cellular toggle."
fi

echo ""
echo "=========================================="
echo " 5. Synchronizing Script to GitHub"
echo "=========================================="

cd ~/my-first-project || exit

git add cleanup_workspace_and_routes.sh
git commit -m "Add cleanup_workspace_and_routes.sh workspace & proxy reset script"
git push origin master

echo ""
echo "=========================================="
echo " Cleanup complete & pushed to GitHub!"
echo "=========================================="
