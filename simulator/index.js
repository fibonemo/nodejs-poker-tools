const { app, BrowserWindow } = require('electron');
// const path = require('path');

app.on('ready', () => {
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            // preload: path.join(__dirname, 'renderer.js'),
            nodeIntegration: true
        },
    });
    mainWindow.loadFile('index.html');
});