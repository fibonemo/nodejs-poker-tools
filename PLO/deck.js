const fs = require('fs');

// Fibonacci-based rank values
const rankValues = {
    '2': 1, '3': 1, '4': 2, '5': 3, '6': 5, '7': 8, '8': 13, '9': 21,
    T: 34, J: 55, Q: 89, K: 144, A: 233
};

const goldenRatio = 1.618;
const suits = ["hearts", "diamonds", "clubs", "spades"];

// Function to calculate power using Golden Ratio
function getPower(rankValue) {
    if (!rankValue || rankValue <= 0) return 1;
    return Math.round(Math.sqrt(rankValue * goldenRatio));
}

// Logarithmic Normalization
function logNormalize(value, min, max) {
    return (Math.log(value) - Math.log(min)) / (Math.log(max) - Math.log(min));
}

// Playability Calculation (with Log Normalization)
function calculatePlayability(rankValues, goldenRatio) {
    const values = Object.values(rankValues);
    const minValue = Math.min(...values);
    const maxValue = Math.max(...values);

    const playabilityScores = {};

    for (const [rank, value] of Object.entries(rankValues)) {
        const normalizedValue = logNormalize(value, minValue, maxValue);
        const rawPower = Math.sqrt(value * goldenRatio);
        const normalizedPower = logNormalize(rawPower, Math.sqrt(minValue * goldenRatio), Math.sqrt(maxValue * goldenRatio));

        const gapBonus = 0; // Placeholder for gap calculations
        const suitedBonus = 0; // Placeholder for suitedness calculations

        playabilityScores[rank] = (0.6 * normalizedValue) + (0.4 * normalizedPower) + gapBonus + suitedBonus;
    }

    
    console.log("Playability Scores:", playabilityScores);

    console.log("------------------------------------------------------");
    
    return playabilityScores;
}

// Deck generation with Fibonacci Rank Values + Playability
function generateDeck() {
    const playabilityScores = calculatePlayability(rankValues, goldenRatio);

    return suits.flatMap(suit => {
        return Object.keys(rankValues).map(rank => ({
            suit: suit,
            rank: rank,
            value: getPower(rankValues[rank]),
            playability: playabilityScores[rank]
        }));
    });
}

module.exports = { generateDeck, suits, rankValues };
