# Codex 视频 4 Skill 安装包（来自抖音视频 7669412462877330694）

来源: https://v.douyin.com/kC7Gfyd_yYA/
标题: 第11集 | 装完这4个Skill，Codex做视频从5小时压缩到10分钟
作者: 还没想好 (Codex高阶玩法系列)

## 视频中识别的 4 个 Skill

| # | Skill | 仓库 | 功能 |
|---|-------|------|------|
| 1 | HyperFrames | github.com/heygen-com/hyperframes (39.2k⭐) | 文案→9个动态场景，HTML渲染视频（VISUAL COMPOSE） |
| 2 | Remotion | github.com/remotion-dev/remotion | 参数化视频引擎（PARAMETRIC ENGINE） |
| 3 | ChatCut | github.com/ChatCut-Inc/agent-plugin (445⭐) | 口播剪辑/字幕/动效（EDITORIAL SURGERY） |
| 4 | Seedance | 字节跳动 seed.bytedance.com | AI视频生成B-roll镜头（CINEMATIC SHOTS） |

## 工作流（视频所示）
分析口播 → 拆分场景 → 匹配动效 → 生成画面 → 合成输出（Codex统一调度）

## 安装位置（Hermes skills）
E:\hermes\config\profiles\factory\skills\video-creation\
- hyperframes-* : 19个（HyperFrames全家桶，含remotion-to-hyperframes）
- chatcut-* : 15个（含video-gen=Seedance/Kling能力）

## 验证
hermes skills list | grep video-creation  → 95 local skills enabled

## 依赖
- HyperFrames: npx hyperframes（Node.js + 浏览器渲染）
- ChatCut: 需 chatcut.io 账号 + MCP (api.chatcut.io)，ffmpeg
- Seedance: 需字节/即梦 API key（或ChatCut credits）
