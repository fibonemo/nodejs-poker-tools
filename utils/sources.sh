#!/bin/bash

safe_source() {
    for file in "$@"; do
        [[ -f "$file" ]] && source "$file" || echo -e "\033[0;31m[ERRORE] File non trovato: $file\033[0m"
    done
}

#======================================================================
tmp="$(pwd)"
cd "/d/nodejs-poker-tools/"
# andra aggiornato
#======================================================================
# Carica le dipendenze principali
safe_source "./utils/colors.sh"
safe_source "./config.cfg"
# safe_source "./colors.sh"
safe_source "./utils/grant_permissions.sh"
safe_source "./utils/backup.sh"

cd "$tmp"
#======================================================================
#======================================================================
export -f safe_source  # Permette di usarla in tutti gli script che includono `sources.sh`