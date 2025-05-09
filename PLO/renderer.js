const { generateDeck } = require("./deck.js");

document.addEventListener("DOMContentLoaded", () => {
    const deckContainer = document.getElementById("deck");
    generateDeck().forEach(card => {
        const cardElement = document.createElement("div");
        cardElement.classList.add("card");
        cardElement.innerHTML = `<p>${card.rank} di ${card.suit}</p>`;
        //  <img src="${card.imgSrc}" alt="${card.value}">
        deckContainer.appendChild(cardElement);
    });
});