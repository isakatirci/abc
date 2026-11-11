@echo off
setlocal

echo ============================================================================
echo   CURSOR + VS CODE GITHUB COPILOT (578 Skill + 5 MCP) KURULUM ARACI
echo ============================================================================
echo.

set "SRC_DIR=%~dp0"
set "TARGET_CURSOR=%USERPROFILE%\.cursor"
set "TARGET_CURSOR_SKILLS=%TARGET_CURSOR%\skills"
set "TARGET_COPILOT=%USERPROFILE%\.copilot"
set "TARGET_COPILOT_SKILLS=%TARGET_COPILOT%\skills"
set "TARGET_AGENTS_SKILLS=%USERPROFILE%\.agents\skills"
set "TARGET_VSCODE_USER=%APPDATA%\Code\User"

if not exist "%SRC_DIR%skills" goto NO_SKILLS

echo [1/4] Cursor icin 578 Skill kuruluyor...
echo       Hedef: "%TARGET_CURSOR_SKILLS%"
if not exist "%TARGET_CURSOR%" mkdir "%TARGET_CURSOR%"
if not exist "%TARGET_CURSOR_SKILLS%" mkdir "%TARGET_CURSOR_SKILLS%"
robocopy "%SRC_DIR%skills" "%TARGET_CURSOR_SKILLS%" /E /MT:8 /R:1 /W:1 /NFL /NDL /NJH /NJS >nul
if errorlevel 8 goto COPY_ERR

echo [2/4] VS Code GitHub Copilot icin 578 Skill kuruluyor...
echo       Hedef 1: "%TARGET_COPILOT_SKILLS%"
echo       Hedef 2: "%TARGET_AGENTS_SKILLS%"
if not exist "%TARGET_COPILOT%" mkdir "%TARGET_COPILOT%"
if not exist "%TARGET_COPILOT_SKILLS%" mkdir "%TARGET_COPILOT_SKILLS%"
robocopy "%SRC_DIR%skills" "%TARGET_COPILOT_SKILLS%" /E /MT:8 /R:1 /W:1 /NFL /NDL /NJH /NJS >nul
if errorlevel 8 goto COPY_ERR

if not exist "%USERPROFILE%\.agents" mkdir "%USERPROFILE%\.agents"
if not exist "%TARGET_AGENTS_SKILLS%" mkdir "%TARGET_AGENTS_SKILLS%"
robocopy "%SRC_DIR%skills" "%TARGET_AGENTS_SKILLS%" /E /MT:8 /R:1 /W:1 /NFL /NDL /NJH /NJS >nul
if errorlevel 8 goto COPY_ERR

echo [3/4] Cursor MCP yapilandirmasi (mcp.json) kuruluyor...
if exist "%TARGET_CURSOR%\mcp.json" copy /Y "%TARGET_CURSOR%\mcp.json" "%TARGET_CURSOR%\mcp.json.bak" >nul
if exist "%SRC_DIR%mcp.json" copy /Y "%SRC_DIR%mcp.json" "%TARGET_CURSOR%\mcp.json" >nul

echo [4/4] VS Code GitHub Copilot MCP yapilandirmasi kuruluyor...
if not exist "%TARGET_VSCODE_USER%" mkdir "%TARGET_VSCODE_USER%"
if exist "%TARGET_VSCODE_USER%\mcp.json" copy /Y "%TARGET_VSCODE_USER%\mcp.json" "%TARGET_VSCODE_USER%\mcp.json.bak" >nul
if exist "%SRC_DIR%vscode-mcp.json" copy /Y "%SRC_DIR%vscode-mcp.json" "%TARGET_VSCODE_USER%\mcp.json" >nul
if exist "%SRC_DIR%mcp.json" copy /Y "%SRC_DIR%mcp.json" "%TARGET_COPILOT%\mcp-config.json" >nul

echo.
echo ============================================================================
echo   [TAMAMLANDI] Cursor ve VS Code GitHub Copilot varsayilan olarak kuruldu!
echo.
echo   - Cursor Skills         : %TARGET_CURSOR_SKILLS%
echo   - Cursor MCP            : %TARGET_CURSOR%\mcp.json
echo   - VS Code Copilot Skills: %TARGET_COPILOT_SKILLS%
echo   - Universal Agent Skills: %TARGET_AGENTS_SKILLS%
echo   - VS Code Copilot MCP   : %TARGET_VSCODE_USER%\mcp.json
echo.
echo   Not: VS Code Settings icinde "chat.useAgentSkills": true ayarinin
echo        aktif oldugundan emin olun ve IDE'leri yeniden baslatin.
echo ============================================================================
echo.
pause
exit /b 0

:NO_SKILLS
echo [HATA] "%SRC_DIR%skills" klasoru bulunamadi!
echo Lutfen 7z arsivinin tamamini bir klasore cikartip bu .bat dosyasini calistirin.
pause
exit /b 1

:COPY_ERR
echo [HATA] Skill kopyalama sirasinda bir sorun olustu.
pause
exit /b 1
