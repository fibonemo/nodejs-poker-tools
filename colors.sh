#!/bin/bash

# Colori ANSI per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Reset colori

# Funzione di log per errori
log_error() {
    echo -e "${RED}[ERRORE] $1${NC}"
}

# Funzione di log per avvisi
log_warning() {
    echo -e "${YELLOW}[ATTENZIONE] $1${NC}"
}

# Funzione di log per successi
log_success() {
    echo -e "${GREEN}[OK] $1${NC}"
}

# Funzione di log per informazioni
log_info() {
    echo -e "${CYAN}[INFO] $1${NC}"
}

# LOG PER SEGNALARE MESSAGGI DI PROVA, INSERITI IN FUNZIONE ATTIVABILE CON PARAMETRO --debug
debug() {
    echo "========================="
    # Test delle funzioni (puoi rimuovere queste righe)
    log_error "Qualcosa è andato storto!"
    log_warning "Questo potrebbe causare problemi."
    log_success "Operazione completata con successo!"
    log_info "Sto eseguendo un'operazione..."
    echo "========================="
}

if [[ $1 == "--debug" ]]; then
    debug 
else
    echo "Modalità debug colori non attivata. Usa --debug per attivarla."
fi

export RED GREEN YELLOW CYAN NC log_error log_warning log_success log_info