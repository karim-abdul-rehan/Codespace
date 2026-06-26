#!/bin/bash
#!/bin/bash
CLR_RESET="\033[0m"
CLR_BOLD="\033[1m"
CLR_BLUE="\033[38;5;39m"
CLR_GREEN="\033[38;5;76m"
CLR_YELLOW="\033[38;5;220m"
CLR_RED="\033[38;5;196m"
CLR_CYAN="\033[38;5;51m"
CLR_GRAY="\033[38;5;244m"
# TUI UI Elements
PANEL_LINE="${CLR_GRAY}─────────────────────────────────────────────────────${CLR_RESET}"

# print help
if [ "$1" == "help" ] || [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${CLR_BLUE}${CLR_BOLD}┌───────────────────────────────────────────────────┐${CLR_RESET}"
    echo -e "${CLR_BLUE}${CLR_BOLD}│                IP & DOMAIN FINDER                 │${CLR_RESET}"
    echo -e "${CLR_BLUE}${CLR_BOLD}└───────────────────────────────────────────────────┘${CLR_RESET}"
    echo -e "Usage: $0 ${CLR_GREEN}<target>${CLR_RESET} ${CLR_CYAN}<type>${CLR_RESET}"
    echo ""
    echo -e "${CLR_BOLD}Available Types:${CLR_RESET}"
    echo -e "  ${CLR_CYAN}domain  - Web domains (e.g., google.com)"
    echo -e "  ${CLR_CYAN}ipv4${----}    - Standard IPv4 targets"
    echo -e "  ${CLR_CYAN}ipv6${----}    - IPv6 targets (will extract MAC if EUI-64)"
    echo ""
    echo -e "${CLR_BOLD}Examples:${CLR_RESET}"
    echo -e "  $0 ${CLR_GREEN}8.8.8.8${CLR_RESET} ${CLR_CYAN}ipv4${CLR_RESET}"
    echo -e "  $0 ${CLR_GREEN}google.com${CLR_RESET} ${CLR_CYAN}domain${CLR_RESET}"
    echo -e "  $0 ${CLR_GREEN}2409:40e6:256:b88a:021a:11ff:fe22:3344${CLR_RESET} ${CLR_CYAN}ipv6${CLR_RESET}"
    echo -e $PANEL_LINE
    echo ""
    exit 0
fi
echo -e "${CLR_BLUE}${CLR_BOLD}┌───────────────────────────────────────────────────┐${CLR_RESET}"
echo -e "${CLR_BLUE}${CLR_BOLD}│                IP & DOMAIN FINDER                 │${CLR_RESET}"
echo -e "${CLR_BLUE}${CLR_BOLD}└───────────────────────────────────────────────────┘${CLR_RESET}"


# 2. Check Target Type via Conditional Logic
if [ "$1" == "ipv6" ]; then
    echo -e "${CLR_GREEN}[+] Running IPv6 MAC Address Calculation..."
    sleep 2
    
    # Run the quiet tool extraction
    mac=$(ipv6calc --quiet --in ipv6addr --out mac $2 2>/dev/null)
    
    # Check if calculation actually succeeded or returned a suffix error
    if [ -n "$mac" ] && [[ "$mac" != *"Error"* ]]; then
        echo -e "${CLR_CYAN}Extracted MAC : "$mac
        echo -e -n "${CLR_CYAN}Vendor Lookup : "
        curl -s "https://api.macvendors.com/"$mac
        echo ""
        curl -s "https://api.maclookup.app/v2/macs/"$mac | jq
        echo ""
    else
        echo -e "${CLR_RED}[-] Setup Alert: This address does not contain an EUI-64 hardware suffix (Privacy Extensions Active)."
    fi

fi
if [ "$1" == "domain" ]; then
    target=$(ping -c 1 google.com | head -n 1 | awk -F'[()]' '{print $2}')
else
    target=$2
fi
echo -e $PANEL_LINE
echo -e "${CLR_GREEN}[+] Running Standard Reconnaissance Suite..."
sleep 2
    # Bulk Endpoint Geolocation Query
echo -e "${CLR_CYAN}"
curl -s -X POST http://ip-api.com/batch   -H "Content-Type: application/json"   -d '["'$target'"]' | jq
    
echo -e $PANEL_LINE
echo  -e "${CLR_GREEN}[+] Fetching WHOIS Registry Records..."
sleep 3
echo -e "${CLR_CYAN}"
whois $2
echo -e $PANEL_LINE
    
    # Location Extraction and Map Trigger Setup
location=$(curl -s -X POST http://ip-api.com/batch -H "Content-Type: application/json" -d '["'$target'"]' | jq -r '.[] | "\(.lat),\(.lon)"')
echo -e $PANEL_LINE
echo -e "${CLR_GREEN} [+] calculating location... "
sleep 2
echo -e "${CLR_CYAN}"
echo "location:" "https://www.google.com/maps/search/?api=1&query="$location
echo -e $PANEL_LINE
termux-open-url "https://www.google.com/maps/search/?api=1&query="$location



