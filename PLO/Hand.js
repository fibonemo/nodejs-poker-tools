class Hand {
    constructor(deck, numCards, shuffle = false) {
        this.deck = deck;
        this.numCards = numCards || 2;
        this.hand = [];
        this.handPower = 0;
        if (shuffle) {
            this.shuffle();
            this.handPower = this.calculateHandPower();

            console.log("Hand power:", this.handPower);
        }
    }

    shuffle() {
        let shuffledDeck = [...this.deck];

        for (let i = shuffledDeck.length - 1; i > 0; i--) {
            let j = Math.floor(Math.random() * (i + 1));
            [shuffledDeck[i], shuffledDeck[j]] = [shuffledDeck[j], shuffledDeck[i]];
        }

        this.hand = shuffledDeck.slice(0, this.numCards);
        console.log("Hand shuffled:", this.hand);
        return this.hand;
    }
    calculateHandPower() {
        let power = 0;
        this.hand.forEach(card => {
            power += card.power;
        });
        return power;
    }
    assignHand(...cards) {
        if (cards.length !== this.numCards) {
            throw new Error("La mano deve avere esattamente " + this.numCards + " carte!");
        }
        this.hand = cards;
        this.handPower = this.calculateHandPower();
        console.log("Hand assigned:", this.hand);
        return this.hand;
    }
}

module.exports = Hand;