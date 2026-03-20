# 🔧 GUIDA ESECUZIONE SCRIPT - Windows PowerShell

## ⚠️ HAI USATO POWERSHELL!

Se vedi questo errore:
```
Termine 'build-auto.bat' non riconosciuto come nome di cmdlet
```

**Causa:** Stai usando PowerShell invece di CMD.

---

## ✅ SOLUZIONE RAPIDA

### Metodo 1: Aggiungi .\ davanti al comando

**In PowerShell:**
```powershell
.\build-auto.bat
```

**NON:**
```powershell
build-auto.bat  ❌
```

---

### Metodo 2: Usa CMD invece di PowerShell (CONSIGLIATO)

**Apri Prompt dei Comandi:**

1. **Premi Win+R**
2. **Digita:** `cmd`
3. **Invio**

**Naviga alla cartella:**
```cmd
cd C:\NotesApp\files\NotesApp-FINALE
```

**Esegui:**
```cmd
build-auto.bat
```

✅ **Funziona senza .\**

---

### Metodo 3: Doppio Click (PIÙ SEMPLICE!)

1. **Apri Esplora File**
2. **Vai in:** `C:\NotesApp\files\NotesApp-FINALE`
3. **Doppio click su:** `build-auto.bat`

✅ **Si apre automaticamente in CMD e funziona!**

---

## 🎯 COMANDI CORRETTI PER POWERSHELL

Se vuoi continuare a usare PowerShell:

### Build automatico:
```powershell
.\build-auto.bat
```

### Verifica file:
```powershell
.\verifica-build.bat
```

### Tutti gli script .bat in PowerShell:
```powershell
.\nome-script.bat
```

---

## 💡 PERCHÉ SUCCEDE?

**CMD (Prompt dei Comandi):**
- Cerca comandi nella cartella corrente automaticamente
- Puoi digitare: `build-auto.bat` ✅

**PowerShell:**
- NON cerca nella cartella corrente per sicurezza
- Devi specificare: `.\build-auto.bat` ✅

---

## 🚀 COMANDO COMPLETO PER POWERSHELL

Copia e incolla nel tuo PowerShell:

```powershell
# Vai alla cartella (adatta il percorso)
cd C:\NotesApp\files\NotesApp-FINALE

# Esegui script
.\build-auto.bat
```

---

## ✅ VERIFICA DI ESSERE NELLA CARTELLA GIUSTA

```powershell
# Controlla dove sei
pwd

# Deve mostrare: C:\NotesApp\files\NotesApp-FINALE

# Lista file
dir

# Deve mostrare build-auto.bat
```

---

## 🎉 ORA PROVA!

**In PowerShell:**
```powershell
.\build-auto.bat
```

**O meglio: Doppio click sul file in Esplora File!**

---

## 📋 RIEPILOGO COMANDI

| Cosa vuoi fare | CMD | PowerShell | Doppio Click |
|----------------|-----|------------|--------------|
| Build automatico | `build-auto.bat` | `.\build-auto.bat` | ✅ Funziona |
| Verifica file | `verifica-build.bat` | `.\verifica-build.bat` | ✅ Funziona |
| Qualsiasi .bat | `nome.bat` | `.\nome.bat` | ✅ Funziona |

---

**CONSIGLIO: Usa il Doppio Click, è il più semplice! 🖱️**
