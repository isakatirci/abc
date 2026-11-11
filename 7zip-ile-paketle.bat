@echo off
setlocal

echo ============================================================================
echo   PEAZIP / 7-ZIP ULTRA (SON RADDE - LZMA2) SIKISTIRMA ARACI
echo   (Cursor + VS Code GitHub Copilot Default Skills ^& MCP Paketi)
echo ============================================================================
echo.

set "SEVENZIP="
if exist "C:\Program Files\PeaZip\res\bin\7z\7z.exe" set "SEVENZIP=C:\Program Files\PeaZip\res\bin\7z\7z.exe"
if not defined SEVENZIP if exist "C:\Program Files\PeaZip\res\7z\7z.exe" set "SEVENZIP=C:\Program Files\PeaZip\res\7z\7z.exe"
if not defined SEVENZIP if exist "C:\Program Files (x86)\PeaZip\res\bin\7z\7z.exe" set "SEVENZIP=C:\Program Files (x86)\PeaZip\res\bin\7z\7z.exe"
if not defined SEVENZIP if exist "C:\Program Files (x86)\PeaZip\res\7z\7z.exe" set "SEVENZIP=C:\Program Files (x86)\PeaZip\res\7z\7z.exe"
if not defined SEVENZIP if exist "%LOCALAPPDATA%\Programs\PeaZip\res\bin\7z\7z.exe" set "SEVENZIP=%LOCALAPPDATA%\Programs\PeaZip\res\bin\7z\7z.exe"
if not defined SEVENZIP if exist "%LOCALAPPDATA%\PeaZip\res\bin\7z\7z.exe" set "SEVENZIP=%LOCALAPPDATA%\PeaZip\res\bin\7z.exe"
if not defined SEVENZIP if exist "C:\Program Files\7-Zip\7z.exe" set "SEVENZIP=C:\Program Files\7-Zip\7z.exe"
if not defined SEVENZIP if exist "C:\Program Files (x86)\7-Zip\7z.exe" set "SEVENZIP=C:\Program Files (x86)\7-Zip\7z.exe"

if not defined SEVENZIP goto NO_7Z

set "OUT_ARCHIVE=%~dp0cursor-default-skills-paket.7z"
if exist "%OUT_ARCHIVE%" del /F /Q "%OUT_ARCHIVE%"

echo Kullanilan Motor : "%SEVENZIP%"
echo Cikti Dosyasi    : "%OUT_ARCHIVE%"
echo Parametreler     : -t7z -mx=9 (Ultra) -m0=lzma2 -md=128m -mfb=273 -ms=on (Solid)
echo.

"%SEVENZIP%" a -t7z -mx=9 -m0=lzma2 -md=128m -mfb=273 -ms=on "%OUT_ARCHIVE%" "%USERPROFILE%\.cursor\skills" "%USERPROFILE%\.cursor\mcp.json" "%~dp0vscode-mcp.json" "%~dp0cursor-kurulum.bat" "%~dp0cursor-skill-rehberi.html"

if errorlevel 1 goto ERR_7Z

echo.
echo ============================================================================
echo   [TAMAMLANDI] Paket basariyla olusturuldu:
echo   %OUT_ARCHIVE%
echo ============================================================================
echo.
pause
exit /b 0

:NO_7Z
echo [HATA] PeaZip veya 7-Zip icindeki 7z.exe bulunamadi!
pause
exit /b 1

:ERR_7Z
echo [HATA] Sikistirma sirasinda hata olustu!
pause
exit /b 1
