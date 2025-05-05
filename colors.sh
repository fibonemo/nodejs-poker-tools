#!/bin/bash

# # Colori ANSI per output
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[0;33m'
# CYAN='\033[0;36m'
# NC='\033[0m' # Reset colori
source "./utils/colors.sh" || { 
    echo -e "!!!![ERRORE] $(pwd)/utils/colors.sh non trovato! Il backup potrebbe non funzionare correttamente." 
    exit 1 
}

if [[ $1 == "$COLORS_FLAG" ]]; then
    colors_debug
else
    echo "Modalità debug colori non attivata. Usa --debug per attivarla."
fi

export RED GREEN YELLOW CYAN NC log_error log_warning log_success log_info