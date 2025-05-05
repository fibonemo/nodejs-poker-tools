#!/bin/bash

# Controlla se è stato passato il flag --check
CHECK_MODE=false
if [[ "$1" == "--check" ]]; then
    CHECK_MODE=true
fi

# Estrae le directory da escludere dal .gitignore
EXCLUDE_DIRS=$(grep -E "^/" .gitignore | sed 's#^/##' | tr '\n' '|' | sed 's/|$//')

# Trova tutti i file .sh escludendo le directory nel .gitignore
find . -type f -name "*.sh" | grep -Ev "$EXCLUDE_DIRS" | while read file; do
    echo "Trovato: $file"
    if [[ "$CHECK_MODE" == false ]]; then
        chmod +x "$file"
    fi
done

if [[ "$CHECK_MODE" == true ]]; then
    echo "Modalità verifica: nessuna modifica ai permessi, solo elenco dei file."
else
    echo "Permessi di esecuzione assegnati ai file bash trovati."
fi