#!/bin/bash
# 上傳圖片到 GitHub 圖床，回傳 Markdown 格式的圖片連結
# 用法: bash scripts/upload-image.sh <圖片路徑>
# 範例: bash scripts/upload-image.sh slides/generated/blog-cover.png

set -euo pipefail

IMAGE_PATH="${1:?請指定圖片路徑}"
IMAGE_NAME="${2:-$(basename "$IMAGE_PATH")}"
REPO="cenjing8393-netizen/tech-blog-images"
BRANCH="main"
CDN_BASE="https://cdn.jsdelivr.net/gh/${REPO}"

if [ ! -f "$IMAGE_PATH" ]; then
  echo "錯誤: 找不到檔案 $IMAGE_PATH"
  exit 1
fi

echo "上傳中: $IMAGE_NAME ..."

# 用暫存檔避開命令列長度限制
TMP_JSON=$(mktemp)
B64=$(base64 -w0 "$IMAGE_PATH")

cat > "$TMP_JSON" <<ENDJSON
{
  "message": "upload: ${IMAGE_NAME}",
  "content": "${B64}",
  "branch": "${BRANCH}"
}
ENDJSON

gh api "repos/${REPO}/contents/images/${IMAGE_NAME}" \
  --method PUT --input "$TMP_JSON" --jq '.content.path' > /dev/null

rm -f "$TMP_JSON"

URL="${CDN_BASE}/images/${IMAGE_NAME}"

echo ""
echo "=== Markdown 圖片連結 ==="
echo "![${IMAGE_NAME}](${URL})"
echo ""
echo "=== 原始 URL ==="
echo "${URL}"
