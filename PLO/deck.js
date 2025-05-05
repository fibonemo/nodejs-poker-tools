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
