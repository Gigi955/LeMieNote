# 📔 Le Mie Note - App Android Completa

App avanzata per gestire note, promemoria, categorie e calendario con tema chiaro/scuro.

## 🎯 Funzionalità dell'App

✅ **Gestione Note Completa**
- Creazione, modifica ed eliminazione note
- Categorie personalizzabili (Finanze, Giardino, Programmi AI, ecc.)
- Campo "Tema" per sottocategorie
- Supporto immagini multiple per nota
- Checkbox "Completata" per task
- Elimina in blocco tutte le note completate (menu ⋮ → "🗑 Elimina completate")

✅ **Calendario Integrato**
- Vista calendario con note per data
- Navigazione mese per mese
- Visualizzazione impegni giornalieri

✅ **Ricerca Avanzata**
- Ricerca in tutte le note
- Evidenziazione risultati in giallo nei campi Tema, Titolo e Contenuto
- Filtri per categoria e stato
- Aprendo una nota dai risultati di ricerca, Tema, Titolo e Contenuto mostrano il termine cercato evidenziato
- Tocca **✏️ Modifica contenuto** per passare alla modalità editing e modificare i campi

✅ **Promemoria**
- Imposta data e ora per reminder
- Badge visivo per note con promemoria

✅ **Personalizzazione**
- 5 stili di colore (Modern, Nature, Ocean, Sunset, Minimal)
- Tema chiaro e scuro
- Orientamento portrait

✅ **Sicurezza**
- Protezione con PIN opzionale
- Dati salvati localmente

✅ **Import/Export**
- Backup completo in JSON
- Importa dati da backup precedenti

---

## 🚀 GUIDA COMPLETA - Compilazione App Android

### STEP 1: Installazione Software Necessario

#### A) Node.js e npm
1. Vai su https://nodejs.org/
2. Scarica la versione **LTS** (Long Term Support)
3. Installa con le impostazioni predefinite
4. Verifica l'installazione:
   ```bash
   node --version
   npm --version
   ```
   Dovresti vedere i numeri di versione

#### B) Java JDK 17
1. Vai su https://adoptium.net/
2. Scarica **Java 17 (Temurin)**
3. Durante l'installazione:
   - ✅ Seleziona "Set JAVA_HOME variable"
   - ✅ Seleziona "Add to PATH"
4. Verifica:
   ```bash
   java -version
   ```
   Deve mostrare Java 17.x.x

#### C) Android Studio
1. Vai su https://developer.android.com/studio
2. Scarica Android Studio
3. Installa con l'installazione **Standard**
4. Al primo avvio lascia che installi tutto (può richiedere 15-30 minuti)

#### D) Configura Android SDK
1. Apri Android Studio
2. Clicca su "More Actions" → "SDK Manager" (o vai in Settings → Appearance & Behavior → System Settings → Android SDK)
3. Nella tab **"SDK Platforms"**:
   - ✅ Spunta **Android 13.0 (Tiramisu)** - API Level 33
   - ✅ Spunta **Android 14.0** - API Level 34 (consigliato)
4. Nella tab **"SDK Tools"**:
   - ✅ Android SDK Build-Tools
   - ✅ Android SDK Command-line Tools (latest)
   - ✅ Android SDK Platform-Tools
   - ✅ Android Emulator (opzionale, per testare senza telefono)
5. Clicca **"Apply"** e aspetta l'installazione

#### E) Configura Variabili d'Ambiente

**WINDOWS:**
1. Premi `Win + X` → "Sistema" → "Impostazioni di sistema avanzate"
2. Clicca "Variabili d'ambiente..."
3. Nella sezione "Variabili di sistema" clicca "Nuova":
   - **Nome variabile:** `ANDROID_HOME`
   - **Valore variabile:** `C:\Users\TuoNomeUtente\AppData\Local\Android\Sdk`
   
   (Sostituisci TuoNomeUtente con il tuo username Windows)

4. Trova la variabile **"Path"** e clicca "Modifica"
5. Clicca "Nuovo" e aggiungi queste righe:
   ```
   %ANDROID_HOME%\platform-tools
   %ANDROID_HOME%\tools
   %ANDROID_HOME%\cmdline-tools\latest\bin
   ```
6. Clicca OK su tutte le finestre
7. **IMPORTANTE:** Chiudi e riapri il Prompt dei comandi

**MAC:**
1. Apri Terminale
2. Esegui: `nano ~/.zshrc` (oppure `nano ~/.bash_profile` se usi bash)
3. Aggiungi alla fine del file:
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   ```
4. Salva: `Ctrl + O`, poi `Enter`, poi `Ctrl + X`
5. Applica le modifiche: `source ~/.zshrc`

**LINUX:**
1. Apri Terminale
2. Esegui: `nano ~/.bashrc`
3. Aggiungi alla fine:
   ```bash
   export ANDROID_HOME=$HOME/Android/Sdk
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   ```
4. Salva e esegui: `source ~/.bashrc`

**Verifica variabili d'ambiente:**
```bash
# Windows
echo %ANDROID_HOME%

# Mac/Linux
echo $ANDROID_HOME
```
Deve mostrare il percorso dell'SDK

#### F) Installa Cordova
Apri il terminale/prompt e esegui:
```bash
npm install -g cordova
```

Verifica:
```bash
cordova --version
```

#### G) Accetta Licenze Android
**Windows:**
```cmd
cd %ANDROID_HOME%\cmdline-tools\latest\bin
sdkmanager --licenses
```

**Mac/Linux:**
```bash
cd $ANDROID_HOME/cmdline-tools/latest/bin
./sdkmanager --licenses
```

Premi **'y'** per accettare tutte le licenze.

---

### STEP 2: Compilare l'App

1. **Apri il Terminale/Prompt dei Comandi**

2. **Vai nella cartella NotesApp:**
   ```bash
   cd /percorso/dove/hai/estratto/NotesApp
   ```

3. **OPZIONE A - Usa lo script automatico:**
   
   **Windows:**
   ```cmd
   build.bat
   ```
   
   **Mac/Linux:**
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

4. **OPZIONE B - Comandi manuali:**
   ```bash
   # Installa dipendenze
   npm install
   
   # Aggiungi piattaforma Android (solo la prima volta)
   cordova platform add android
   
   # Compila l'app
   cordova build android
   ```

5. **Aspetta la compilazione** (5-15 minuti la prima volta)

6. **L'APK sarà generato in:**
   ```
   platforms/android/app/build/outputs/apk/debug/app-debug.apk
   ```

---

### STEP 3: Installare sul Telefono

#### METODO A: Via USB (Raccomandato)

**Sul telefono Android:**
1. Vai in **Impostazioni → Informazioni sul telefono**
2. Tocca 7 volte su **"Numero build"**
3. Apparirà il messaggio "Sei uno sviluppatore!"
4. Torna in Impostazioni → **Opzioni sviluppatore**
5. Attiva **"Debug USB"**

**Sul PC:**
1. Collega il telefono al PC con cavo USB
2. Sul telefono autorizza il debug USB (apparirà un popup)
3. Nel terminale esegui:
   ```bash
   cordova run android
   ```
4. L'app verrà installata automaticamente!

**Se non funziona, verifica che il telefono sia riconosciuto:**
```bash
adb devices
```
Deve mostrare il tuo dispositivo

#### METODO B: Via APK Manuale

1. **Copia il file APK sul telefono:**
   - Via email
   - Via Google Drive/Dropbox
   - Via cavo USB (cartella Download)

2. **Sul telefono:**
   - Vai in **Impostazioni → Sicurezza**
   - Attiva **"Installa app da fonti sconosciute"**
   - Trova l'APK nella cartella Download
   - Tocca per installare

---

## 🎨 Personalizza le Icone

Le icone vanno in `res/icon/android/`:
- `ldpi.png` - 36x36 px
- `mdpi.png` - 48x48 px
- `hdpi.png` - 72x72 px
- `xhdpi.png` - 96x96 px
- `xxhdpi.png` - 144x144 px
- `xxxhdpi.png` - 192x192 px

**Generatori automatici di icone:**
- https://icon.kitchen/
- https://www.appicon.co/
- https://romannurik.github.io/AndroidAssetStudio/

Carica un'immagine 1024x1024 e scarica tutte le dimensioni.

---

## 🔧 Risoluzione Problemi

### ❌ "cordova: command not found"
**Soluzione:**
- Chiudi e riapri il terminale
- Reinstalla: `npm install -g cordova`
- Su Mac/Linux prova: `sudo npm install -g cordova`

### ❌ "ANDROID_HOME is not set"
**Soluzione:**
- Verifica le variabili d'ambiente
- Chiudi e riapri il terminale
- Controlla il percorso: `echo $ANDROID_HOME` o `echo %ANDROID_HOME%`

### ❌ "License not accepted"
**Soluzione:**
```bash
# Windows
cd %ANDROID_HOME%\cmdline-tools\latest\bin
sdkmanager --licenses

# Mac/Linux
cd $ANDROID_HOME/cmdline-tools/latest/bin
./sdkmanager --licenses
```
Premi 'y' per tutte

### ❌ "Gradle build failed"
**Soluzione:**
- Assicurati di avere Java 17: `java -version`
- Cancella la cartella `platforms` e ricompila:
  ```bash
  cordova platform remove android
  cordova platform add android
  cordova build android
  ```

### ❌ "Failed to install the following Android SDK packages"
**Soluzione:**
- Apri Android Studio → SDK Manager
- Installa Android SDK Build-Tools 34.x.x
- Accetta le licenze come sopra

### ❌ L'app si chiude subito dopo l'apertura
**Soluzione:**
- Controlla i log: `adb logcat | grep -i error`
- Potrebbe essere un problema con React CDN
- Verifica connessione internet del telefono

### ❌ "No devices found"
**Soluzione:**
- Verifica che Debug USB sia attivo
- Prova un altro cavo USB
- Installa driver USB del telefono
- Windows: Cerca "driver USB [marca telefono]"

---

## 📱 Testare su Emulatore

Se non hai un telefono fisico:

1. Apri Android Studio
2. Tools → Device Manager
3. Crea un nuovo dispositivo virtuale
4. Scegli Pixel 6 con Android 13
5. Avvia l'emulatore
6. Esegui: `cordova run android`

---

## 🔄 Aggiornare l'App

Per modificare l'app:

1. **Modifica** `www/index.html`
2. **Incrementa la versione** in `config.xml`:
   ```xml
   <widget id="com.lemienote.app" version="1.1.0">
   </widget>
   ```
3. **Ricompila:**
   ```bash
   cordova build android
   ```
4. **Reinstalla** sul telefono

---

## 📦 Compilare per il Play Store (Release)

### Genera Keystore

```bash
keytool -genkey -v -keystore lemienote-release.keystore -alias lemienote -keyalg RSA -keysize 2048 -validity 10000
```

Inserisci:
- Password (ricordala!)
- Nome, organizzazione, città, ecc.

### Crea build.json

```json
{
  "android": {
    "release": {
      "keystore": "lemienote-release.keystore",
      "storePassword": "la-tua-password",
      "alias": "lemienote",
      "password": "la-tua-password",
      "keystoreType": ""
    }
  }
}
```

### Compila Release

```bash
cordova build android --release
```

L'APK firmato sarà in:
```
platforms/android/app/build/outputs/apk/release/app-release.apk
```

---

## 📞 Supporto

- **Documentazione Cordova:** https://cordova.apache.org/docs/
- **Android Developer:** https://developer.android.com/
- **Stack Overflow:** Cerca "cordova android [tuo problema]"

---

## 📊 Dati e Privacy

- Tutti i dati sono salvati **localmente** sul telefono
- Nessuna connessione a server esterni (tranne CDN per React/Babel)
- Le immagini sono salvate in base64 nel localStorage
- Backup esportati in formato JSON

---

## 🎉 Fatto!

Ora hai la tua app Android completa!

Per domande o problemi, controlla la sezione "Risoluzione Problemi" sopra.

**Buon divertimento con Le Mie Note! 📝**
