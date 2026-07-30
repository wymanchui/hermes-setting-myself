@echo off
chcp 65001 >nul
title Hermes + Claude Code + MiniMax 全量配置脚本
echo ============================================
echo   Hermes 全量环境配置脚本
echo   请以管理员身份运行
echo ============================================
echo.

:: ===== 1. 检查 Node.js =====
echo [1/6] 检查 Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未安装 Node.js！请先下载安装：https://nodejs.org
    echo    安装后重新运行本脚本
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do echo    Node.js %%i ✓
echo.

:: ===== 2. 安装 Claude Code CLI =====
echo [2/6] 安装 Claude Code CLI...
call npm install -g @anthropic-ai/claude-code
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('claude --version 2^>nul') do echo    Claude Code %%i ✓
) else (
    echo ❌ Claude Code 安装失败
)
echo.

:: ===== 3. 安装 CCSwitch =====
echo [3/6] 安装 CCSwitch...
call npm install -g ccswitch-tui
if %errorlevel% equ 0 (
    echo    CCSwitch ✓
) else (
    echo ❌ CCSwitch 安装失败
)
echo.

:: ===== 4. 配置 Claude Code ↗ MiniMax（通过CCSwitch代理） =====
echo [4/6] 配置 Claude Code 连接 MiniMax...
if not exist "%USERPROFILE%\.claude" mkdir "%USERPROFILE%\.claude"

(
echo {
echo   "env": {
echo     "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
echo     "ANTHROPIC_AUTH_TOKEN": "sk-cp-lO8Y3quOJqlA3o6R8zAj49I6xESYr3x3kyPdtwRZNm-Bhww542zCnH9qQPMOfj1vumC2GHOi_REvS4Nx4LklEJkm4X5CJlmq4bgLwFx2Tbp-w94vQIifZzc",
echo     "API_TIMEOUT_MS": "3000000",
echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
echo     "ANTHROPIC_MODEL": "MiniMax-M2.7",
echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.7",
echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.7",
echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2.7"
echo   }
echo }
) > "%USERPROFILE%\.claude\settings.json"
echo    ~/.claude/settings.json ✓
echo.

:: ===== 5. 配置 Hermes config.yaml（添加 MiniMax-M3 多模态模型） =====
echo [5/6] 配置 Hermes 多模态模型...
echo.
echo ============================================
echo   ⚠ 请手动配置 Hermes config.yaml：
echo ============================================
echo.
echo   1. 打开 Hermes 配置目录
echo      一般在 %%HERMES_HOME%%\config.yaml
echo      或在 E:\hermes\config\profiles\factory\config.yaml
echo.
echo   2. 在 models: 下添加以下内容：
echo.
echo   # 多模态模型：MiniMax-M3（图像理解+视频理解+TTS）
echo   - model_id: MiniMax-M3
echo     provider: openai
echo     base_url: https://api.minimaxi.com/v1
echo     api_key: "${MINIMAX_API_KEY}"
echo     capabilities:
echo       vision: true
echo       completion: true
echo       streaming: true
echo     max_tokens: 4096
echo.
echo   3. 如果想设 MiniMax 为默认视觉模型，修改：
echo      fallback_vision_model: MiniMax-M3
echo.
echo ============================================
echo.

:: ===== 6. 配置 Hermes .env（添加 MiniMax API Key） =====
echo [6/6] 配置 Hermes 环境变量...
echo.
echo ============================================
echo   ⚠ 请手动配置 Hermes .env 文件：
echo ============================================
echo.
echo   打开 %%HERMES_HOME%%\.env，添加一行：
echo.
echo   MINIMAX_API_KEY=sk-cp-lO8Y3quOJqlA3o6R8zAj49I6xESYr3x3kyPdtwRZNm-Bhww542zCnH9qQPMOfj1vumC2GHOi_REvS4Nx4LklEJkm4X5CJlmq4bgLwFx2Tbp-w94vQIifZzc
echo.
echo ============================================
echo.

:: ===== 验证 =====
echo ============================================
echo   🔍 验证安装...
echo ============================================
call claude --version
echo.

echo ============================================
echo   ✅ 配置完成！
echo   测试命令：
echo   1. claude -p "法国的首都是哪里？"
echo   2. 用 Hermes 查看 MiniMax-M3 是否可用
echo ============================================
echo.
echo 提示：回家后从 GitHub 克隆本仓库：
echo   git clone https://github.com/wymanchui/hermes-setting-myself.git
echo.
pause
