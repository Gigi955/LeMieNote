#!/bin/bash

# ============================================
#   SETUP COMPLETO E BUILD - Le Mie Note
#   Crea il progetto da zero e compila l'APK
# ============================================

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funzioni
error() {
    echo -e "${RED}[ERRORE]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

echo ""
echo "========================================"
echo "  SETUP E BUILD AUTOMATICO"
echo "  Le Mie Note - Android App"
echo "========================================"
echo ""

# Salva directory corrente
SOURCE_DIR=$(pwd)

# Step 1: Verifica Cordova
echo "[1/10] Verifica Cordova..."
if ! command -v cordova &> /dev/null; then
    error "Cordova non installato!"
    echo ""
    echo "Installazione automatica di Cordova..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac
        sudo npm install -g cordova
    else
        # Linux
        sudo npm install -g cordova
    fi
    
    if [ $? -ne 0 ]; then
        error "Impossibile installare Cordova!"
        echo "Prova manualmente: sudo npm install -g cordova"
        exit 1
    fi
fi
success "Cordova installato: $(cordova --version)"
echo ""

# Step 2: Verifica Android SDK
echo "[2/10] Verifica Android SDK..."
if [ -z "$ANDROID_HOME" ]; then
    error "ANDROID_HOME non configurato!"
    echo ""
    echo "DEVI configurare Android SDK:"
    echo "1. Apri Android Studio"
    echo "2. SDK Manager → Installa Android SDK"
    echo "3. Aggiungi al tuo ~/.bashrc o ~/.zshrc:"
    echo ""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  export ANDROID_HOME=\$HOME/Library/Android/sdk"
    else
        echo "  export ANDROID_HOME=\$HOME/Android/Sdk"
    fi
    echo "  export PATH=\$PATH:\$ANDROID_HOME/platform-tools"
    echo ""
    echo "Poi riavvia il terminale"
    echo ""
    exit 1
fi
success "Android SDK: $ANDROID_HOME"
echo ""

# Step 3: Verifica Java
echo "[3/10] Verifica Java..."
if ! command -v java &> /dev/null; then
    error "Java non trovato!"
    echo ""
    echo "Installa Java 17 da: https://adoptium.net/"
    echo ""
    exit 1
fi
success "Java installato: $(java -version 2>&1 | head -n 1)"
echo ""

# Step 4: Verifica file sorgenti
echo "[4/10] Verifica file sorgenti..."
if [ ! -f "www/index.html" ]; then
    error "File www/index.html non trovato!"
    echo ""
    echo "Assicurati di essere nella cartella NotesApp-FINALE"
    echo "che contiene la cartella www/"
    echo ""
    exit 1
fi
if [ ! -f "config.xml" ]; then
    error "File config.xml non trovato!"
    exit 1
fi
success "File sorgenti presenti"
echo ""

# Step 5: Crea progetto Cordova
echo "[5/10] Creazione progetto Cordova..."
if [ -d "LeMieNote" ]; then
    warn "Cartella LeMieNote già esiste!"
    read -p "Vuoi sovrascriverla? (S/N): " OVERWRITE
    if [ "$OVERWRITE" = "S" ] || [ "$OVERWRITE" = "s" ]; then
        echo "Rimozione vecchia cartella..."
        rm -rf LeMieNote
    else
        echo "[SKIP] Utilizzo cartella esistente"
        skip_create=true
    fi
fi

if [ "$skip_create" != "true" ]; then
    echo "Creazione nuovo progetto..."
    cordova create LeMieNote com.lemienote.app "Le Mie Note"
    if [ $? -ne 0 ]; then
        error "Impossibile creare progetto!"
        exit 1
    fi
    success "Progetto creato"
fi
echo ""

# Step 6: Copia file nel progetto
echo "[6/10] Copia file nel progetto..."
echo "Copia index.html..."
cp "www/index.html" "LeMieNote/www/index.html"
if [ $? -ne 0 ]; then
    error "Impossibile copiare index.html!"
    exit 1
fi

echo "Copia config.xml..."
cp "config.xml" "LeMieNote/config.xml"

if [ -f "package.json" ]; then
    echo "Copia package.json..."
    cp "package.json" "LeMieNote/package.json"
fi

success "File copiati"
echo ""

# Entra nella cartella progetto
cd LeMieNote

# Step 7: Installa dipendenze npm
echo "[7/10] Installazione dipendenze..."
if [ -f "package.json" ]; then
    echo "Installazione npm packages..."
    npm install
    if [ $? -ne 0 ]; then
        warn "Alcune dipendenze potrebbero non essere installate"
    fi
else
    echo "[SKIP] Nessun package.json trovato"
fi
echo ""

# Step 8: Aggiungi piattaforma Android
echo "[8/10] Aggiunta piattaforma Android..."
cordova platform add android
if [ $? -ne 0 ]; then
    error "Impossibile aggiungere piattaforma Android!"
    echo ""
    echo "Controlla che Android SDK sia installato correttamente."
    exit 1
fi
success "Piattaforma Android aggiunta"
echo ""

# Step 9: Accetta licenze Android
echo "[9/10] Verifica licenze Android..."
echo "Potrebbe essere richiesto di accettare le licenze..."
if [ -f "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
    "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --licenses
else
    warn "sdkmanager non trovato, le licenze potrebbero causare problemi"
fi
echo ""

# Step 10: Compilazione APK
echo "[10/10] Compilazione APK..."
echo ""
echo "========================================"
echo "  COMPILAZIONE IN CORSO"
echo "  Questo richiede 5-15 minuti..."
echo "========================================"
echo ""

cordova build android

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "  ✅ BUILD COMPLETATO CON SUCCESSO! ✅"
    echo "========================================"
    echo ""
    
    APK_PATH="platforms/android/app/build/outputs/apk/debug/app-debug.apk"
    
    if [ -f "$APK_PATH" ]; then
        success "APK generato con successo!"
        echo ""
        echo "📱 Percorso completo:"
        echo "   $(pwd)/$APK_PATH"
        echo ""
        
        # Mostra dimensione
        SIZE=$(du -h "$APK_PATH" | cut -f1)
        echo "📦 Dimensione: $SIZE"
        echo ""
        
        # Torna alla directory sorgente
        cd "$SOURCE_DIR"
        
        # Copia APK nella cartella principale
        cp "LeMieNote/$APK_PATH" "app-debug.apk"
        if [ $? -eq 0 ]; then
            success "APK copiato anche qui: $SOURCE_DIR/app-debug.apk"
            echo ""
        fi
        
        # Chiedi installazione
        read -p "Vuoi installare l'APK sul dispositivo? (S/N): " INSTALL
        if [ "$INSTALL" = "S" ] || [ "$INSTALL" = "s" ]; then
            echo ""
            echo "Verifica dispositivi connessi..."
            adb devices
            echo ""
            echo "Installazione in corso..."
            cd LeMieNote
            cordova run android
            if [ $? -eq 0 ]; then
                echo ""
                success "App installata con successo!"
            else
                echo ""
                warn "Installazione automatica fallita"
                echo ""
                echo "Installa manualmente:"
                echo "1. Copia app-debug.apk sul telefono"
                echo "2. Tocca il file per installare"
            fi
            cd "$SOURCE_DIR"
        else
            echo ""
            echo "Per installare manualmente:"
            echo "1. Trova il file: app-debug.apk"
            echo "2. Copialo sul telefono"
            echo "3. Tocca il file APK per installare"
            echo ""
            echo "Oppure via USB:"
            echo "   cd LeMieNote"
            echo "   cordova run android"
        fi
        
        echo ""
        echo "========================================"
        echo "  ✅ OPERAZIONE COMPLETATA! ✅"
        echo "========================================"
        echo ""
        
        # Apri cartella (solo Mac)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            read -p "Vuoi aprire la cartella con l'APK? (S/N): " OPEN
            if [ "$OPEN" = "S" ] || [ "$OPEN" = "s" ]; then
                open "$SOURCE_DIR"
            fi
        fi
        
    else
        error "APK non trovato nel percorso atteso!"
    fi
    
else
    echo ""
    echo "========================================"
    echo "  ❌ ERRORE DURANTE LA COMPILAZIONE"
    echo "========================================"
    echo ""
    echo "Controlla i messaggi di errore sopra."
    echo ""
    echo "SOLUZIONI COMUNI:"
    echo ""
    echo "1. Verifica Java 17:"
    echo "   java -version"
    echo ""
    echo "2. Accetta licenze Android:"
    echo "   \$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses"
    echo ""
    echo "3. Verifica ANDROID_HOME configurato:"
    echo "   echo \$ANDROID_HOME"
    echo ""
    echo "4. Installa Android SDK Build-Tools in Android Studio"
    echo ""
    echo "5. Prova pulizia:"
    echo "   cd LeMieNote"
    echo "   cordova clean"
    echo "   cordova build android"
    echo ""
    
    cd "$SOURCE_DIR"
    exit 1
fi
