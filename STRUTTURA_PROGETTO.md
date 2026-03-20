# 📁 STRUTTURA DEL PROGETTO

```
NotesApp/
│
├── www/                          # Codice sorgente dell'app
│   └── index.html               # App completa (React + CSS + JS)
│
├── res/                          # Risorse
│   ├── icon/                    # Icone app
│   │   └── android/
│   │       ├── ldpi.png         # 36x36
│   │       ├── mdpi.png         # 48x48
│   │       ├── hdpi.png         # 72x72
│   │       ├── xhdpi.png        # 96x96
│   │       ├── xxhdpi.png       # 144x144
│   │       └── xxxhdpi.png      # 192x192
│   │
│   └── splash/                  # Schermate splash (opzionale)
│       └── android/
│
├── platforms/                    # [Generato] Codice nativo Android
│   └── android/                 # Creato con 'cordova platform add android'
│       └── app/
│           └── build/
│               └── outputs/
│                   └── apk/
│                       └── debug/
│                           └── app-debug.apk  # ← TUO APK!
│
├── plugins/                      # [Generato] Plugin Cordova
│   ├── cordova-plugin-camera/
│   ├── cordova-plugin-file/
│   ├── cordova-plugin-statusbar/
│   └── ...
│
├── node_modules/                 # [Generato] Dipendenze npm
│
├── config.xml                    # Configurazione Cordova
├── package.json                  # Dipendenze npm
├── package-lock.json            # [Generato] Lock delle versioni
│
├── build.sh                      # Script compilazione (Mac/Linux)
├── build.bat                     # Script compilazione (Windows)
│
├── README.md                     # Documentazione completa
├── GUIDA_RAPIDA.md              # Quick start
├── TROUBLESHOOTING.md           # Risoluzione problemi
├── genera-icone.html            # Generatore icone
│
└── STRUTTURA_PROGETTO.md        # Questo file
```

---

## 📄 File Principali

### `www/index.html`
Il cuore dell'app! Contiene:
- **React Components** - UI dell'app
- **CSS Styling** - Tutti gli stili
- **JavaScript Logic** - Tutta la logica
- **localStorage** - Salvataggio dati

**Dimensione:** ~75 KB  
**Tecnologie:** React 18, Babel, Vanilla JS

### `config.xml`
Configurazione Cordova:
- ID app: `com.lemienote.app`
- Nome: "Le Mie Note"
- Versione: 1.0.0
- Permessi
- Plugin utilizzati
- Preferenze Android

### `package.json`
Dipendenze e script:
- Cordova plugins
- Android platform
- Script npm personalizzati

---

## 🔧 Cartelle Modificabili

### ✅ Puoi modificare:
- `www/index.html` - Cambia l'app
- `res/icon/android/*.png` - Cambia icone
- `config.xml` - Cambia configurazioni

### ⛔ Non modificare:
- `platforms/` - Viene rigenerato
- `plugins/` - Viene rigenerato
- `node_modules/` - Gestito da npm

---

## 🔄 Processo di Compilazione

1. **Tu modifichi:** `www/index.html`
2. **Cordova copia:** da `www/` a `platforms/android/app/src/main/assets/www/`
3. **Android compila:** Codice nativo + WebView
4. **Ottieni:** APK in `platforms/android/app/build/outputs/apk/`

---

## 📦 Plugin Installati

| Plugin | Funzione |
|--------|----------|
| cordova-plugin-camera | Accesso fotocamera (per future features) |
| cordova-plugin-file | Gestione file |
| cordova-plugin-statusbar | Personalizza barra stato |
| cordova-plugin-splashscreen | Schermata iniziale |
| cordova-plugin-whitelist | Sicurezza URL |
| cordova-plugin-device | Info dispositivo |

---

## 🎯 Dove Trovare l'APK

Dopo `cordova build android`:

**Debug APK (per test):**
```
platforms/android/app/build/outputs/apk/debug/app-debug.apk
```
✅ Usa questo per installare sul telefono durante lo sviluppo

**Release APK (per Play Store):**
```
platforms/android/app/build/outputs/apk/release/app-release.apk
```
⚠️ Richiede firma con keystore (vedi README.md)

---

## 📝 Come Modificare l'App

### 1. Modifica il codice
```bash
# Apri con editor di testo
nano www/index.html
# oppure
code www/index.html
# oppure usa il tuo editor preferito
```

### 2. Testa in browser (rapido)
```bash
# Apri direttamente in browser
open www/index.html
# oppure
google-chrome www/index.html
```

### 3. Compila per Android
```bash
cordova build android
```

### 4. Installa su telefono
```bash
cordova run android
```

---

## 🔍 Dimensioni File

| File/Cartella | Dimensione | Note |
|---------------|------------|------|
| www/index.html | ~75 KB | App completa |
| APK debug | ~7-10 MB | Include WebView e framework |
| APK release | ~5-7 MB | Ottimizzato e compresso |
| node_modules/ | ~50-100 MB | Solo per sviluppo |
| platforms/ | ~200-300 MB | Solo per sviluppo |

**APK finale sul telefono:** circa 5-10 MB

---

## 🚀 Comandi Rapidi

```bash
# Compila
cordova build android

# Installa e avvia
cordova run android

# Pulisci build precedente
cordova clean

# Rimuovi piattaforma
cordova platform remove android

# Aggiungi piattaforma
cordova platform add android

# Lista piattaforme
cordova platform ls

# Info progetto
cordova info

# Lista plugin
cordova plugin ls
```

---

## 📱 Tecnologie Utilizzate

### Frontend
- **React 18** - UI Components
- **Babel Standalone** - JSX transpiler
- **CSS3** - Styling avanzato
- **localStorage** - Persistenza dati

### Backend/Build
- **Cordova** - Framework ibrido
- **Android WebView** - Browser integrato
- **Gradle** - Build system Android

### CDN Esterni
```
https://unpkg.com/react@18/umd/react.production.min.js
https://unpkg.com/react-dom@18/umd/react-dom.production.min.js
https://unpkg.com/@babel/standalone/babel.min.js
```

⚠️ **Nota:** L'app richiede internet alla prima apertura per caricare React/Babel. Dopo viene cachato.

---

## 🎨 Personalizzazione

### Cambia Nome App
Modifica in `config.xml`:
```xml
<name>Il Tuo Nome App</name>
```

### Cambia ID App
```xml
<widget id="com.tuodominio.app" ...>
```

### Cambia Versione
```xml
<widget ... version="2.0.0" ...>
```

### Cambia Icona
Sostituisci file in `res/icon/android/`

### Cambia Colore Barra
In `config.xml`:
```xml
<preference name="StatusBarBackgroundColor" value="#FF5722" />
```

---

## 📊 Dati Salvati

L'app salva in localStorage del WebView:

| Chiave | Contenuto |
|--------|-----------|
| notesAppData | Array di tutte le note (JSON) |
| notesAppCategories | Array categorie personalizzate |
| notesAppTheme | Tema corrente (light/dark) |
| notesAppStyle | Stile colore (modern/nature/ocean/sunset/minimal) |

**Percorso Android:**
```
/data/data/com.lemienote.app/app_webview/Default/Local Storage/
```

---

## 🔐 Sicurezza

- Dati salvati localmente
- Nessun server esterno
- PIN salvato in localStorage (non crittografato)
- Comunicazione con CDN esterni (React/Babel)

**Suggerimento:** Per maggiore sicurezza:
1. Scarica React/Babel localmente
2. Mettili in `www/js/`
3. Rimuovi CDN da index.html

---

## 📈 Ottimizzazioni Future

### Performance
- [ ] Implementa Service Worker per offline
- [ ] Carica React/Babel localmente
- [ ] Comprimi immagini prima del salvataggio
- [ ] Lazy loading delle note

### Feature
- [ ] Backup automatico su cloud
- [ ] Sincronizzazione multi-dispositivo
- [ ] Export PDF delle note
- [ ] Widget Android
- [ ] Notifiche push per promemoria

### UX
- [ ] Dark mode automatico
- [ ] Gesture per navigazione
- [ ] Ricerca avanzata con filtri
- [ ] Tag personalizzati

---

**🎉 Ora conosci tutta la struttura del progetto!**

Per domande: vedi README.md e TROUBLESHOOTING.md
