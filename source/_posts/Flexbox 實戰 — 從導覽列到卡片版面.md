---
title: Flexbox 實戰 — 從導覽列到卡片版面
date: 2026-07-10
updated: 2026-07-10
tags:
  - CSS
  - Flexbox
  - Layout
categories:
  - 前端
description: Flexbox 的實戰學習筆記，記錄導覽列、垂直居中、卡片列表、黏底 footer、表單對齊五個常用場景與程式碼。
---

![flexbox-vertical-center.png](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/flexbox-vertical-center.png)

## 為什麼學 Flexbox

在 Flexbox 出現之前，做垂直居中要寫 `position: absolute` + `transform`，做等高欄位要靠 JavaScript。Flexbox 把這些問題全簡化成幾行 CSS。

## 場景一：導覽列

Logo 在左、導覽連結在右。

```html
<nav class="navbar">
  <div class="logo">My Blog</div>
  <ul class="nav-links">
    <li><a href="#">首頁</a></li>
    <li><a href="#">文章</a></li>
    <li><a href="#">關於</a></li>
  </ul>
</nav>
```

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
}

.nav-links {
  display: flex;
  gap: 1.5rem;
  list-style: none;
}
```

`justify-content: space-between` 把 Logo 推左、連結推右，`align-items: center` 讓兩者在交叉軸居中。

## 場景二：垂直居中

```css
.centered {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}
```

三行 CSS 就搞定以前要寫半天的垂直置中。

## 場景三：卡片列表

一排卡片自動換行、等寬：

```css
.card-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
}

.card {
  flex: 1 1 300px;
}
```

`flex: 1 1 300px`：可以長大、可以縮小、基準寬度 300px。容器夠寬時等分空間，不夠寬時自動換行。

最後一排卡片想靠左：

```css
.card-grid::after {
  content: "";
  flex: 1 1 300px;
}
```

## 場景四：黏底 Footer

內容不夠高時 footer 黏底部，內容超過時被往下推：

```css
body {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

main {
  flex: 1;
}

footer {
  /* 自然在底部 */
}
```

## 場景五：表單欄位對齊

```css
.form-row {
  display: flex;
  align-items: baseline;
  gap: 1rem;
}

.form-row label {
  flex: 0 0 120px;
  text-align: right;
}

.form-row input {
  flex: 1;
}
```

## 學到的心得

`flex: 1` 是 `flex: 1 1 0%`，基準寬度 0 所以等分空間。如果要內容自適應寬度，用 `flex: auto`。

Flexbox 是一維，Grid 是二維，兩者互補不是取代。但八九成的版面問題，一行 `display: flex` 就夠了。

## 參考資料

- [MDN Flexbox](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Flexbox)
- [CSS Tricks: A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
- [Flexbox Froggy — 互動式學習遊戲](https://flexboxfroggy.com/)
- [DevPalettes — Complete CSS Flexbox Guide (2026 Edition)](https://devpalettes.com/blog/css-flexbox-guide/)
