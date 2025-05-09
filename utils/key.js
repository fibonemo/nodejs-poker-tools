require('dotenv').config({ path: __dirname + '/.env' });
const crypto = require('crypto');
const fs = require('fs');

const algorithm = 'aes-256-ctr';
const secretKey = crypto.createHash('sha256').update(process.env.SECRET_KEY).digest();
const iv = Buffer.from('1234567890123456'); // Usa un IV statico per la decrittazione corretta

const filePath = 'utils/passwords.json';

// Funzione per generare password leggibili e sicure
function generateReadablePassword() {
    const words = ['Alpha', 'Beta', 'Gamma', 'Delta', 'Omega', 'Sigma', 'Pi', 'Zeta'];
    const randomWord = words[Math.floor(Math.random() * words.length)];
    const randomNum = Math.floor(100 + Math.random() * 900);
    const specialChars = "!@#$%^&*";
    const randomSpecial = specialChars[Math.floor(Math.random() * specialChars.length)];
    const randomUpper = String.fromCharCode(65 + Math.floor(Math.random() * 26));
    const extraChars = crypto.randomBytes(3).toString('hex').slice(0, 3);

    return `${randomUpper}${randomWord}${randomNum}${randomSpecial}${extraChars}`;
}

// Cifra un testo
function encrypt(text) {
    const cipher = crypto.createCipheriv(algorithm, Buffer.from(secretKey, 'utf-8'), iv);
    const encrypted = Buffer.concat([cipher.update(text), cipher.final()]);
    return encrypted.toString('hex');
}

// Decifra un testo
function decrypt(encryptedText) {
    const decipher = crypto.createDecipheriv(algorithm, Buffer.from(secretKey, 'utf-8'), iv);
    const decrypted = Buffer.concat([decipher.update(Buffer.from(encryptedText, 'hex')), decipher.final()]);
    return decrypted.toString();
}

// Genera e salva la password criptata
function generatePassword(key) {
    let passwords = {};
    if (fs.existsSync(filePath)) {
        passwords = JSON.parse(fs.readFileSync(filePath));
    }

    let newKey = key;
    let count = 1;
    while (passwords[newKey]) {
        newKey = `${key}_${count}`;
        count++;
    }

    const password = generateReadablePassword();
    const encryptedPassword = encrypt(password);
    passwords[newKey] = encryptedPassword;

    fs.writeFileSync(filePath, JSON.stringify(passwords, null, 2));

    console.log(`🔐 Password generata e salvata per "${newKey}".`);
}

// Legge una password criptata
function readPassword(key) {
    if (!fs.existsSync(filePath)) {
        console.log('⚠️ Nessuna password salvata.');
        return;
    }

    const passwords = JSON.parse(fs.readFileSync(filePath));
    if (!passwords[key]) {
        console.log(`⚠️ Nessuna password trovata per "${key}".`);
        return;
    }

    console.log(`🔓 Password per "${key}": ${decrypt(passwords[key])}`);
}

// Gestione CLI
const args = process.argv.slice(2);
if (args[0] === '--gen' && args[1]) {
    generatePassword(args[1]);
} else if (args[0] === '--read' && args[1]) {
    readPassword(args[1]);
} else {
    console.log('Usa:\n node utils/key.js --gen <chiave>\n node utils/key.js --read <chiave>');
}