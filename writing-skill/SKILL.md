---
name: writing-skill
description: |
  技术写作风格指南，覆盖 README、commit message、PR description、changelog、API 文档、
  错误信息、CLI 帮助文本、代码注释、技术博客等场景。内置去 AI 痕迹检查清单。
  Use when the user mentions: write README, write docs, write PR, PR description,
  commit message, git commit, changelog, release notes, API documentation, error message,
  CLI help, blog post, technical article, write tutorial, documentation style,
  writing guide, CONTRIBUTING.md, CHANGELOG.md, docstring, code review comment,
  写文档, 写README, 写PR, 提交信息, git提交, 更新日志, 发布说明, 技术博客,
  润色, 改写, 写注释, 错误提示, rewrite, polish, humanize, proofread.
  Also use when generating any developer-facing text that will live in a repository,
  when writing error messages or CLI output, when reviewing text quality,
  or when rewriting existing text to remove AI-sounding patterns.
  For deep pattern-by-pattern AI text rewriting with examples, use @human-skill instead.
---

# 技术写作风格指南

面向开发者写作。读者先扫再读，每句话都要有存在的理由。

## 基本原则

**直接。** 先说做什么，再说怎么做。结论在前，背景在后。

**具体。** 用"p99 < 50ms"代替"很快"。用"经测试支持 10K 并发"代替"可扩展"。模糊的说法浪费读者信任。

**精炼。** 删掉一个词不改变意思，就删掉它。一句清楚的话胜过两句含糊的。

**尊重读者。** 他们是有能力的开发者。去掉"众所周知""只需""显然"之类居高临下或过度简化的词。

**适配场景。** commit message 不是博客，CLI help 不是 API 文档。每种格式有自己的约束，遵守它们。

**不加分隔线。** Markdown 文章中不要在章节之间插入 `---`（水平分隔线）。标题层级本身已经划分了结构，`---` 是多余的视觉噪音。

## README

README 按顺序回答五个问题：

1. **这是什么？** — 一句话。项目做什么，给谁用。
2. **快速开始** — 从零到可用的最短路径，可直接复制粘贴的命令。
3. **用法** — 核心 API 或 CLI 接口，附示例。
4. **安装** — 前置条件、依赖、平台说明。
5. **贡献 / 许可** — 简要说明或链接到外部文档。

规则：
- 开头是一行描述，不是 logo 墙或 badge 集合
- 第一屏内展示一个真实可运行的示例
- badge（如有）放标题后一行
- 所有命令、路径、配置片段用代码块
- 链接到详细文档，而非把所有内容塞进 README；README 是入口，不是百科
- 安装步骤控制在 5 条命令以内

README 中避免：
- "欢迎使用 ProjectX！" — 跳过寒暄
- 每段都重复项目名
- 文字截图（不可搜索、不可访问）
- 承诺还没实现的功能

## Commit Message

格式：

```
<type>: <做了什么>（祈使句，小写，不加句号）

<为什么需要这个改动 — 1-3 句>
```

type：`fix`, `feat`, `refactor`, `perf`, `test`, `docs`, `chore`, `ci`, `build`。

主题行应能补完这句话："应用此 commit 后，它会 ___。"

规则：
- 主题行 <= 72 字符
- 正文 72 字符换行
- 主题与正文之间空一行
- 相关 issue/PR 引用：`Fixes #123`
- 一个 commit 做一件事；主题出现"和"时考虑拆分
- 不要描述 diff 已经展示的内容（"将 X 从 A 改为 B"）；解释为什么
- 不要添加 "Made-with: Cursor" 或任何工具归属 trailer

好的示例：

```
fix: prevent deadlock when cache expires during batch write

The TTL expiry callback was acquiring the write lock while batch_write
already held it. Switch to a lock-free expiry queue that defers cleanup
to the next write cycle. Fixes #847.
```

差的示例：

```
Updated cache.py and changed the lock mechanism and fixed some bugs
```

## PR Description

结构：

```markdown
## Summary
<1-3 句话：做了什么，为什么>

## Changes
- <按逻辑单元分组，不是按文件>

## Test plan
- <怎么验证的>

## Notes
- <迁移步骤、回滚方案、后续工作>
```

规则：
- 开头说要解决的问题，不是解决方案
- 第一行链接 issue/ticket
- 按意图分组（"重构了 auth 流程"、"添加了限流中间件"），而非文件清单
- 行为变更附上前后对比（截图、curl 输出、benchmark）
- 指明审查重点："主逻辑在 `src/auth/session.rs`，其余是串联"
- Draft PR 标注清楚；不要在功能 PR 里夹带重构

## Changelog / Release Notes

面向用户写，不面向开发者。用户关心行为变化，不关心内部重构。

格式（每个版本）：

```markdown
## v1.2.0 (2026-03-03)

### Added
- 支持 Server-Sent Events 流式响应

### Changed
- 默认超时从 30s 调整为 60s

### Fixed
- 上游返回 502 时连接池泄漏

### Removed
- 废弃 `--legacy-auth`（改用 `--auth=oauth2`）
```

规则：
- 每条变更一行；详情链接到 PR/issue
- 祈使句或过去时，项目内保持一致
- 按 Added/Changed/Fixed/Removed 分组（Keep a Changelog 规范）
- 破坏性变更醒目标注，前缀 **BREAKING:**
- 破坏性变更附迁移说明
- 内部重构不列入，除非影响公开 API 或性能

## API 文档

每个 endpoint 或函数：

```
## `POST /api/v1/jobs`

创建批处理任务。

### 参数

| 名称     | 类型   | 必填 | 说明                     |
|:---------|:-------|:-----|:-------------------------|
| `input`  | string | 是   | 输入数据集的 S3 URI      |
| `config` | object | 否   | 覆盖默认配置             |

### 响应

- `201 Created` — 任务已入队；返回 `{ "job_id": "..." }`
- `400 Bad Request` — 校验错误；返回 `{ "error": "..." }`
- `429 Too Many Requests` — 按 `Retry-After` header 重试

### 示例

（使用真实数据的完整请求/响应对，不用 foo/bar）
```

规则：
- 每个参数标注类型、是否必填、一行说明
- 列出调用方需要处理的所有响应码
- 附完整的请求/响应示例，数据要真实
- 错误格式跨 endpoint 保持一致
- API 加版本号；标注废弃时间线

## 错误信息

一条错误信息回答三个问题：**发生了什么**、**为什么**、**怎么办**。

好的示例：

```
Error: Cannot connect to database at localhost:5432.
The connection was refused — is PostgreSQL running?
Try: sudo systemctl start postgresql
```

差的示例：

```
Error: connection failed
```

规则：
- 说明失败的操作，不只是错误码
- 包含相关上下文（文件路径、URL、具体值）
- 尽可能建议具体的修复方法或下一步操作
- 全代码库格式统一
- 不要指责用户（"你忘了..."）；描述状态（"未找到配置文件..."）

## CLI 帮助文本

```
Usage: mytool <command> [options]

Commands:
  init        在当前目录创建新项目
  build       编译源文件到 dist/
  serve       启动本地开发服务器 (默认端口: 3000)

Options:
  -o, --output <dir>    输出目录 (默认: dist)
  -v, --verbose         显示详细构建输出
  -h, --help            显示帮助信息

Examples:
  mytool init --template react
  mytool build --output ./public
  mytool serve --port 8080
```

规则：
- 命令描述以动词开头，一行搞定
- 描述中展示默认值
- 底部附 2-3 个真实示例
- 分组相关选项；不要把 30 个 flag 平铺
- `--help` 应该足够让用户不看文档就能上手

## 代码注释

注释解释 *为什么*，不解释 *做了什么*。代码本身已经说了做了什么。

好的示例：

```python
# Cap retry backoff at 30s to avoid blocking the event loop
# during long outages. The upstream SLA guarantees recovery
# within 60s, so 30s strikes a reasonable balance.
max_backoff = 30
```

差的示例：

```python
# Set max backoff to 30
max_backoff = 30
```

该写注释的场景：
- 不明显的业务规则或领域约束
- workaround，附上游 issue 链接
- 性能关键代码，故意没用"显而易见"的写法
- 公开 API 的 docstring

不该写注释的场景：
- 用英语/中文复述代码
- 显而易见的类型标注或变量名
- 没有对应 issue 的 TODO

## 博客 / 技术文章

结构：Hook → 背景 → 正文 → 结论。

- 开头说问题或结论，不说历史
- 每 3-5 段加一个小标题方便扫读
- 代码示例要可运行，不要伪代码
- 结尾给具体的下一步行动，不要"总而言之"

语气：
- 分享经验用第一人称；教程用第三人称
- 承认 trade-off 和局限："这个方案在 ... 场景下会失效"
- 句子长短交替；用代码块、表格、图表打破大段文字
- 一段一个观点

## 去 AI 痕迹检查清单

写完或改完文本后，逐项检查。需要逐条详细示例和深度改写指导时，使用 `@human-skill`。

### 内容层面

- ✓ 删掉了夸大意义的宣称（"标志着...的转折点""在不断演变的格局中"）
- ✓ 用具体来源替换了模糊归因（"专家认为" → 具体论文/报告）
- ✓ 没有公式化的"挑战与展望"段落
- ✓ 没有宣传式语言（"坐落于""令人叹为观止""开创性的"）

### 语言层面

- ✓ 去掉了高频 AI 词汇：此外、至关重要、深入探讨、格局、充满活力、展示、证明
- ✓ 能用"是/有"的地方没用"作为/充当/标志着"
- ✓ 没有"不仅...而且..."的否定式排比
- ✓ 列举项不强制凑三个（两项或四项都行）
- ✓ 同一实体没刻意用同义词循环（主角→主要角色→中心人物）

### 风格层面

- ✓ 没有过度使用破折号（一段内最多一处）
- ✓ 没有机械加粗（粗体只用于真正需要强调的地方）
- ✓ 没有 emoji 装饰标题
- ✓ 没有"粗体标题 + 冒号"的内联列表格式
- ✓ 冒号使用克制。避免"**加粗词**：一段解释"的机械模式，中文写作中冒号意味着"下面是对上面的解释/列举"，频繁使用会让文章读起来像填表。改法举例：
  - 差："**特点一**：它支持多种格式" → 好："**特点一**，它支持多种格式"（逗号承接）
  - 差："常用的有以下三种：" → 好："常用的有以下三种。"（句号引出列表）
  - 差："原因是：内存不足" → 好："原因是内存不足"（直接去掉冒号）
  - 合理的冒号：正式定义（"SIMT：Single Instruction, Multiple Threads"）、引语、`key: value` 格式
- ✓ 引号使用中文引号（""），不是英文弯引号

### 交流层面

- ✓ 删掉了聊天痕迹（"希望对您有帮助""请告诉我""好问题！"）
- ✓ 没有知识截止日期的免责声明
- ✓ 没有谄媚语气（"您说得完全正确"）

### 整体质感

- ✓ 连续三句长度不相同
- ✓ 段落结尾方式有变化
- ✓ 填充短语已删除（"值得注意的是""在这个时间点""为了实现这一目标"）
- ✓ 没有过度限定（"可以潜在地可能"）
- ✓ 没有模糊的乐观结尾（"未来可期""令人振奋的前景"）
