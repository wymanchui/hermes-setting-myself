@echo off
chcp 65001 >nul
title Hermes + Claude Code + CCSwitch 一键配置
echo ============================================
echo   Hermes + Claude Code 环境配置脚本
echo   在新电脑上以管理员身份运行
echo ============================================
echo.

:: ===== 1. 安装 Node.js 依赖 =====
echo [1/4] 安装 Claude Code CLI...
call npm install -g @anthropic-ai/claude-code
echo.

echo [2/4] 安装 CCSwitch...
call npm install -g ccswitch-tui
echo.

:: ===== 2. 创建 ~/.claude/settings.json =====
echo [3/4] 配置 Claude Code 连接 MiniMax...
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
echo.

:: ===== 3. 验证安装 =====
echo [4/4] 验证安装...
call claude --version
echo.

echo ============================================
echo   ✅ 配置完成！
echo   运行 claude -p "你好" 测试
echo ============================================
pause
