#!/bin/bash
# 將 Obsidian 筆記同步至 Hexo source/_posts
# 執行方式: bash scripts/sync-obsidian.sh

OBSIDIAN_VAULT="/home/cenjing8393/pCloudDrive/obsidian/obsidian_Note"
HEXO_POSTS="source/_posts"
SYNC_DIR="${OBSIDIAN_VAULT}/技術部落格/文章"

echo "=== 同步 Obsidian → Hexo ==="

if [ ! -d "$SYNC_DIR" ]; then
  echo "錯誤: 找不到 Obsidian 目錄 ${SYNC_DIR}"
  exit 1
fi

count=0
for file in "$SYNC_DIR"/*.md; do
  basename=$(basename "$file")
  # 略過非文章檔案
  case "$basename" in
    README.md|文章範本.md) continue ;;
  esac

  cp "$file" "$HEXO_POSTS/$basename"
  echo "  ✔ $basename"
  ((count++))
done

echo "=== 完成: 同步 ${count} 篇文章 ==="
