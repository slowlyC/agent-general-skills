# agent-general-skills

通用 Agent Skill 集合，适用于 Cursor / Claude Code / Codex / Gemini CLI。


| Skill             | 用途                       | 触发方式                                |
| ----------------- | ------------------------ | ----------------------------------- |
| **writing-skill** | 技术写作规范 + 去 AI 检查清单       | 自动触发（写文档、写 README、commit、PR、润色、改写等） |
| **human-skill**   | 去 AI 痕迹完整参考（24 种模式 + 评分） | 自动触发（润色、改写、审阅等）或手动 `@human-skill`   |
| **plot-skill**    | Matplotlib 马卡龙配色画图风格     | 自动触发（画图、可视化、diagram 等关键词）           |
| **skill-creator** | 创建、测试、优化 Agent Skill   | 自动触发（创建 skill、优化 skill、skill 评测等）     |


## 安装

```bash
git clone https://github.com/slowlyC/agent-general-skills.git
cd agent-general-skills

# 安装 skill (默认 Cursor，用 --agent claude/codex/gemini 安装到其他工具)
bash install.sh
```

脚本会将 SKILL.md 复制到对应工具的 skill 目录。使用 `--copy` 可全量复制整个 skill 目录。

### 其他工具

SKILL.md 格式兼容 Claude Code、Codex、Gemini CLI 等支持 Agent Skills 的工具。安装脚本提供了 `--agent` 参数将文件复制到对应路径:


| 工具          | 安装路径                | 命令                               |
| ----------- | ------------------- | -------------------------------- |
| Cursor      | `~/.cursor/skills/` | `bash install.sh` (默认)           |
| Claude Code | `~/.claude/skills/` | `bash install.sh --agent claude` |
| Codex       | `~/.agents/skills/` | `bash install.sh --agent codex`  |
| Gemini CLI  | `~/.gemini/skills/` | `bash install.sh --agent gemini` |


注: 本项目只在 Cursor 下完整验证过。其他工具的 skill 发现和搜索机制可能有差异，如遇问题可以让对应工具的 AI 协助排查。

## 目录结构

```
agent-general-skills/
├── README.md
├── install.sh                       # 安装脚本 (支持 --agent cursor|claude|codex|gemini)
├── writing-skill/
│   └── SKILL.md                     # 技术写作风格指南
├── human-skill/
│   └── SKILL.md                     # 去 AI 痕迹 / 文本人性化
├── plot-skill/
│   └── SKILL.md                     # Matplotlib 画图风格
└── skill-creator/
    ├── SKILL.md                     # Skill 创建、测试、优化
    ├── agents/                      # 子 agent 指令 (grader, comparator, analyzer)
    ├── assets/                      # 模板文件
    ├── eval-viewer/                 # 评测结果可视化
    ├── references/                  # JSON schema 文档
    └── scripts/                     # 评测、打包、优化脚本
```

## writing-skill

日常写作的主力 skill。覆盖 README、commit message、PR description、changelog、API 文档、错误信息、CLI help、代码注释、技术博客等 9 种场景，每种给出结构模板和示例。末尾内置精简版去 AI 检查清单（内容/语言/风格/交流四层），写完或改完文本后可快速自检。

## human-skill

writing-skill 内置检查清单的完整版。24 种 AI 写作模式逐一展开，每种配有"改写前/改写后"对照示例，并提供 5 维度 50 分制评分体系。适合需要逐条对照做深度改写时手动触发（`@human-skill`）。

## plot-skill

标准化 Matplotlib 画图风格:


| 配色                   | 场景            |
| -------------------- | ------------- |
| **Macaron** (默认)     | 马卡龙色系，适合报告/演示 |
| **Okabe-Ito** (色盲友好) | 适合论文/期刊投稿     |


统一了文本颜色、边框、箭头、保存参数等样式约定。

## skill-creator

来自 [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/skill-creator) 的 Skill 开发工具。完整覆盖 skill 从构思到发布的工作流：意图捕获 → 编写 SKILL.md → 测试用例生成 → 并行运行评测 → 量化对比基线 → 可视化评审 → 迭代改进 → 描述优化（提升触发准确率）→ 打包分发。

安装时建议使用 `--copy` 模式以保留完整的子目录结构（agents、scripts、eval-viewer 等）。

## 推荐 Skills

以下是其他项目中值得单独安装的 skill，和本项目互补:


| Skill               | 来源                                                                                         | 说明                                                    |
| ------------------- | ------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| **frontend-design** | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | 反"AI 审美"的前端 UI 设计指南，覆盖 typography、color、motion、layout |
| **doc-coauthoring** | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/doc-coauthoring) | 结构化文档协作工作流（提案、RFC、设计文档），含 Reader Testing              |
| **mcp-builder**     | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/mcp-builder)     | MCP Server 开发指南，Python/TypeScript 双语参考                |


安装方式: 克隆 [anthropics/skills](https://github.com/anthropics/skills) 后将对应目录复制到 `~/.cursor/skills/`，或在 Cursor Settings → Rules → Add Rule 中添加 Remote Rule。

## 致谢

- human-skill 翻译自 [blader/humanizer](https://github.com/blader/humanizer)，参考 [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop)
- 中文版来源: [op7418/Humanizer-zh](https://github.com/op7418/Humanizer-zh)
- plot-skill 的色盲友好配色方案参考 [Okabe & Ito (2008)](https://jfly.uni-koeln.de/color/)

## 许可

本项目代码以 MIT 许可发布。human-skill 的内容基于 Wikipedia 的 AI writing 指南和上述开源项目。