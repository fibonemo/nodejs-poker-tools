#!/bin/bash
# source "./utils/colors.sh" || { 
#     echo -e "!!!![ERRORE] $(pwd)/utils/colors.sh non trovato! Il backup potrebbe non funzionare correttamente." 
#     exit 1 
# }
# source "./config.cfg" || { 
#     log_error -e "${RED}[ERRORE] config.cfg non trovato! Il backup potrebbe non funzionare correttamente.${NC}" 
#     exit 1 
# }

# source "./utils/backup.sh" || { 
#     log_error -e "${RED}[ERRORE] $(pwd)/utils/backup.sh non trovato! Il backup potrebbe non funzionare correttamente.${NC}" 
#     exit 1 
# }
source "./utils/sources.sh" || exit 1
backup_dir="${BACKUP_DIR}/$(date +'%d%m%Y_%H%M')"

log_info "Cartella di backup: $backup_dir"

mkdir -p "backups" "$backup_dir"

log_info "Inizio backup in '$backup_dir'..."

exclude_files

log_success "🔥 Backup completato senza problemi! 🚀♠️"