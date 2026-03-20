# 🔧 RISOLUZIONE PROBLEMI COMUNI

## Problemi Durante l'Installazione

### ❌ "npm: command not found"
**Causa:** Node.js non installato o PATH non configurato

**Soluzione:**
1. Scarica e installa Node.js da https://nodejs.org/
2. Riavvia il terminale
3. Verifica: `node --version` e `npm --version`

---

### ❌ "cordova: command not found"
**Causa:** Cordova non installato globalmente

**Soluzione:**
```bash
npm install -g cordova
```

Se su Mac/Linux da errore di permessi:
```bash
sudo npm install -g cordova
```

Verifica: `cordova --version`

---

### ❌ "ANDROID_HOME is not set"
**Causa:** Variabile d'ambiente non configurata

**Soluzione Windows:**
1. Win+X → Sistema → Impostazioni avanzate → Variabili d'ambiente
2. Nuova variabile di sistema:
   - Nome: `ANDROID_HOME`
   - Valore: `C:\Users\TuoNome\AppData\Local\Android\Sdk`
3. Aggiungi a Path: `%ANDROID_HOME%\platform-tools`
4. Riavvia terminale

**Soluzione Mac:**
```bash
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc
```

**Soluzione Linux:**
```bash
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
source ~/.bashrc
```

Verifica: `echo $ANDROID_HOME` (Mac/Linux) o `echo %ANDROID_HOME%` (Windows)

---

## Problemi Durante la Compilazione

### ❌ "License for package Android SDK Build-Tools not accepted"
**Causa:** Licenze Android SDK non accettate

**Soluzione Windows:**
```cmd
cd %ANDROID_HOME%\cmdline-tools\latest\bin
sdkmanager --licenses
```

**Soluzione Mac/Linux:**
```bash
cd $ANDROID_HOME/cmdline-tools/latest/bin
./sdkmanager --licenses
```

Premi **'y'** per accettare tutte le licenze

---

### ❌ "Gradle build failed"
**Causa:** Versione Java non compatibile

**Soluzione:**
1. Verifica versione Java: `java -version`
2. Deve essere Java 17 (non 8, non 11, non 21)
3. Scarica Java 17 da https://adoptium.net/
4. Imposta JAVA_HOME:
   
   **Windows:**
   - Variabile sistema: `JAVA_HOME` = `C:\Program Files\Eclipse Adoptium\jdk-17.x.x`
   
   **Mac/Linux:**
   ```bash
   export JAVA_HOME=/percorso/java-17
   ```

---

### ❌ "Could not find or load main class org.gradle.wrapper.GradleWrapperMain"
**Causa:** Cache Gradle corrotta

**Soluzione:**
```bash
# Rimuovi piattaforma Android
cordova platform remove android

# Pulisci cache
rm -rf platforms/
rm -rf plugins/

# Ricompila
cordova platform add android
cordova build android
```

---

### ❌ "Failed to find Build Tools revision XX.X.X"
**Causa:** Build Tools non installato

**Soluzione:**
1. Apri Android Studio
2. SDK Manager → SDK Tools
3. Installa "Android SDK Build-Tools 34.x.x"
4. Applica modifiche
5. Ricompila

---

### ❌ "spawn EACCES"
**Causa:** Permessi su file di build

**Soluzione Mac/Linux:**
```bash
chmod +x build.sh
chmod -R 755 platforms/
chmod -R 755 node_modules/
```

---

## Problemi Durante l'Installazione sul Telefono

### ❌ "No devices found"
**Causa:** Telefono non riconosciuto

**Soluzione:**
1. Verifica che Debug USB sia attivo sul telefono
2. Disconnetti e riconnetti il cavo USB
3. Sul telefono: autorizza il PC quando richiesto
4. Verifica con: `adb devices`
5. Se non appare:
   - Prova un altro cavo USB
   - Installa driver USB del produttore
   - Su Windows: cerca "[marca telefono] USB driver"

---

### ❌ L'app si installa ma si chiude subito
**Causa:** Errore nell'app o mancanza permessi

**Soluzione:**
1. Controlla i log:
   ```bash
   adb logcat | grep -i error
   ```
2. Cerca messaggi tipo "ClassNotFoundException" o "NetworkError"
3. Se errore di rete:
   - L'app ha bisogno di internet per caricare React da CDN
   - Assicurati che il telefono sia connesso a WiFi/dati

---

### ❌ "App not installed" sul telefono
**Causa:** Versione precedente o corrotta

**Soluzione:**
1. Disinstalla completamente l'app dal telefono
2. Riavvia il telefono
3. Reinstalla l'APK

---

### ❌ "Parse error: There was a problem parsing the package"
**Causa:** APK corrotto o incompatibile

**Soluzione:**
1. Ricompila l'app:
   ```bash
   cordova clean
   cordova build android
   ```
2. Verifica versione Android del telefono (minimo Android 7.0)
3. Scarica di nuovo l'APK sul telefono

---

## Problemi con React/CDN

### ❌ Schermata bianca all'apertura
**Causa:** React non caricato da CDN

**Soluzione:**
1. Verifica connessione internet del telefono
2. Controlla console browser (se testi in browser):
   - Apri Developer Tools (F12)
   - Cerca errori di caricamento CDN
3. Alternative:
   - Usa WiFi invece di dati mobili
   - Controlla firewall aziendale che potrebbe bloccare CDN

---

## Problemi con localStorage

### ❌ "QuotaExceededError" o dati non salvati
**Causa:** Troppi dati o storage pieno

**Soluzione:**
1. Controlla spazio disponibile sul telefono
2. Limita numero di immagini per nota
3. Comprimi le immagini prima di caricarle
4. Esporta e cancella vecchie note:
   - Menu → Export Data
   - Elimina note vecchie
   - Importa se serve in futuro

---

## Test e Debug

### Come testare l'app senza telefono fisico

**Usa l'emulatore Android:**
1. Apri Android Studio
2. Tools → Device Manager
3. Create Device → Pixel 6
4. Download system image (Android 13)
5. Avvia l'emulatore
6. Esegui: `cordova run android`

---

### Come vedere i log dell'app

**Con telefono connesso:**
```bash
adb logcat | grep -i "chromium\|console"
```

**Filtro solo errori:**
```bash
adb logcat *:E
```

---

## Ancora Problemi?

### Checklist Completa

- [ ] Node.js installato (`node --version`)
- [ ] npm installato (`npm --version`)
- [ ] Cordova installato (`cordova --version`)
- [ ] Java 17 installato (`java -version`)
- [ ] Android Studio installato
- [ ] Android SDK installato (API 33 o 34)
- [ ] ANDROID_HOME configurato
- [ ] Licenze accettate
- [ ] Build-Tools installati
- [ ] Telefono in modalità sviluppatore
- [ ] Debug USB attivo
- [ ] Telefono riconosciuto (`adb devices`)
- [ ] Internet attivo sul telefono

Se tutti i punti sono ✅ ma non funziona:

1. **Prova a ricompilare da zero:**
   ```bash
   cordova clean
   rm -rf platforms/ plugins/
   cordova platform add android
   cordova build android
   ```

2. **Controlla versioni compatibili:**
   - Cordova: 12.x
   - cordova-android: 12.x
   - Node: 18.x o 20.x
   - Java: 17

3. **Cerca online:**
   - Google: "cordova android [tuo errore]"
   - Stack Overflow
   - GitHub Issues di Cordova

---

## Comandi Utili

```bash
# Pulisci progetto
cordova clean

# Vedi dispositivi connessi
adb devices

# Riavvia server ADB
adb kill-server
adb start-server

# Info dispositivo
adb shell getprop ro.build.version.release

# Disinstalla app
adb uninstall com.lemienote.app

# Vedi log app in tempo reale
adb logcat | grep -i chromium

# Cancella dati app
adb shell pm clear com.lemienote.app

# Prendi screenshot
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

---

**💡 Ricorda:** La maggior parte dei problemi si risolve con:
1. Riavviare il terminale
2. Accettare le licenze Android
3. Verificare ANDROID_HOME
4. Usare Java 17

**Buona fortuna! 🍀**
