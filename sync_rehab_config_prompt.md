# 同步 Hermes profile 配置到新电脑（提示词模板）

> 用法：在目标电脑打开 Hermes → 新建对话 → 粘贴下面整段 → 发送。
> 同步范围：profiles/rehab + profiles/factory 两个 profile 的 config.yaml。
> 注意：.env（API 密钥）永不入仓库，需本机单独配置（见步骤 6）。

---

【任务】把 GitHub 仓库 wymanchui/hermes-setting-myself 里的 Hermes profile 配置同步到本机

【背景】工厂电脑已把 factory 和 rehab 两个 profile 的优化配置推送到 GitHub（上下文压缩省 token + MiniMax-M3/glm-4v-flash 视觉兜底，密钥全部环境变量引用、无明文）。这是配置文件同步，不是软件重装。

【执行步骤】
1. 定位本机 Hermes 配置目录：
   优先检查 E:\hermes\config\profiles\ 下是否存在 rehab 和 factory 两个子目录；
   不存在则用 search_files 搜索 rehab/config.yaml 或 factory/config.yaml（常见位置：E:\hermes\config\profiles\、C:\Users\<用户名>\ 下 .hermes 或 AppData 目录）。
2. 备份现有配置：把 rehab/config.yaml 和 factory/config.yaml 各自复制为 config.yaml.bak-今天日期。
3. 下载最新配置（按顺序尝试，成功即停）：
   方法1（最稳）：用浏览器工具打开以下两个 URL 读取内容（404 或空白则打开对应 github.com 页面点 Raw）：
     https://raw.githubusercontent.com/wymanchui/hermes-setting-myself/master/profiles/rehab/config.yaml
     https://raw.githubusercontent.com/wymanchui/hermes-setting-myself/master/profiles/factory/config.yaml
   方法2：curl 下载整个仓库压缩包再提取：
     curl -sL --max-time 90 "https://codeload.github.com/wymanchui/hermes-setting-myself/tar.gz/refs/heads/master" -o /tmp/hsm.tar.gz
     解压后取 hermes-setting-myself-master/profiles/ 下两个 config.yaml（GitHub 慢就重试 2-3 次）
   方法3：都失败时，告诉用户手动打开 GitHub 页面复制内容。
4. 内容校验（两个文件都必须全部通过，否则不得覆盖）：
   - 以 "models:" 开头
   - 包含 compression: 下的 enabled: true
   - rehab 包含 fallback_vision_model: MiniMax-M3；factory 包含 fallback_vision_model: glm-4v-flash
   - 所有 api_key 行必须是 ${变量名} 形式（出现 32 位十六进制或中文占位符样式的明文密钥 = 错误版本，禁止覆盖）
5. 校验通过后覆盖写入 rehab/config.yaml 和 factory/config.yaml。
6. 配置 API key（密钥不入仓库，需本机单独配置；只检查存在性，不得打印密钥值）：
   - rehab/.env 与 factory/.env 都需要：DEEPSEEK_API_KEY、MINIMAX_API_KEY
   - factory/.env 还需要：GLM_API_KEY
   - 若缺失：MINIMAX_API_KEY 可从 ~/.claude/settings.json 的 env.ANTHROPIC_AUTH_TOKEN 提取（用户 Claude Code 用的 MiniMax key）；
     DEEPSEEK_API_KEY / GLM_API_KEY 缺失时提示用户从各自官网控制台获取。
   - 写入格式：单行、行首无空格无转义符、KEY=值。密钥不得打印到对话，不得写入仓库目录。
7. 完成后输出报告：两个文件路径、校验结果、key 配置状态，并提醒「重启 Hermes 桌面应用后生效，不需要卸载重装」。
