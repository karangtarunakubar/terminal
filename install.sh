#!/usr/bin/env bash

# Hentikan eksekusi jika terjadi kesalahan
set -euo pipefail

# Warna untuk output terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Memeriksa akses root / sudo
if [ "${EUID}" -ne 0 ]; then
    echo -e "${RED}[ERROR] Script ini harus dijalankan dengan hak akses root atau sudo!${NC}" >&2
    echo -e "Silakan jalankan perintah: ${BLUE}sudo ./install.sh${NC}"
    exit 1
fi

echo -e "${BLUE}[1/4] Memperbarui daftar paket (apt update)...${NC}"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y

echo -e "${BLUE}[2/4] Meng-upgrade sistem (apt upgrade)...${NC}"
apt-get upgrade -y

echo -e "${BLUE}[3/4] Menginstall 'make' dan perkakas build dasar...${NC}"
apt-get install -y make build-essential wget curl

echo -e "${BLUE}[4/4] Membersihkan dependensi yang tidak terpakai...${NC}"
apt-get autoremove -y
apt-get clean

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Instalasi & Update Selesai!            ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo -e "Versi 'make' yang terpasang:"
make --version | head -n 1
