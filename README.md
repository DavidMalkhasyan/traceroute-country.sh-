# traceroute-country.sh

A Bash script that reveals the true path of your internet traffic — hop by hop — with full country names.

## ✨ Features

- Runs `traceroute` to any domain or IP
- Shows IP, reverse-resolved hostname, and full country name for each hop
- Uses `ipinfo.io` for IP geolocation
- Displays results in a clean table format
- Great for debugging VPNs, censorship routes, or unusual network behavior

## 📦 Requirements

- `bash`
- `traceroute`
- `curl`
- `getent` (part of GNU `libc`)

## 🚀 Usage

```bash
chmod +x traceroute-country.sh
./traceroute-country.sh example.com
