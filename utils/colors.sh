# source "./colors.cfg" || { 
#     echo -e "!!!![ERRORE] colors.sh non trovato! Il backup potrebbe non funzionare correttamente." 
#     exit 1 
# }

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
colors_debug() {
    echo "========================="
    # Test delle funzioni (puoi rimuovere queste righe)
    log_error "Qualcosa è andato storto!"
    log_warning "Questo potrebbe causare problemi."
    log_success "Operazione completata con successo!"
    log_info "Sto eseguendo un'operazione..."
    echo "========================="
}