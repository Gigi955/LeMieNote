# 🚀 GUIDA RAPIDA BUILD AUTOMATICO

## ⚡ INIZIO VELOCISSIMO (5 MINUTI)

### Windows:

```cmd
1. Estrai NotesApp-FINALE-v6.zip
2. Apri la cartella NotesApp-FINALE
3. Doppio click su: build-auto.bat
4. Aspetta 5-15 minuti
5. ✅ APK pronto!
```

### Mac/Linux:

```bash
unzip NotesApp-FINALE-v6.zip
cd NotesApp-FINALE
chmod +x build-auto.sh
./build-auto.sh
# Aspetta...
# ✅ APK pronto!
```

---

## 📋 COSA FA LO SCRIPT AUTOMATICAMENTE

Lo script `build-auto.bat` (o `.sh`) fa **TUTTO** per te:

### ✅ STEP 1: Verifica e Installa Cordova
- Controlla se Cordova è installato
- Se NON c'è → lo installa automaticamente con `npm install -g cordova`
- ✅ Nessuna azione richiesta!

### ✅ STEP 2: Verifica Android SDK
- Controlla variabile ANDROID_HOME
- Se manca → ti dice come configurarla
- Serve Android Studio installato

### ✅ STEP 3: Verifica Java
- Controlla Java 17
- Se manca → ti dice dove scaricarlo

### ✅ STEP 4: Verifica File Sorgenti
- Controlla che `www/index.html` esista
- Controlla che `config.xml` esista

### ✅ STEP 5: Crea Progetto Cordova
- Crea cartella `LeMieNote/`
- Inizializza progetto Cordova
- Se esiste già → chiede se sovrascrivere

### ✅ STEP 6: Copia File
- Copia `www/index.html` nel progetto
- Copia `config.xml` nel progetto
- Copia `package.json` (se esiste)

### ✅ STEP 7: Installa Dipendenze
- Esegue `npm install` automaticamente

### ✅ STEP 8: Aggiunge Piattaforma Android
- Esegue `cordova platform add android`

### ✅ STEP 9: Accetta Licenze Android
- Esegue `sdkmanager --licenses`

### ✅ STEP 10: Compila APK
- Esegue `cordova build android`
- Copia APK in `app-debug.apk` nella cartella principale
- Chiede se installare sul telefono
- Chiede se aprire cartella APK

---

## 📦 RISULTATO FINALE

Dopo l'esecuzione avrai:

```
NotesApp-FINALE/
├── build-auto.bat           ← Lo script che hai eseguito
├── www/
│   └── index.html
├── config.xml
├── LeMieNote/               ← Progetto Cordova creato
│   ├── platforms/
│   │   └── android/
│   │       └── app/build/outputs/apk/debug/
│   │           └── app-debug.apk  ← APK ORIGINALE
│   └── www/
│       └── index.html
└── app-debug.apk            ← APK COPIATO QUI (comodo!)
```

**APK pronto qui:** `app-debug.apk`

---

## 🎯 REQUISITI MINIMI

Prima di eseguire lo script, devi avere installato:

### 1. Node.js (OBBLIGATORIO)
```
Scarica da: https://nodejs.org/
Versione: 18 o superiore
```

### 2. Android Studio (OBBLIGATORIO)
```
Scarica da: https://developer.android.com/studio
Include: Android SDK
```

### 3. Java JDK 17 (OBBLIGATORIO)
```
Scarica da: https://adoptium.net/
Versione: 17 (non 21!)
```

### 4. Variabile ANDROID_HOME (OBBLIGATORIO)

**Windows:**
```cmd
1. Cerca "Variabili d'ambiente" nel menu Start
2. Variabili d'ambiente → Nuova (Utente)
3. Nome: ANDROID_HOME
4. Valore: C:\Users\[TuoNome]\AppData\Local\Android\Sdk
5. OK → OK
6. Riavvia terminale
```

**Mac:**
```bash
# Aggiungi a ~/.zshrc (o ~/.bashrc)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Poi riavvia terminale
```

**Linux:**
```bash
# Aggiungi a ~/.bashrc
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Poi: source ~/.bashrc
```

### 5. Cordova (AUTOMATICO!)
```
Lo script lo installa automaticamente!
Se vuoi installarlo prima: npm install -g cordova
```

---

## ✅ VERIFICA REQUISITI

Prima di eseguire lo script, verifica:

```cmd
# Verifica Node.js
node --version
# Deve mostrare: v18.x.x o superiore

# Verifica Java
java -version
# Deve mostrare: 17.x.x

# Verifica ANDROID_HOME (Windows)
echo %ANDROID_HOME%
# Deve mostrare: C:\Users\...\Android\Sdk

# Verifica ANDROID_HOME (Mac/Linux)
echo $ANDROID_HOME
# Deve mostrare: /Users/.../Android/sdk

# Verifica npm
npm --version
# Deve mostrare un numero
```

**Se uno di questi comandi fallisce → installa il requisito mancante!**

---

## 🔧 COSA FA LO SCRIPT SE MANCA QUALCOSA

### Scenario 1: Cordova non installato
```
[1/10] Verifica Cordova...
[ERRORE] Cordova non installato!

Installazione automatica di Cordova...
✅ Lo installa automaticamente!
```

### Scenario 2: ANDROID_HOME mancante
```
[2/10] Verifica Android SDK...
[ERRORE] ANDROID_HOME non configurato!

DEVI configurare Android SDK:
1. Apri Android Studio
2. SDK Manager → Installa Android SDK
3. Aggiungi variabile d'ambiente ANDROID_HOME

➡️ Ti dice esattamente cosa fare!
```

### Scenario 3: Java mancante
```
[3/10] Verifica Java...
[ERRORE] Java non trovato!

Installa Java 17 da: https://adoptium.net/

➡️ Ti dice dove scaricarlo!
```

### Scenario 4: Tutto OK!
```
[1/10] Verifica Cordova...
[OK] Cordova installato: 12.0.0

[2/10] Verifica Android SDK...
[OK] Android SDK: C:\Users\...\Android\Sdk

[3/10] Verifica Java...
[OK] Java installato: 17.0.2

...

[10/10] Compilazione APK...
BUILD SUCCESSFUL!

✅ APK pronto!
```

---

## 🚨 ERRORI COMUNI

### Errore: "Cordova non è riconosciuto"

**Causa:** npm non è nel PATH o Cordova non installato

**Soluzione:**
```cmd
# Installa manualmente
npm install -g cordova

# Riavvia terminale
```

---

### Errore: "ANDROID_HOME non configurato"

**Causa:** Variabile d'ambiente mancante

**Soluzione Windows:**
1. Menu Start → "Variabili d'ambiente"
2. Nuovo → Nome: ANDROID_HOME
3. Valore: C:\Users\TuoNome\AppData\Local\Android\Sdk
4. Riavvia terminale

**Soluzione Mac:**
```bash
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
source ~/.zshrc
```

---

### Errore: "Java non trovato"

**Causa:** Java non installato o versione sbagliata

**Soluzione:**
1. Scarica Java 17: https://adoptium.net/
2. Installa
3. Riavvia terminale
4. Verifica: `java -version`

---

### Errore: "sdkmanager: command not found"

**Causa:** Android SDK Command Line Tools non installati

**Soluzione:**
1. Apri Android Studio
2. SDK Manager
3. SDK Tools tab
4. ✅ Android SDK Command-line Tools
5. Apply

---

### Errore: BUILD FAILED durante compilazione

**Causa:** Licenze non accettate

**Soluzione:**
```bash
# Accetta licenze
%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager --licenses
# Digita 'y' per tutte le licenze
```

---

## 💡 SUGGERIMENTI

### 1. Prima Volta? Installa Tutto Prima

Prima di eseguire lo script:
```
✅ Installa Node.js
✅ Installa Android Studio
✅ Installa Java 17
✅ Configura ANDROID_HOME
✅ Accetta licenze Android
```

Lo script verifica tutto, ma è più veloce se è già installato!

---

### 2. Seconda Volta? Molto Più Veloce!

La seconda volta che compili:
- Cordova già installato ✅
- Dipendenze già scaricate ✅
- Piattaforma Android già aggiunta ✅

**Tempo: 2-3 minuti invece di 15!**

---

### 3. Problemi? Cancella e Ricrea

Se qualcosa va storto:
```cmd
# Cancella cartella progetto
rmdir /s /q LeMieNote

# Riesegui script
build-auto.bat
```

---

## 📱 DOPO IL BUILD

Quando vedi:
```
[OK] APK generato con successo!

Percorso: ...\app-debug.apk
Dimensione: 8 MB

Vuoi installare l'APK sul dispositivo? (S/N):
```

**Opzione 1: Installa automaticamente**
```
Digita: S
Collega telefono via USB
✅ Installazione automatica!
```

**Opzione 2: Installa manualmente**
```
Digita: N
Trova: app-debug.apk
Copia su telefono
Tocca per installare
```

---

## 🎉 SUCCESSO!

Se vedi questo:
```
========================================
  BUILD COMPLETATO CON SUCCESSO!
========================================

[OK] APK generato con successo!
```

**HAI FINITO! 🎊**

Il tuo APK è pronto in: `app-debug.apk`

---

## 🆘 SERVE AIUTO?

**Script fallisce?**
→ Leggi i messaggi di errore, ti dicono esattamente cosa fare

**Build ok ma app non funziona?**
→ Leggi: `RISOLUZIONE_ANDROID_NON_AGGIORNATA.md`

**Altre domande?**
→ Leggi: `README.md` per la guida completa

---

**BUON BUILD! 🚀**
