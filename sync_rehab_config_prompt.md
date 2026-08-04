# 同步 rehab profile 配置到新电脑（提示词模板）

> 用法：在目标电脑打开 Hermes → 新建对话 → 粘贴下面整段 → 发送。
> 适用于：家里/另一台电脑同步工厂电脑的 Hermes 配置改动。

---

【任务】把 GitHub 仓库 wymanchui/hermes-setting-myself 里的 rehab profile 配置同步到本机

【背景】工厂电脑已把 rehab profile 的优化配置推送到 GitHub（开启上下文压缩省 token + 智谱免费视觉兜底），家里电脑需要同步。这是配置文件同步，不是软件重装。

【执行步骤】
1. 定位本机 Hermes 配置目录：
   优先检查 E:\hermes\config\profiles\rehab\config.yaml 是否存在；
   不存在则用 search_files 搜索 rehab/config.yaml（常见位置：E:\hermes\config\profiles\、C:\Users\<用户名>\ 下 .hermes 或 AppData 目录）。
2. 备份现有配置：把 rehab/config.yaml 复制为 config.yaml.bak-今天日期。
3. 下载最新配置（按顺序尝试，成功即停，不要跳过）：
   方法1（最稳）：用浏览器工具打开
     https://raw.githubusercontent.com/wymanchui/hermes-setting-myself/master/profiles/rehab/config.yaml
     读取页面内容；若返回 404 或空白，改用
     https://github.com/wymanchui/hermes-setting-myself/blob/master/profiles/rehab/config.yaml
     页面里的内容（点 Raw 查看原文）。
   方法2：curl 下载整个仓库压缩包再提取单文件：
     curl -sL --max-time 90 "https://codeload.github.com/wymanchui/hermes-setting-myself/tar.gz/refs/heads/master" -o /tmp/hsm.tar.gz
     解压后取 hermes-setting-myself-master/profiles/rehab/config.yaml
     （GitHub 慢就重试 2-3 次，每次间隔几秒）
   方法3：方法 1/2 都失败时，告诉用户手动打开 GitHub 页面复制内容。
4. 内容校验（必须全部通过，否则不得覆盖）：
   - 以 "model:" 开头
   - 包含 compression: 下的 enabled: true
   - 包含 threshold: 0.7
   - 包含 fallback_vision_model: glm-4v-flash
5. 校验通过后覆盖写入 rehab/config.yaml。
6. 完成后输出报告：文件路径、校验结果、并提醒「重启 Hermes 桌面应用（切到 rehab profile）后生效，不需要卸载重装」。
