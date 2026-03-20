# CLAUDE.md — Le Mie Note

## Regola versione (OBBLIGATORIA)
**Ad ogni modifica al codice dell'app**, devi sempre fare il bump del patch version:
1. `config.xml` — cambia `version="X.Y.Z"` nella prima riga `<widget ...>`
2. `www/index.html` — cerca `versione X.Y.Z` nel footer della guida e aggiornalo

Esempio: `1.2.0 → 1.2.1`, poi `1.2.1 → 1.2.2`, ecc.
La versione in `config.xml` è la fonte della verità; l'APK prodotto da `build-auto.bat` la legge automaticamente e la include nel nome del file.

## File principali
| File | Ruolo |
|------|-------|
| `www/index.html` | Tutta l'app (React CDN, CSS inline, JS) — **unico file da modificare per la UI** |
| `config.xml` | Versione app, permessi Cordova, configurazione plugin |
| `build-auto.bat` | Script build APK Windows |
| `platforms/android/` | Codice Android generato da Cordova — **non modificare direttamente** |

## Architettura
- App Cordova ibrida: HTML/JS in `www/`, layer nativo Android in `platforms/android/`
- React 18 via CDN (unpkg), Babel standalone per JSX
- Dati salvati in `localStorage` (nessun backend)
- Immagini e allegati salvati come base64 data URI
- Plugin camera Cordova (`cordova-plugin-camera`) per foto native
- Plugin file Cordova (`cordova-plugin-file`) per file system

## Stato corrente (v1.2.0)
- ✅ Foto: scatta + galleria + viewer a schermo intero (lightbox)
- ✅ Allegati file (PDF, Word, Excel, ecc.) — salvati come base64
- ✅ Promemoria nativi con suoneria
- ✅ Calendario, ricerca, categorie, temi, PIN
- ✅ build-auto.bat produce `LeMieNote-vX.Y.Z.apk`

## Build APK — OBBLIGATORIO dopo ogni modifica
**Dopo ogni modifica al codice, devi sempre compilare e consegnare l'APK.**
Esegui la build direttamente con Gradle (platforms/android già configurato):
```
cd "C:\APPLICAZIONI CLAUDE\NotesApp\NotesApp-FINALE\platforms\android"
gradlew assembleRelease   (oppure assembleDebug se release fallisce)
```
Poi copia l'APK prodotto nella cartella root come `LeMieNote-vX.Y.Z.apk`.
Percorso APK release: `platforms\android\app\build\outputs\apk\release\app-release.apk`
Percorso APK debug:   `platforms\android\app\build\outputs\apk\debug\app-debug.apk`
