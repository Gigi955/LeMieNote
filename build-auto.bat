@echo off
setlocal enabledelayedexpansion

REM ============================================
REM   SETUP COMPLETO E BUILD - Le Mie Note
REM   Crea il progetto da zero e compila l'APK
REM ============================================

echo.
echo ========================================
echo   SETUP E BUILD AUTOMATICO
echo   Le Mie Note - Android App
echo ========================================
echo.

REM Salva la directory corrente (dove sono i file sorgente)
set SOURCE_DIR=%cd%

REM Step 1: Verifica Cordova
echo [1/10] Verifica Cordova...
where cordova >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Cordova non installato!
    echo.
    echo Installazione automatica di Cordova...
    call npm install -g cordova
    if %ERRORLEVEL% NEQ 0 (
        echo [ERRORE] Impossibile installare Cordova!
        echo Prova manualmente: npm install -g cordova
        pause
        exit /b 1
    )
)
echo [OK] Cordova installato
cordova --version
echo.

REM Step 2: Verifica Android SDK
echo [2/10] Verifica Android SDK...
if "%ANDROID_HOME%"=="" (
    echo [ERRORE] ANDROID_HOME non configurato!
    echo.
    echo DEVI configurare Android SDK:
    echo 1. Apri Android Studio
    echo 2. SDK Manager ^> Installa Android SDK
    echo 3. Aggiungi variabile d'ambiente ANDROID_HOME
    echo.
    echo Vedi README.md per istruzioni dettagliate
    echo.
    pause
    exit /b 1
)
echo [OK] Android SDK: %ANDROID_HOME%
echo.

REM Step 3: Verifica Java
echo [3/10] Verifica Java...
java -version 2>&1 | findstr /i "version" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Java non trovato!
    echo.
    echo Installa Java 17 da: https://adoptium.net/
    echo.
    pause
    exit /b 1
)
echo [OK] Java installato
echo.

REM Step 4: Verifica file sorgenti necessari
echo [4/10] Verifica file sorgenti...
if not exist "www\index.html" (
    echo [ERRORE] File www\index.html non trovato!
    echo.
    echo Assicurati di essere nella cartella NotesApp-FINALE
    echo che contiene la cartella www\
    echo.
    pause
    exit /b 1
)
if not exist "config.xml" (
    echo [ERRORE] File config.xml non trovato!
    pause
    exit /b 1
)
echo [OK] File sorgenti presenti
echo.

REM Step 5: Crea progetto Cordova
echo [5/10] Creazione progetto Cordova...
if exist "LeMieNote" (
    echo [WARN] Cartella LeMieNote già esiste!
    set /p OVERWRITE="Vuoi sovrascriverla? (S/N): "
    if /i "!OVERWRITE!"=="S" (
        echo Rimozione vecchia cartella...
        rmdir /s /q "LeMieNote"
    ) else (
        echo [SKIP] Utilizzo cartella esistente
        goto :skip_create
    )
)

echo Creazione nuovo progetto...
call cordova create LeMieNote com.lemienote.app "Le Mie Note"
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Impossibile creare progetto!
    pause
    exit /b 1
)
echo [OK] Progetto creato

:skip_create
echo.

REM Step 6: Copia file sorgenti nel progetto
echo [6/10] Copia file nel progetto...
echo Copia index.html...
copy /Y "www\index.html" "LeMieNote\www\index.html" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Impossibile copiare index.html!
    pause
    exit /b 1
)

echo Copia config.xml...
copy /Y "config.xml" "LeMieNote\config.xml" >nul

echo Copia package.json...
if exist "package.json" (
    copy /Y "package.json" "LeMieNote\package.json" >nul
)

echo [OK] File copiati
echo.

REM Entra nella cartella del progetto
cd LeMieNote

REM Step 7: Installa dipendenze npm
echo [7/10] Installazione dipendenze...
if exist "package.json" (
    echo Installazione npm packages...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo [WARN] Alcune dipendenze potrebbero non essere installate
    )
) else (
    echo [SKIP] Nessun package.json trovato
)
echo.

REM Step 8: Aggiungi piattaforma Android
echo [8/10] Aggiunta piattaforma Android...
call cordova platform add android
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Impossibile aggiungere piattaforma Android!
    echo.
    echo Controlla che Android SDK sia installato correttamente.
    pause
    exit /b 1
)
echo [OK] Piattaforma Android aggiunta
echo.

REM Step 9: Accetta licenze Android
echo [9/10] Verifica licenze Android...
echo Potrebbe essere richiesto di accettare le licenze...
if exist "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" (
    call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" --licenses
) else (
    echo [WARN] sdkmanager non trovato, le licenze potrebbero causare problemi
)
echo.

REM Step 10: Compilazione APK
echo [10/10] Compilazione APK...
echo.
echo ========================================
echo   COMPILAZIONE IN CORSO
echo   Questo richiede 5-15 minuti...
echo ========================================
echo.

call cordova build android

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   BUILD COMPLETATO CON SUCCESSO!
    echo ========================================
    echo.
    
    set APK_PATH=platforms\android\app\build\outputs\apk\debug\app-debug.apk
    
    if exist "!APK_PATH!" (
        echo [OK] APK generato con successo!
        echo.
        echo Percorso completo:
        echo %cd%\!APK_PATH!
        echo.
        
        REM Mostra dimensione
        for %%A in ("!APK_PATH!") do (
            set SIZE=%%~zA
            set /a SIZE_MB=!SIZE! / 1024 / 1024
            echo Dimensione: !SIZE_MB! MB
        )
        echo.
        
        REM Torna alla directory sorgente
        cd "%SOURCE_DIR%"
        
        REM Leggi versione da config.xml
        set APP_VER=
        for /f "tokens=*" %%V in ('powershell -command "(Select-String -Path \"%SOURCE_DIR%\config.xml\" -Pattern 'version=""([0-9.]+)""').Matches[0].Groups[1].Value" 2^>nul') do set APP_VER=%%V
        if "!APP_VER!"=="" set APP_VER=release

        REM Copia APK nella cartella principale per comodità
        copy "LeMieNote\!APK_PATH!" "app-debug.apk" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] APK copiato anche qui: %SOURCE_DIR%\app-debug.apk
            echo.
        )

        REM Copia APK con versione nel nome
        set APK_VERSIONED=LeMieNote-v!APP_VER!.apk
        copy "LeMieNote\!APK_PATH!" "%SOURCE_DIR%\!APK_VERSIONED!" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] APK con versione creato: %SOURCE_DIR%\!APK_VERSIONED!
            echo.
        )
        
        REM Chiedi installazione
        set /p INSTALL="Vuoi installare l'APK sul dispositivo? (S/N): "
        if /i "!INSTALL!"=="S" (
            echo.
            echo Verifica dispositivi connessi...
            adb devices
            echo.
            echo Installazione in corso...
            cd LeMieNote
            call cordova run android
            if !ERRORLEVEL! EQU 0 (
                echo.
                echo [OK] App installata con successo!
            ) else (
                echo.
                echo [WARN] Installazione automatica fallita
                echo.
                echo Installa manualmente:
                echo 1. Copia app-debug.apk sul telefono
                echo 2. Tocca il file per installare
            )
            cd "%SOURCE_DIR%"
        ) else (
            echo.
            echo Per installare manualmente:
            echo 1. Trova il file: app-debug.apk
            echo 2. Copialo sul telefono
            echo 3. Tocca il file APK per installare
            echo.
            echo Oppure via USB:
            echo    cd LeMieNote
            echo    cordova run android
        )
        
        echo.
        echo ========================================
        echo   OPERAZIONE COMPLETATA!
        echo ========================================
        echo.
        
        REM Apri cartella
        set /p OPEN="Vuoi aprire la cartella con l'APK? (S/N): "
        if /i "!OPEN!"=="S" (
            explorer /select,"%SOURCE_DIR%\app-debug.apk"
        )
        
    ) else (
        echo [ERRORE] APK non trovato nel percorso atteso!
    )
    
) else (
    echo.
    echo ========================================
    echo   ERRORE DURANTE LA COMPILAZIONE
    echo ========================================
    echo.
    echo Controlla i messaggi di errore sopra.
    echo.
    echo SOLUZIONI COMUNI:
    echo.
    echo 1. Verifica Java 17:
    echo    java -version
    echo.
    echo 2. Accetta licenze Android:
    echo    %%ANDROID_HOME%%\cmdline-tools\latest\bin\sdkmanager --licenses
    echo.
    echo 3. Verifica ANDROID_HOME configurato:
    echo    echo %%ANDROID_HOME%%
    echo.
    echo 4. Installa Android SDK Build-Tools in Android Studio
    echo.
    echo 5. Prova pulizia:
    echo    cd LeMieNote
    echo    cordova clean
    echo    cordova build android
    echo.
    
    cd "%SOURCE_DIR%"
)

echo.
pause
