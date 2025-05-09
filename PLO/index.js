const { app, BrowserWindow } = require('electron');
const path = require('path');
const { generateDeck, suits, rankValues } = require("./deck.js");
const Hand = require("./Hand.js");

const deck = generateDeck();
const hand = new Hand(deck, 4);
hand.shuffle();

app.on('ready', () => {
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: path.join(__dirname, 'renderer.js'),
            nodeIntegration: true
        },
    });
    mainWindow.loadFile('index.html');
});

// Ensure the app closes correctly on macOS
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});