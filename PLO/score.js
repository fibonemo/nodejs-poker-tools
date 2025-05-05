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
