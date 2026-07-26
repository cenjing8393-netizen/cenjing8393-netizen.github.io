---
title: CSS 選擇器 — 從 class 到 :has()
date: 2026-07-09
updated: 2026-07-10
tags:
  - CSS
  - Selector
categories:
  - 前端
description: CSS 選擇器的學習筆記，從基本的 class、ID 到現代的 :has()，記錄每次用到的選擇器與實戰範例。
---

![css-selector-map.png](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/css-selector-map.png)

## 我的學習路徑

我剛開始寫 CSS 的時候，從頭到尾只靠 class 選擇器。什麼東西都用 class 命名，class 長到像在寫小說。

後來才發現很多時候根本不需要 class，就能精準選到元素。

## 基本選擇器

```css
/* 元素選擇器 */
p { color: red; }

/* class 選擇器 */
.card { background: white; }

/* ID 選擇器 */
#header { height: 60px; }

/* 屬性選擇器 */
input[type="email"] { border-color: blue; }
```

屬性選擇器還有 `[class~="btn"]`（包含某個單詞）、`[href^="https"]`（開頭匹配）、`[src$=".png"]`（結尾匹配），實戰很常用。

## 組合選擇器

```css
/* 後代 */
div p { }

/* 子元素 */
div > p { }

/* 相鄰兄弟 */
h2 + p { }

/* 通用兄弟 */
h2 ~ p { }
```

這四個組合符號用對的話，可以少寫很多 class。

## 偽類選擇器

### 位置相關

```css
li:first-child { }
li:last-child { }
li:nth-child(odd) { background: #f5f5f5; }
li:nth-child(3n+2) { }
```

我的記憶法：`n` 從 0 開始數，A 是間隔，B 是起點。`3n+2` 就是從第 2 個開始，每 3 個取一個。

### 邏輯相關

```css
input:not(.disabled) { }
:is(header, main, footer) p { }
:where(.alert, .warning) { color: red; }
```

`:where()` 的優先度永遠是 0，用在第三方元件覆寫不會蓋不掉。

### 現代王者：`:has()`

```css
li:has(.active) { font-weight: bold; }
figure:has(img) { border: 1px solid #ddd; }
form:has(input:invalid) { border-color: red; }
h2:has(+ p) { margin-bottom: 0; }
```

## 偽元素

```css
.quote::before { content: "「"; }
.quote::after  { content: "」"; }
p::first-line { font-weight: bold; }
::selection { background: #ffd700; }
```

## 實戰範例：卡片列表

把上面學到的組合起來：

```css
.cards > article:first-child {
  border-top: none;
}

.card section:not(:last-child) {
  border-bottom: 1px solid #eee;
}

.card:has(a img)::after {
  content: "含圖片";
  font-size: 0.8em;
}
```

## 學到的心得

先從 class 和組合器開始，遇到需要篩選特定元素的時候，再來翻偽類。等到習慣用 `:nth-child` 取代 `.item-1`、`.item-2` 的時候，就回不去了。

## 參考資料

- [MDN Web Docs — :nth-child()](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Selectors/:nth-child)
- [CSS 選擇器完整列表 — 菜鸟教程](https://www.runoob.com/cssref/css-selectors.html)
- [STEAM 教育學習網 — CSS 選擇器](https://steam.oxxostudio.tw/category/css/selector/about-selector.html)
- [Chrome Developers — :nth-child() of S 語法](https://developer.chrome.com/docs/css-ui/css-nth-child-of-s?hl=zh-tw)
- [新人日誌 — CSS first-child、last-child、nth-child 指南](https://realnewbie.com/posts/css-first-childlast-childnth-child-nth-of-type)
