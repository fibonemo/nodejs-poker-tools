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
