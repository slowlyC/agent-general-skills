#!/bin/bash
# Agent General Skills 安装脚本
# 用法: bash install.sh [--agent cursor|claude|codex|gemini] [--copy]
#
# 默认安装到 Cursor。使用 --agent 选择目标工具。
#
# 安装模式（默认仅复制 SKILL.md）:
#   --copy  全量复制 skill 目录（适用于需要完整副本的场景）

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

AGENT="cursor"
COPY_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --agent) AGENT="$2"; shift 2 ;;
        --copy)  COPY_MODE=true; shift ;;
        -h|--help)
            echo "用法: bash install.sh [--agent cursor|claude|codex|gemini] [--copy]"
            echo ""
            echo "安装到指定工具的 skill 目录:"
            echo "  bash install.sh                   # Cursor (默认，已验证)"
            echo "  bash install.sh --agent claude     # Claude Code (~/.claude/skills/)"
            echo "  bash install.sh --agent codex      # Codex (~/.codex/skills/)"
            echo "  bash install.sh --agent gemini     # Gemini CLI (~/.gemini/skills/)"
            echo ""
            echo "选项:"
            echo "  --copy  全量复制 skill 目录"
            exit 0
            ;;
        *) echo "未知参数: $1"; exit 1 ;;
    esac
done

get_skill_dir() {
    case $1 in
        cursor) echo "${HOME}/.cursor/skills" ;;
        claude) echo "${HOME}/.claude/skills" ;;
        codex)  echo "${HOME}/.codex/skills" ;;
        gemini) echo "${HOME}/.gemini/skills" ;;
        qoder)  echo "${HOME}/.qoder/skills" ;;
        *)      echo "未知工具: $1" >&2; return 1 ;;
    esac
}

SKILLS=(writing-skill human-skill plot-skill skill-creator)

install_to_agent() {
    local agent=$1
    local SKILL_DIR
    SKILL_DIR=$(get_skill_dir "$agent")

    echo "================================"
    echo "安装到 $agent ($SKILL_DIR)"
    echo "================================"
    echo ""

    mkdir -p "$SKILL_DIR"

    for skill in "${SKILLS[@]}"; do
        local src="$SCRIPT_DIR/$skill"
        local target="$SKILL_DIR/$skill"

        echo "--- $skill ---"

        if [ ! -d "$src" ]; then
            echo "  跳过: $skill/ 不存在"
            continue
        fi

        if [ -L "$target" ]; then
            rm "$target"
        elif [ -d "$target" ]; then
            rm -rf "$target"
        fi

        if [ "$COPY_MODE" = true ]; then
            cp -r "$src" "$target"
            echo "  已复制: $src -> $target"
        else
            mkdir -p "$target"
            cp "$src/SKILL.md" "$target/SKILL.md"
            echo "  已复制: SKILL.md"
        fi
    done
    echo ""
}

install_to_agent "$AGENT"

echo "================================"
echo "验证"
echo "================================"
echo ""

verify_agent() {
    local agent=$1
    local SKILL_DIR
    SKILL_DIR=$(get_skill_dir "$agent")
    local PASS=0 FAIL=0

    echo "--- $agent ($SKILL_DIR) ---"

    check() {
        if [ -e "$1" ]; then
            echo "  OK: $2"
            PASS=$((PASS + 1))
        else
            echo "  缺失: $2"
            FAIL=$((FAIL + 1))
        fi
    }

    for skill in "${SKILLS[@]}"; do
        check "$SKILL_DIR/$skill/SKILL.md" "$skill/SKILL.md"
    done

    echo "  验证: $PASS 通过, $FAIL 失败"
    echo ""

    if [ $FAIL -gt 0 ]; then
        echo "  提示: 缺失的 SKILL.md 可能影响 skill 功能."
        echo ""
    fi
}

verify_agent "$AGENT"

echo "安装完成."
