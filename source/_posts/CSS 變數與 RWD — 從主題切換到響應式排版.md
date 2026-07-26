---
title: CSS 變數與 RWD — 從主題切換到響應式排版
date: 2026-07-12
updated: 2026-07-12
tags:
  - CSS
  - RWD
  - Variables
categories:
  - 前端
description: CSS 變數（Custom Properties）與 RWD 響應式設計的學習筆記，記錄變數用法、media query 應用，以及兩者搭配的主題切換實戰。
---

## 為什麼學 CSS 變數

以前寫 CSS 要重複同一個顏色值十幾次，改主題色的時候就得全部手動取代。CSS 變數（Custom Properties）解決了這個問題——把共用值抽出來，改一個地方全部更新。

而且跟 Sass 變數不同，CSS 變數是活的，可以透過 JavaScript 在執行時期修改，這是預處理器做不到的。

## 基本用法

定義變數用 `--` 開頭，讀取用 `var()`：

```css
:root {
  --primary: #2563eb;
  --text: #1f2937;
  --bg: #ffffff;
  --spacing: 1rem;
}

.button {
  background: var(--primary);
  color: white;
  padding: var(--spacing);
}
```

`:root` 等於 `html` 元素，變數定義在這裡就是全域可用。

### 預設值

`var()` 可以給 fallback 值，當變數未定義時使用：

```css
.card {
  background: var(--card-bg, #f5f5f5);
  /* 如果 --card-bg 沒定義，就用 #f5f5f5 */
}
```

### 作用域

變數會繼承，所以可以在特定區塊覆寫：

```css
.card {
  --primary: #dc2626;  /* 只在 .card 裡生效 */
  background: var(--primary);
}
```

## 場景一：主題切換（日間／夜間）

CSS 變數最經典的應用——用一個 class 切換整個網站主題：

```css
:root {
  --bg: #ffffff;
  --text: #1f2937;
  --primary: #2563eb;
}

.dark-mode {
  --bg: #111827;
  --text: #f9fafb;
  --primary: #60a5fa;
}

body {
  background: var(--bg);
  color: var(--text);
}
```

搭配 JavaScript 一行切換：

```js
document.body.classList.toggle('dark-mode');
```

## 什麼是 RWD

RWD（Responsive Web Design）就是讓同一個網頁在不同螢幕尺寸下自動調整版面。核心技術是 CSS 的 Media Query。

一定要加的 viewport meta：

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

沒有這行，手機瀏覽器會用桌機的寬度縮放顯示，字會變超小。

## 場景二：Media Query 斷點（桌機優先）

我習慣桌機優先，用 `max-width` 從大寫到小：

```css
/* 桌機（預設）：三欄 */
.container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}

/* 平板：雙欄 */
@media (max-width: 1023px) {
  .container {
    grid-template-columns: 1fr 1fr;
  }
}

/* 手機：單欄 */
@media (max-width: 767px) {
  .container {
    grid-template-columns: 1fr;
  }
}
```

桌機優先的好處是預設就是完整版面，再針對小螢幕逐步簡化。

## 場景三：變數 + RWD 主題切換

把變數和媒體查詢結合，日間夜間自動跟隨系統設定：

```css
:root {
  --bg: #ffffff;
  --text: #1f2937;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: #111827;
    --text: #f9fafb;
  }
}

body {
  background: var(--bg);
  color: var(--text);
}
```

`prefers-color-scheme` 會自動偵測使用者系統是日間還是夜間模式，完全不用 JavaScript。

還可以進一步搭配斷點調整字體大小：

```css
:root {
  --font-size: 14px;
}

@media (min-width: 768px) {
  :root {
    --font-size: 16px;
  }
}

@media (min-width: 1200px) {
  :root {
    --font-size: 18px;
  }
}

body {
  font-size: var(--font-size);
}
```

## 場景四：間距系統

用變數統一管理間距，RWD 時只改變數值：

```css
:root {
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 2rem;
}

@media (min-width: 768px) {
  :root {
    --space-sm: 0.75rem;
    --space-md: 1.5rem;
    --space-lg: 3rem;
  }
}

.card {
  padding: var(--space-md);
  margin-bottom: var(--space-lg);
}
```

## 學到的心得

- CSS 變數跟 Sass 變數不一樣，它可以繼承、可以 JS 修改、有作用域
- `var(--name, fallback)` 給預設值避免變數未定義
- RWD 桌機優先寫 `max-width`，預設完整版面再逐步簡化
- `prefers-color-scheme` 不用 JS 就能做夜間模式
- 變數 + RWD 搭配，一套間距系統自動適應所有裝置

## 參考資料

- [MDN — CSS Custom Properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)
- [MDN — Media Queries](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries)
- [iThome 鐵人賽 — CSS RWD 響應式網頁設計](https://ithelp.ithome.com.tw/articles/10296854)
- [W3Schools — RWD Intro](https://www.w3schools.com/css/css_rwd_intro.asp)
- [MDN — prefers-color-scheme](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme)
