#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <domain_or_ip>"
  exit 1
fi

declare -A COUNTRY_NAMES=(
  [US]="United States"     [RU]="Russia"           [AM]="Armenia"
  [DE]="Germany"           [FR]="France"           [TR]="Turkey"
  [IR]="Iran"              [GB]="United Kingdom"   [NL]="Netherlands"
  [BG]="Bulgaria"          [IT]="Italy"            [ES]="Spain"
  [CN]="China"             [JP]="Japan"            [IN]="India"
  [CA]="Canada"            [AU]="Australia"        [UA]="Ukraine"
  [CH]="Switzerland"       [PL]="Poland"           [SE]="Sweden"
  [NO]="Norway"            [FI]="Finland"          [DK]="Denmark"
  [BE]="Belgium"           [AT]="Austria"          [CZ]="Czech Republic"
  [SK]="Slovakia"          [HU]="Hungary"          [RO]="Romania"
  [BY]="Belarus"           [KZ]="Kazakhstan"       [GE]="Georgia"
  [GR]="Greece"            [PT]="Portugal"         [IL]="Israel"
  [EG]="Egypt"             [ZA]="South Africa"     [KR]="South Korea"
  [SG]="Singapore"         [BR]="Brazil"           [AR]="Argentina"
  [MX]="Mexico"            [CL]="Chile"            [NZ]="New Zealand"
  [TH]="Thailand"          [ID]="Indonesia"        [PH]="Philippines"
  [AE]="United Arab Emirates" [SA]="Saudi Arabia"  [NG]="Nigeria"
)

host=$1

echo -e "\nTracing route to $host...\n"
printf "%-3s %-20s %-40s %-30s\n" "Hop" "IP" "Hostname" "Country"
echo "--------------------------------------------------------------------------------------------------------------"

hop=0

traceroute "$host" | while read -r line; do
  ip=$(echo "$line" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1)

  if [ -z "$ip" ]; then
    ((hop++))
    printf "%-3s %-20s %-40s %-30s\n" "$hop" "*" "No response" "-"
  else
    hostname=$(getent hosts "$ip" | awk '{print $2}')
    [ -z "$hostname" ] && hostname="(unknown)"
    code=$(curl -s "https://ipinfo.io/$ip/country")
    country="${COUNTRY_NAMES[$code]}"
    [ -z "$country" ] && country="$code"
    ((hop++))
    printf "%-3s %-20s %-40s %-30s\n" "$hop" "$ip" "$hostname" "$country"
  fi
done

