#!/bin/bash

# Controlla l'esistenza di `sources.sh` prima di richiamarlo
if [[ ! -f "./utils/sources.sh" ]]; then
    echo -e "\033[0;31m[ERRORE] $(pwd)/utils/sources.sh non trovato!\033[0m"
    exit 1
fi

# Carica le dipendenze
source "./utils/sources.sh"

# Controlla se il nome del progetto è stato passato
PROJECT_DIR=${PROJECT_DIR:-"PLO"}  # Usa 'PLO' come default se non viene fornito un nome

# Verifica validità del nome del progetto
if [[ ! "$PROJECT_DIR" =~ ^[a-zA-Z0-9_]+$ ]]; then
    log_error "Nome progetto non valido! Uso 'PLO' come nome predefinito."
    PROJECT_DIR="PLO"
fi

# Controlla se la cartella esiste già
if [[ -d "$PROJECT_DIR" ]]; then
    log_error "La cartella '$PROJECT_DIR' esiste già!"
    exit 1
fi

# Controlla la lunghezza del nome
if [[ ${#PROJECT_DIR} -gt 20 ]]; then
    log_error "Nome troppo lungo! Deve essere massimo 20 caratteri."
    exit 1
fi

# Creazione della struttura
log_info "Creazione della struttura del progetto: $PROJECT_DIR..."
mkdir -p "$PROJECT_DIR"
# mkdir -p "$PROJECT_DIR/utils" "$PROJECT_DIR/data"

# declare -a files=("index.js" "deck.js" "suitedness.js" "gap.js" "betSizing.js" "feedbackAI.js"
#                   "utils/mathUtils.js" "utils/scraping.js" "data/hands.json" "data/stats.json")

# for file in "${files[@]}"; do
#     touch "$PROJECT_DIR/$file" && log_success "Creato: $PROJECT_DIR/$file"
# done

log_info "Creazione index.js, deck.js, score.js e package.json..."
cat <<EOF > "$PROJECT_DIR/index.js"
import generateDeck from "./deck.js";

const deck = generateDeck();
console.log(deck);
EOF

cat <<EOF > "$PROJECT_DIR/deck.js"
const fibonacci = (n) => {
    let a = 0, b = 1;
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
};

const goldenRatio = 1.618;
const suits = ["hearts", "diamonds", "clubs", "spades"];
const ranks = [...Array(13).keys()].map(i => ({ rank: String(i+2), value: i+2 }));

const generateDeck = () => suits.flatMap(suit => ranks.map(({ rank, value }) => ({
    suit, rank, value, power: Math.round(fibonacci(value) * 0.13 * (["10", "J", "A"].includes(rank) ? goldenRatio : 1))
})));

export default generateDeck;
EOF

cat <<EOF > "$PROJECT_DIR/score.js"
function evaluatePLOHand(hand) {
    const maxHandLength = 4;
    if (hand.length !== maxHandLength) {
        throw new Error("La mano deve avere esattamente " + maxHandLength + " carte!");
    }

    const pairs = [[hand[0], hand[1]], [hand[2], hand[3]]];
    const score = pairs.map(pair => calculatePairScore(pair));

    return { hand, pairs, totalScore: score.reduce((a, b) => a + b, 0), individualScores: score };
}

function calculatePairScore(pair) {
    let score = pair[0].suit === pair[1].suit ? 5 : 0;
    score += pair[0].rank === pair[1].rank ? 7 : 0;
    score += Math.abs(pair[0].rank - pair[1].rank) <= 2 ? 3 : 0;
    return score;
}

module.exports = { evaluatePLOHand, calculatePairScore };
EOF

cat <<EOF > "$PROJECT_DIR/package.json"
{
  "name": "nodejs-poker-tools",
  "version": "0.0.1",
  "description": "Software per gestire bankroll e strategie/percentuali per il gioco del poker.",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "test": "echo 'ciao ciao' && exit 0",
    "_dev": "nodemon --ignore combos.json index.js",
    "dev": "nodemon index.js",
    "_setup": "chmod +x setup.sh && bash ./setup.sh",
    "_backup": "chmod +x backup.sh && bash ./backup.sh"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/fibonemo/nodejs-poker-tools.git"
  },
  "keywords": [
    "poker",
    "bankroll",
    "strategy",
    "chip-management",
    "hand-analysis",
    "tournament",
    "cash-game",
    "game-theory",
    "odds-calculation",
    "decision-making",
    "grinding",
    "bankroll-discipline"
  ],
  "author": "Andriani Claudio",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/fibonemo/nodejs-poker-tools/issues"
  },
  "homepage": "https://github.com/fibonemo/nodejs-poker-tools#readme",
  "devDependencies": {
    "nodemon": "^3.1.10"
  }
}
EOF

cd $PROJECT_DIR || exit 1

log_info "Installazione delle dipendenze..."
npm i

log_success "Setup completato con successo! 🚀"