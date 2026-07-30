# ============================================
# Hermes config.yaml — MiniMax 多模态配置
# ============================================
# 将此段添加到你的 config.yaml 的 models: 下
# ============================================

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
