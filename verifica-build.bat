@echo off
REM Script di Verifica Build Android - Le Mie Note
REM Verifica che tutti i file siano corretti prima di compilare

echo ========================================
echo   VERIFICA BUILD - Le Mie Note
echo ========================================
echo.

set ERRORS=0

REM 1. Verifica index.html
echo 1. Verifica index.html...
if exist "app\src\main\assets\www\index.html" (
    echo [OK] index.html trovato
    
    findstr /C:"document.body.appendChild(input)" "app\src\main\assets\www\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Correzione foto presente
    ) else (
        echo [ERROR] Correzione foto MANCANTE!
        set /a ERRORS+=1
    )
    
    findstr /C:"const newDate = new Date(day.date.getTime())" "app\src\main\assets\www\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Correzione calendario presente
    ) else (
        echo [ERROR] Correzione calendario MANCANTE!
        set /a ERRORS+=1
    )
    
    findstr /C:"data:application/json;charset=utf-8" "app\src\main\assets\www\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Correzione export presente
    ) else (
        echo [ERROR] Correzione export MANCANTE!
        set /a ERRORS+=1
    )
) else (
    echo [ERROR] index.html NON TROVATO!
    set /a ERRORS+=1
)

echo.

REM 2. Verifica MainActivity.java
echo 2. Verifica MainActivity.java...
if exist "app\src\main\java\com\lemienote\app\MainActivity.java" (
    echo [OK] MainActivity.java trovato
    
    findstr /C:"requestPermissions()" "app\src\main\java\com\lemienote\app\MainActivity.java" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Richiesta permessi presente
    ) else (
        echo [ERROR] Richiesta permessi MANCANTE!
        set /a ERRORS+=1
    )
    
    findstr /C:"setDomStorageEnabled(true)" "app\src\main\java\com\lemienote\app\MainActivity.java" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] DOM Storage abilitato
    ) else (
        echo [ERROR] DOM Storage NON abilitato!
        set /a ERRORS+=1
    )
) else (
    echo [ERROR] MainActivity.java NON TROVATO!
    set /a ERRORS+=1
)

echo.

REM 3. Verifica AndroidManifest.xml
echo 3. Verifica AndroidManifest.xml...
if exist "app\src\main\AndroidManifest.xml" (
    echo [OK] AndroidManifest.xml trovato
    
    findstr /C:"RECORD_AUDIO" "app\src\main\AndroidManifest.xml" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Permesso microfono presente
    ) else (
        echo [ERROR] Permesso microfono MANCANTE!
        set /a ERRORS+=1
    )
    
    findstr /C:"CAMERA" "app\src\main\AndroidManifest.xml" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Permesso fotocamera presente
    ) else (
        echo [ERROR] Permesso fotocamera MANCANTE!
        set /a ERRORS+=1
    )
) else (
    echo [ERROR] AndroidManifest.xml NON TROVATO!
    set /a ERRORS+=1
)

echo.
echo ========================================

if %ERRORS% EQU 0 (
    echo [OK] [OK] [OK]  TUTTO OK!  [OK] [OK] [OK]
    echo.
    echo Puoi procedere con:
    echo   Build -^> Clean Project
    echo   Build -^> Build APK
    echo.
) else (
    echo [ERROR] TROVATI %ERRORS% ERRORI!
    echo.
    echo AZIONI DA FARE:
    echo 1. Controlla i file segnati con [ERROR]
    echo 2. Sostituisci con i file corretti
    echo 3. Riesegui questo script
    echo.
)

echo ========================================
pause
