// export function evaluatePLOHand(hand) {
//     const maxHandLength = 4;
//     if (hand.length !== maxHandLength) {
//         throw new Error("La mano deve avere esattamente " + maxHandLength + " carte!");
//     }

//     const pairs = [[hand[0], hand[1]], [hand[2], hand[3]]];
//     const score = pairs.map(pair => calculatePairScore(pair));

//     return { hand, pairs, totalScore: score.reduce((a, b) => a + b, 0), individualScores: score };
// }

// export function calculatePairScore(pair) {
//     let score = pair[0].suit === pair[1].suit ? 5 : 0;
//     score += pair[0].rank === pair[1].rank ? 7 : 0;
//     score += Math.abs(pair[0].rank - pair[1].rank) <= 2 ? 3 : 0;
//     return score;
// }
