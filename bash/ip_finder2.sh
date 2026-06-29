#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
# IP & DOMAIN FINDER - Enhanced TUI Version
# A professional network reconnaissance tool with beautiful terminal UI
# ═══════════════════════════════════════════════════════════════════════════

# Color Definitions
CLR_RESET="\033[0m"
CLR_BOLD="\033[1m"
CLR_DIM="\033[2m"
CLR_BLUE="\033[38;5;39m"
CLR_GREEN="\033[38;5;76m"
CLR_YELLOW="\033[38;5;220m"
CLR_RED="\033[38;5;196m"
CLR_CYAN="\033[38;5;51m"
CLR_GRAY="\033[38;5;244m"
CLR_PURPLE="\033[38;5;135m"
CLR_WHITE="\033[38;5;255m"

# TUI Elements
PANEL_LINE="${CLR_GRAY}─────────────────────────────────────────────────────${CLR_RESET}"
DOUBLE_LINE="${CLR_BLUE}═════════════════════════════════════════════════════${CLR_RESET}"
BOX_TL="${CLR_BLUE}╔"
BOX_TR="${CLR_BLUE}╗"
BOX_BL="${CLR_BLUE}╚"
BOX_BR="${CLR_BLUE}╝"
BOX_H="${CLR_BLUE}═"
BOX_V="${CLR_BLUE}║"

# ═══════════════════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

# Print centered title banner
print_banner() {
    local title=$1
    echo -e "${CLR_BLUE}${CLR_BOLD}┌$(printf '─%.0s' {1..51})┐${CLR_RESET}"
    printf "${CLR_BLUE}${CLR_BOLD}│ %-49s │${CLR_RESET}\n" "$title"
    echo -e "${CLR_BLUE}${CLR_BOLD}└$(printf '─%.0s' {1..51})┘${CLR_RESET}"
}

# Print section header
print_section() {
    echo ""
    echo -e "${CLR_BOLD}${CLR_CYAN}▶ $1${CLR_RESET}"
    echo -e "${CLR_GRAY}$(printf '─%.0s' {1..51})${CLR_RESET}"
}

# Print field in key-value format
print_field() {
    local key=$1
    local value=$2
    printf "  ${CLR_CYAN}%-20s${CLR_RESET} : ${CLR_GREEN}%s${CLR_RESET}\n" "$key" "$value"
}

# Print success message
print_success() {
    echo -e "${CLR_GREEN}[✓]${CLR_RESET} ${CLR_BOLD}$1${CLR_RESET}"
}

# Print error message
print_error() {
    echo -e "${CLR_RED}[✗]${CLR_RESET} ${CLR_BOLD}$1${CLR_RESET}"
}

# Print info message
print_info() {
    echo -e "${CLR_CYAN}[ℹ]${CLR_RESET} ${CLR_BOLD}$1${CLR_RESET}"
}

# Print warning message
print_warning() {
    echo -e "${CLR_YELLOW}[⚠]${CLR_RESET} ${CLR_BOLD}$1${CLR_RESET}"
}

# Loading animation
show_loading() {
    local text=$1
    local delay=${2:-0.1}
    local chars='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    
    echo -n -e "${CLR_CYAN}${text}${CLR_RESET} "
    for i in $(seq 0 9); do
        echo -n -e "\b${chars:$i:1}"
        sleep $delay
    done
    echo -e "\b${CLR_GREEN}✓${CLR_RESET}"
}

# Separator line
print_separator() {
    echo -e "${CLR_GRAY}$(printf '─%.0s' {1..53})${CLR_RESET}"
}

# Display help
show_help() {
    clear
    print_banner "IP & DOMAIN FINDER v2.0"
    echo ""
    echo -e "${CLR_BOLD}Usage:${CLR_RESET}"
    echo -e "  ${CLR_GREEN}\$0${CLR_RESET} ${CLR_CYAN}<target>${CLR_RESET} ${CLR_PURPLE}<type>${CLR_RESET}"
    echo ""
    echo -e "${CLR_BOLD}Available Types:${CLR_RESET}"
    echo -e "  ${CLR_PURPLE}ipv4${CLR_RESET}   - Standard IPv4 lookup (e.g., 8.8.8.8)"
    echo -e "  ${CLR_PURPLE}ipv6${CLR_RESET}   - IPv6 lookup with MAC extraction (EUI-64)"
    echo -e "  ${CLR_PURPLE}domain${CLR_RESET} - Domain lookup (e.g., google.com)"
    echo ""
    echo -e "${CLR_BOLD}Examples:${CLR_RESET}"
    echo -e "  \$ ${CLR_GREEN}./ip_finder.sh${CLR_RESET} ${CLR_CYAN}8.8.8.8${CLR_RESET} ${CLR_PURPLE}ipv4${CLR_RESET}"
    echo -e "  \$ ${CLR_GREEN}./ip_finder.sh${CLR_RESET} ${CLR_CYAN}google.com${CLR_RESET} ${CLR_PURPLE}domain${CLR_RESET}"
    echo -e "  \$ ${CLR_GREEN}./ip_finder.sh${CLR_RESET} ${CLR_CYAN}2409:40e6:256:b88a:021a:11ff:fe22:3344${CLR_RESET} ${CLR_PURPLE}ipv6${CLR_RESET}"
    echo ""
    echo -e $PANEL_LINE
    echo ""
    exit 0
}

# ═══════════════════════════════════════════════════════════════════════════
# MAIN FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

# IPv6 Handler
handle_ipv6() {
    local target=$2
    
    clear
    print_banner "IPv6 Analysis & MAC Extraction"
    print_info "Target: ${CLR_GREEN}$target${CLR_RESET}"
    echo ""
    
    print_section "MAC Address Extraction (EUI-64)"
    show_loading "Calculating MAC from IPv6..."
    
    mac=$(ipv6calc --quiet --in ipv6addr --out mac "$target" 2>/dev/null)
    
    if [ -n "$mac" ] && [[ "$mac" != *"Error"* ]]; then
        print_success "MAC extracted successfully"
        print_field "MAC Address" "$mac"
        echo ""
        
        print_section "Vendor Lookup"
        show_loading "Querying vendor database..."
        
        vendor=$(curl -s "https://api.macvendors.com/$mac" 2>/dev/null)
        if [ -n "$vendor" ]; then
            print_field "Vendor" "$vendor"
        fi
        
        print_section "Extended MAC Information"
        curl -s "https://api.maclookup.app/v2/macs/$mac" 2>/dev/null | jq . 2>/dev/null || print_warning "Extended info unavailable"
    else
        print_error "Privacy Extensions active - MAC extraction unavailable"
        print_info "This IPv6 address doesn't contain a static EUI-64 hardware suffix"
    fi
    
    echo ""
}

# IPv4/Domain Handler
handle_target() {
    local type=$1
    local target=$2
    
    # Resolve domain to IP if necessary
    if [ "$type" == "domain" ]; then
        print_info "Resolving domain to IP address..."
        target=$(ping -c 1 "$target" 2>/dev/null | head -n 1 | awk -F'[()]' '{print $2}')
        if [ -z "$target" ]; then
            print_error "Failed to resolve domain"
            return 1
        fi
    fi
    
    clear
    print_banner "Geolocation & Network Reconnaissance"
    print_info "Target: ${CLR_GREEN}$target${CLR_RESET}"
    echo ""
    
    # Geolocation Data
    print_section "Geolocation Information"
    show_loading "Fetching geolocation data..."
    
    geo_data=$(curl -s -X POST "http://ip-api.com/batch" \
        -H "Content-Type: application/json" \
        -d "[\"$target\"]" 2>/dev/null | jq '.[0]' 2>/dev/null)
    
    if [ -n "$geo_data" ]; then
        status=$(echo "$geo_data" | jq -r '.status' 2>/dev/null)
        if [ "$status" == "success" ]; then
            print_success "Geolocation data retrieved"
            echo ""
            
            print_field "Country" "$(echo "$geo_data" | jq -r '.country // "N/A"' 2>/dev/null)"
            print_field "Region" "$(echo "$geo_data" | jq -r '.regionName // "N/A"' 2>/dev/null)"
            print_field "City" "$(echo "$geo_data" | jq -r '.city // "N/A"' 2>/dev/null)"
            print_field "Organization" "$(echo "$geo_data" | jq -r '.org // "N/A"' 2>/dev/null)"
            print_field "ISP" "$(echo "$geo_data" | jq -r '.isp // "N/A"' 2>/dev/null)"
            print_field "Timezone" "$(echo "$geo_data" | jq -r '.timezone // "N/A"' 2>/dev/null)"
            print_field "Latitude" "$(echo "$geo_data" | jq -r '.lat // "N/A"' 2>/dev/null)"
            print_field "Longitude" "$(echo "$geo_data" | jq -r '.lon // "N/A"' 2>/dev/null)"
        else
            print_error "Geolocation lookup failed"
        fi
    fi
    
    echo ""
    print_separator
    
    # WHOIS Information
    print_section "WHOIS Registry Records"
    show_loading "Fetching WHOIS data..."
    echo ""
    
    whois_output=$(whois "$target" 2>/dev/null)
    if [ -n "$whois_output" ]; then
        echo -e "${CLR_CYAN}$whois_output${CLR_RESET}" | head -30
        echo -e "${CLR_DIM}[... truncated for brevity ...]${CLR_RESET}"
    else
        print_warning "WHOIS lookup unavailable or incomplete"
    fi
    
    echo ""
    print_separator
    
    # Map Information
    print_section "Location Mapping"
    
    lat=$(echo "$geo_data" | jq -r '.lat // "0"' 2>/dev/null)
    lon=$(echo "$geo_data" | jq -r '.lon // "0"' 2>/dev/null)
    location="$lat,$lon"
    
    if [ "$lat" != "0" ] && [ "$lon" != "0" ]; then
        map_url="https://www.google.com/maps/search/?api=1&query=$location"
        print_field "Map URL" "$map_url"
        echo ""
        print_info "Opening location in Google Maps..."
        termux-open-url "$map_url" 2>/dev/null || echo -e "  ${CLR_GRAY}(termux-open-url not available)${CLR_RESET}"
    fi
    
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════
# MAIN ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════

# Check for help or missing arguments
if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z "$1" ] || [ -z "$2" ]; then
    show_help
fi

# Route based on type
case "$2" in
    ipv6)
        handle_ipv6 "$1" "$2"
        ;;
    ipv4|domain)
        handle_target "$2" "$1"
        ;;
    *)
        print_error "Unknown type: $2"
        echo ""
        show_help
        ;;
esac

print_separator
echo ""
