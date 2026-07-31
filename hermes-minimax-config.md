# ============================================
# Hermes config.yaml — 完整配置参考
# ============================================

## 1. MiniMax 多模态模型（添加在 models: 下）

models:
  # --- 原有模型保留，在此之下添加 ---

  # 多模态模型：MiniMax-M3（图像理解+视频理解+TTS）
  - model_id: MiniMax-M3
    provider: openai
    base_url: https://api.minimaxi.com/v1
    api_key: "${MINIMAX_API_KEY}"
    capabilities:
      vision: true
      completion: true
      streaming: true
    max_tokens: 4096

# 可选：将 MiniMax 设为默认视觉模型
agent:
  fallback_vision_model: MiniMax-M3

## 2. 压缩配置（省 token）

compression:
  enabled: true        # 启用自动压缩
  threshold: 0.60      # 上下文到60%就开始压缩（默认0.50）
  target_ratio: 0.20   # 压缩到原来的20%
  protect_recent: 15   # 保留最近15条消息不压缩

## 3. Curator 自动整理（省 token + 减冗余）

curator:
  enabled: true
  consolidate: true         # 技能/记忆自动合并去重
  interval_hours: 24        # 每天整理一次
  stale_after_days: 30      # 30天未使用的标记为过时
