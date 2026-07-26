---
title: CSS 動畫 — 從 transition 到 keyframes
date: 2026-07-14
updated: 2026-07-14
tags:
  - CSS
  - Animation
  - Transition
  - Transform
categories:
  - 前端
description: CSS 動畫的學習筆記，記錄 transition 轉場、@keyframes 動畫、transform 變形的實戰用法與常見 UI 動畫範例。
---

![transition-vs-animation.png](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/transition-vs-animation.png)
## 為什麼要學 CSS 動畫

好的動畫讓網站活起來：按鈕 hover 微微變色、卡片載入時淡入、loading 旋轉圖示——這些效果以前需要 JavaScript 或 jQuery，現在 CSS 就能搞定。

CSS 動畫分兩種：**transition**（兩狀態間的轉場）和 **animation**（多關鍵影格 + 可循環）。

## Transition：兩狀態轉場

最簡單的動畫——當屬性改變時平滑過渡：

```css
.button {
  background: #2563eb;
  transition: background 0.3s ease;
}

.button:hover {
  background: #1d4ed8;
}
```

### transition 縮寫

順序：property duration timing-function delay

```css
.card {
  transition: all 0.3s ease 0s;
  /* 也可以只指定特定屬性 */
  transition: transform 0.3s ease, opacity 0.2s linear;
}

.card:hover {
  transform: translateY(-4px);
  opacity: 0.9;
}
```

### timing-function 常用值

- `ease` — 慢快慢（預設）
- `linear` — 等速
- `ease-in` — 漸快
- `ease-out` — 漸慢
- `ease-in-out` — 慢快慢（比 ease 更平滑）
- `cubic-bezier(n, n, n, n)` — 自訂曲線

## Transform：變形

`transform` 常跟 transition 搭配使用：

```css
/* 位移 */
transform: translateX(20px);
transform: translateY(-50%);

/* 縮放 */
transform: scale(1.2);

/* 旋轉 */
transform: rotate(45deg);

/* 傾斜 */
transform: skew(10deg);

/* 多個效果疊加 */
transform: translateY(-4px) scale(1.05);
```

## Animation：多關鍵影格

用 `@keyframes` 定義動畫，適用於更複雜的場景：

```css
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.card {
  animation: fadeInUp 0.5s ease forwards;
}
```

百分比可以定義多個影格：

```css
@keyframes bounce {
  0%   { transform: translateY(0); }
  50%  { transform: translateY(-20px); }
  100% { transform: translateY(0); }
}

.ball {
  animation: bounce 1s ease infinite;
}
```

### animation 縮寫

順序：name duration timing-function delay iteration-count direction fill-mode

```css
.spinner {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}
```

### animation-fill-mode

控制動畫播放前後的樣式：

- `none`（預設）— 播放前後回到原本樣式
- `forwards` — 動畫結束後保留最後一幀
- `backwards` — 動畫開始前先套用第一幀
- `both` — 兩者兼具

## 實戰範例一：按鈕 hover

```css
.btn {
  background: #2563eb;
  color: white;
  padding: 0.75rem 2rem;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
}

.btn:active {
  transform: translateY(0);
}
```

## 實戰範例二：卡片淡入

```css
.card {
  animation: fadeInUp 0.5s ease forwards;
  opacity: 0;  /* 一開始隱藏 */
}

.card:nth-child(2) { animation-delay: 0.1s; }
.card:nth-child(3) { animation-delay: 0.2s; }

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

## 實戰範例三：loading spinner

```css
.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e5e7eb;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
```

## 無障礙：prefers-reduced-motion

有些使用者不喜歡動畫，可以透過媒體查詢關閉：

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## 學到的心得

- 簡單的 hover 效果用 `transition` 就夠了
- 需要循環或自動播放用 `@keyframes` + `animation`
- `transform` 不會觸發重排（reflow），效能最好
- `animation-fill-mode: forwards` 讓動畫結束後保留狀態
- 記得加 `prefers-reduced-motion` 照顧無障礙

## 參考資料

- [MDN — CSS Transitions](https://developer.mozilla.org/zh-TW/docs/Web/CSS/Guides/Transitions/Using)
- [MDN — CSS Animations](https://developer.mozilla.org/zh-TW/docs/Web/CSS/Guides/Animations/Using)
- [MDN — prefers-reduced-motion](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion)
- [STEAM 教育學習網 — CSS 動畫](https://steam.oxxostudio.tw/category/css/content/animation.html)
- [iThome — CSS 動畫簡介與過渡效果](https://ithelp.ithome.com.tw/articles/10363225)
