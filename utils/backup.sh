
source colors.sh --debug || {
    echo -e "!!!![ERRORE] colors.sh non trovato!"
    exit 1
}

source config.cfg || { 
    log_error -e "${RED}[ERRORE] config.cfg non trovato! Il backup potrebbe non funzionare correttamente.${NC}" 
    exit 1 
}

should_exclude() {
    local file="$1"
    [[ -d "$file" || "$file" =~ \.sh$ || "$file" =~ \.cfg$ || "$file" =~ ^\. || "$file" =~ ^package ]] && return 0
    return 1
}

exclude_files() {
    for file in *; do
        if [[ "$file" == "backups" ]]; then
            log_warning "Ignorata la cartella 'backups' per evitare errori."
            continue
        fi

        if ! should_exclude "$file"; then
            if mv "$file" "$backup_dir/"; then
                log_success "Backup completato: $file → $backup_dir/"
            else
                log_error "[CRITICO] Impossibile spostare: $file. Controlla permessi e spazio su disco."
                exit 1
            fi
        else
            log_info "Ignorato: $file"
        fi
    done
}

if [[ -z "$BACKUP_DIR" ]]; then
    log_error "[CRITICO] BACKUP_DIR non definito in config.cfg!"
    exit 1
fi
