# 🚀 GUIDA RAPIDA - 5 MINUTI

## Hai già tutto installato? Inizia qui!

### 1️⃣ Apri il Terminale

**Windows:** Cerca "cmd" o "PowerShell"  
**Mac:** Cerca "Terminal"  
**Linux:** Ctrl+Alt+T

### 2️⃣ Vai nella cartella del progetto

```bash
cd /percorso/dove/hai/estratto/NotesApp
```

### 3️⃣ Compila

**Windows:**
```cmd
build.bat
```

**Mac/Linux:**
```bash
./build.sh
```

### 4️⃣ Installa

**Con telefono connesso USB:**
```bash
cordova run android
```

**Senza cavo:**
1. Prendi l'APK da: `platforms/android/app/build/outputs/apk/debug/app-debug.apk`
2. Copialo sul telefono
3. Installalo

---

## ❓ Non hai installato niente?

Segui il **README.md** completo per:
- Installare Node.js
- Installare Java JDK 17
- Installare Android Studio
- Configurare tutto

Tempo necessario: 30-60 minuti (solo la prima volta!)

---

## 🆘 Problemi?

### Errore "cordova not found"
```bash
npm install -g cordova
```

### Errore "ANDROID_HOME"
Devi configurare Android SDK. Vedi README.md sezione "Variabili d'Ambiente"

### Errore "License not accepted"
```bash
# Windows
cd %ANDROID_HOME%\cmdline-tools\latest\bin
sdkmanager --licenses

# Mac/Linux
cd $ANDROID_HOME/cmdline-tools/latest/bin
./sdkmanager --licenses
```

Poi premi 'y' per tutte le licenze.

---

## ✅ Tutto Funziona?

Congratulazioni! Ora hai:
- 📱 App Android funzionante
- 💾 Salvataggio automatico dati
- 🖼️ Supporto immagini multiple
- 📅 Calendario integrato
- 🎨 5 temi di colore
- 🌓 Modalità chiaro/scuro

**Divertiti con Le Mie Note! 🎉**
