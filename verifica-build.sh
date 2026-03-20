#!/bin/bash

# Script di Verifica Build Android - Le Mie Note
# Verifica che tutti i file siano corretti prima di compilare

echo "========================================"
echo "  VERIFICA BUILD - Le Mie Note"
echo "========================================"
echo ""

ERRORS=0

# Funzione per stampare OK o ERROR
check_ok() {
    echo "✅ $1"
}

check_error() {
    echo "❌ $1"
    ERRORS=$((ERRORS + 1))
}

# 1. Verifica index.html esiste
echo "1. Verifica index.html..."
if [ -f "app/src/main/assets/www/index.html" ]; then
    check_ok "index.html trovato"
    
    # Verifica contenuto
    if grep -q "document.body.appendChild(input)" app/src/main/assets/www/index.html; then
        check_ok "Correzione foto presente"
    else
        check_error "Correzione foto MANCANTE!"
    fi
    
    if grep -q "const newDate = new Date(day.date.getTime())" app/src/main/assets/www/index.html; then
        check_ok "Correzione calendario presente"
    else
        check_error "Correzione calendario MANCANTE!"
    fi
    
    if grep -q "data:application/json;charset=utf-8" app/src/main/assets/www/index.html; then
        check_ok "Correzione export presente"
    else
        check_error "Correzione export MANCANTE!"
    fi
    
    if grep -q "localStorage.getItem('notesAppPin')" app/src/main/assets/www/index.html; then
        check_ok "Correzione PIN presente"
    else
        check_error "Correzione PIN MANCANTE!"
    fi
else
    check_error "index.html NON TROVATO in app/src/main/assets/www/"
fi

echo ""

# 2. Verifica MainActivity.java
echo "2. Verifica MainActivity.java..."
if [ -f "app/src/main/java/com/lemienote/app/MainActivity.java" ]; then
    check_ok "MainActivity.java trovato"
    
    if grep -q "requestPermissions()" app/src/main/java/com/lemienote/app/MainActivity.java; then
        check_ok "Richiesta permessi presente"
    else
        check_error "Richiesta permessi MANCANTE!"
    fi
    
    if grep -q "setDomStorageEnabled(true)" app/src/main/java/com/lemienote/app/MainActivity.java; then
        check_ok "DOM Storage abilitato"
    else
        check_error "DOM Storage NON abilitato!"
    fi
    
    if grep -q "WebChromeClient" app/src/main/java/com/lemienote/app/MainActivity.java; then
        check_ok "WebChromeClient presente"
    else
        check_error "WebChromeClient MANCANTE!"
    fi
else
    check_error "MainActivity.java NON TROVATO!"
fi

echo ""

# 3. Verifica AndroidManifest.xml
echo "3. Verifica AndroidManifest.xml..."
if [ -f "app/src/main/AndroidManifest.xml" ]; then
    check_ok "AndroidManifest.xml trovato"
    
    if grep -q "RECORD_AUDIO" app/src/main/AndroidManifest.xml; then
        check_ok "Permesso microfono presente"
    else
        check_error "Permesso microfono MANCANTE!"
    fi
    
    if grep -q "CAMERA" app/src/main/AndroidManifest.xml; then
        check_ok "Permesso fotocamera presente"
    else
        check_error "Permesso fotocamera MANCANTE!"
    fi
    
    if grep -q "WRITE_EXTERNAL_STORAGE" app/src/main/AndroidManifest.xml; then
        check_ok "Permesso storage presente"
    else
        check_error "Permesso storage MANCANTE!"
    fi
else
    check_error "AndroidManifest.xml NON TROVATO!"
fi

echo ""
echo "========================================"

if [ $ERRORS -eq 0 ]; then
    echo "✅ ✅ ✅  TUTTO OK!  ✅ ✅ ✅"
    echo ""
    echo "Puoi procedere con:"
    echo "  Build → Clean Project"
    echo "  Build → Build APK"
    echo ""
else
    echo "❌ TROVATI $ERRORS ERRORI!"
    echo ""
    echo "AZIONI DA FARE:"
    echo "1. Controlla i file segnati con ❌"
    echo "2. Sostituisci con i file corretti"
    echo "3. Riesegui questo script"
    echo ""
fi

echo "========================================"
