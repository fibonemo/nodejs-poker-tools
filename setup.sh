#!/bin/bash

# Esegue il backup prima di iniziare la configurazione
if [ -f "./backup.sh" ]; then
    ./backup.sh
else
    echo "File di backup non trovato. Procedo con la configurazione."
fi
# Carica il file dei colori e delle funzioni di logging
source colors.sh || ( echo "Non esiste file colors.sh" ; exit 1 )

# Carica il file di configurazione
dir="PLO"

# Controlla se la cartella esiste già
if [ -d "$dir" ]; then
    log_error "La cartella '$dir' esiste già."
    exit 1
fi

# Controlla se il nome del progetto è passato come argomento
if [ -z "$1" ]; then
    log_warning "Nessun nome del progetto fornito. Utilizzo 'PLO' come nome predefinito."
else
    dir="$1"
fi

# Controlla se il nome del progetto è valido
if [[ ! "$dir" =~ ^[a-zA-Z0-9_]+$ ]]; then
    log_error "Il nome del progetto '$dir' non è valido. Uso 'PLO' come nome predefinito."
    dir="PLO"
fi

# Controlla se il nome del progetto è già in uso
if [ -d "$dir" ]; then
    log_error "Il nome del progetto '$dir' è già in uso. Scegli un altro nome."
    exit 1
fi

# Controlla se il nome del progetto è troppo lungo
if [ ${#dir} -gt 20 ]; then
    log_error "Il nome del progetto '$dir' è troppo lungo. Deve essere massimo 20 caratteri."
    exit 1
fi

# Creazione della cartella e dei file
log_info "Creazione della struttura del progetto: $dir..."
mkdir -p "$dir/utils" "$dir/data"

declare -a files=("index.js" "deck.js" "suitedness.js" "gap.js" "betSizing.js" "feedbackAI.js"
                  "utils/mathUtils.js" "utils/scraping.js" "data/hands.json" "data/stats.json")

for file in "${files[@]}"; do
    touch "$dir/$file" && log_success "Creato: $dir/$file"
done

# Inserisci il codice nei file principali
cat <<EOF > "$dir/index.js"
import generateDeck from "./deck.js";

const deck = generateDeck();

const test = (deck) => {
    console.log(deck);
};

test(deck);
EOF

cat <<EOF > "$dir/deck.js"
const fibonacci = (n) => {
    let a = 0, b = 1;
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
};

// Numero aureo per boostare TJ e A (eventualmente anche altre, salveremo in array...)
const goldenRatio = 1.618;

// Normalizziamo i valori per evitare che A sia troppo più forte
const calculatePower = (rank, value) => {
    let basePower = Math.round(fibonacci(value) * 0.13);
    return ["10", "J", "A"].includes(rank) ? Math.round(basePower * goldenRatio) : basePower;
};

const suits = ["hearts", "diamonds", "clubs", "spades"];
const ranks = [
    { rank: "2", value: 2 }, { rank: "3", value: 3 }, { rank: "4", value: 4 },
    { rank: "5", value: 5 }, { rank: "6", value: 6 }, { rank: "7", value: 7 },
    { rank: "8", value: 8 }, { rank: "9", value: 9 }, { rank: "10", value: 10 },
    { rank: "J", value: 11 }, { rank: "Q", value: 12 }, { rank: "K", value: 13 },
    { rank: "A", value: 14 }
];

// Genera il mazzo con valori aggiornati
const generateDeck = () => Object.freeze(
    suits.flatMap(suit => ranks.map(({ rank, value }) => ({
        suit, rank, value, power: calculatePower(rank, value)
    })));
);

export default generateDeck;
EOF

cat <<EOF > "$dir/score.js"
function evaluatePLOHand(hand) {
    const maxHandLength = 4;
    if (hand.length < 2 || hand.length > maxHandLength) {
        throw new Error("La mano deve avere tra 2 e maxHandLength carte!");
    }

    if (hand.length !== maxHandLength) {
        throw new Error("La mano deve avere esattamente maxHandLength) { carte!");
    }

    const pairs = [
        [hand[0], hand[1]],
        [hand[2], hand[3]]
    ];

    const score = pairs.map(pair => calculatePairScore(pair));
    
    return {
        hand,
        pairs,
        totalScore: score.reduce((a, b) => a + b, 0),
        individualScores: score
    };
}

function calculatePairScore(pair) {
    let score = 0;

    if (pair[0].suit === pair[1].suit) {
        score += 5;
    }

    if (pair[0].rank === pair[1].rank) {
        score += 7;
    }

    if (Math.abs(pair[0].rank - pair[1].rank) <= 2) {
        score += 3;
    }

    return score;
}

module.exports = { evaluatePLOHand, calculatePairScore };
EOF

cat <<EOF > "plo_start.sh"
#!/bin/bash
pwd
EOF

log_success "Setup completato con successo! 🚀"