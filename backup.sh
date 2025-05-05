#!/bin/bash

source colors.sh || { 
    echo -e "${RED}[ERRORE] colors.sh non trovato! Il backup potrebbe non funzionare correttamente.${NC}" 
    exit 1 
}

backup_dir="backups/$(date +'%d%m%Y_%H%M')"

mkdir -p "backups"
mkdir -p "$backup_dir"

exclude_files=("package.json" "package-lock.json" "colors.sh" "backup.sh" "setup.sh" ".gitignore")

should_exclude() {
    local file="$1"
    for excluded in "${exclude_files[@]}"; do
        if [[ "$file" == "$excluded" ]]; then
            return 0
        fi
    done
    return 1
}

log_info "Inizio backup in '$backup_dir'..."
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

log_success "🔥 Backup completato senza problemi! 🚀♠️"