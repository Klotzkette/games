const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 700,
        height: 850,
        minWidth: 500,
        minHeight: 700,
        title: 'Kanzlei Kreuzer & Kreis — Tic Tac Toe',
        backgroundColor: '#0a0a1a',
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true,
        },
        titleBarStyle: process.platform === 'darwin' ? 'hiddenInset' : 'default',
        show: false,
    });

    mainWindow.loadFile('tic-tac-toe.html');

    // Show window when ready to avoid flash
    mainWindow.once('ready-to-show', () => {
        mainWindow.show();
    });

    mainWindow.on('closed', () => {
        mainWindow = null;
    });
}

// Custom menu
const menuTemplate = [
    ...(process.platform === 'darwin' ? [{
        label: 'Kanzlei TTT',
        submenu: [
            { role: 'about', label: 'Über Kanzlei Tic Tac Toe' },
            { type: 'separator' },
            { role: 'hide', label: 'Ausblenden' },
            { role: 'hideOthers', label: 'Andere ausblenden' },
            { role: 'unhide', label: 'Alle einblenden' },
            { type: 'separator' },
            { role: 'quit', label: 'Beenden' },
        ]
    }] : []),
    {
        label: 'Spiel',
        submenu: [
            {
                label: 'Neue Verhandlung',
                accelerator: 'CmdOrCtrl+N',
                click: () => {
                    if (mainWindow) {
                        mainWindow.webContents.executeJavaScript('newGame()');
                    }
                }
            },
            { type: 'separator' },
            {
                label: 'Musik an/aus',
                accelerator: 'CmdOrCtrl+M',
                click: () => {
                    if (mainWindow) {
                        mainWindow.webContents.executeJavaScript('toggleMusic()');
                    }
                }
            },
            {
                label: 'Sound-Effekte an/aus',
                accelerator: 'CmdOrCtrl+S',
                click: () => {
                    if (mainWindow) {
                        mainWindow.webContents.executeJavaScript('toggleSfx()');
                    }
                }
            },
            { type: 'separator' },
            { role: 'togglefullscreen', label: 'Vollbild' },
        ]
    },
    {
        label: 'Ansicht',
        submenu: [
            { role: 'reload', label: 'Neu laden' },
            { role: 'toggleDevTools', label: 'Entwicklertools' },
            { type: 'separator' },
            { role: 'resetZoom', label: 'Originalgröße' },
            { role: 'zoomIn', label: 'Vergrößern' },
            { role: 'zoomOut', label: 'Verkleinern' },
        ]
    },
];

app.whenReady().then(() => {
    const menu = Menu.buildFromTemplate(menuTemplate);
    Menu.setApplicationMenu(menu);
    createWindow();
});

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
});
