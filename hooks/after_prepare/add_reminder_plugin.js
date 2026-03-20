#!/usr/bin/env node

// Hook per aggiungere il ReminderPlugin al config.xml della piattaforma Android
// Cordova rigenera questo file ad ogni prepare, quindi bisogna ri-aggiungere il plugin

var fs = require('fs');
var path = require('path');

module.exports = function(context) {
    var configPath = path.join(context.opts.projectRoot, 'platforms', 'android', 'app', 'src', 'main', 'res', 'xml', 'config.xml');

    if (!fs.existsSync(configPath)) {
        console.log('config.xml della piattaforma non trovato, skip');
        return;
    }

    var content = fs.readFileSync(configPath, 'utf-8');

    // Verifica se il plugin è già registrato
    if (content.indexOf('ReminderPlugin') !== -1) {
        console.log('ReminderPlugin già registrato nel config.xml');
        return;
    }

    // Aggiungi la feature prima di <name>
    var featureEntry = '    <feature name="ReminderPlugin">\n        <param name="android-package" value="com.lemienote.app.ReminderPlugin" />\n    </feature>\n';

    content = content.replace('<name>Le Mie Note</name>', featureEntry + '    <name>Le Mie Note</name>');

    fs.writeFileSync(configPath, content, 'utf-8');
    console.log('ReminderPlugin aggiunto al config.xml della piattaforma');
};
