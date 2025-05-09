#!/bin/bash

# Genera una secret key casuale
SECRET_KEY=$(openssl rand -hex 32)

# Stampa la chiave generata
echo "🔐 Secret Key generata:"
echo "$SECRET_KEY"

# Opzionale: Salva la chiave in un file .env
echo "SECRET_KEY=$SECRET_KEY" > utils/.env
echo "✅ Chiave salvata in utils/.env"