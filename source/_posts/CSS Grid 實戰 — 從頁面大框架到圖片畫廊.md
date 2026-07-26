---
title: CSS Grid 實戰 — 從頁面大框架到圖片畫廊
date: 2026-07-11
updated: 2026-07-11
tags:
  - CSS
  - Grid
  - Layout
categories:
  - 前端
description: CSS Grid 的實戰學習筆記，記錄頁面大框架、Holy Grail 佈局、圖片畫廊、表單對齊四個場景與常用屬性。
---

![grid-areas-v2.png](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/grid-areas-v2.png)
## 為什麼學 Grid

Flexbox 處理一維（行或列）很強，但遇到同時要控制行和列的「二維佈局」，Grid 才是正確的工具。

Grid 的思考方式跟 Flexbox 不一樣：Flexbox 是內容優先（項目自己決定怎麼排列），Grid 是佈局優先（先畫好格線再把東西放進去）。

## 基本概念

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto 1fr auto;
  gap: 1rem;
}
```

`grid-template-columns` 定義欄寬，`grid-template-rows` 定義列高，`gap` 是間距。

### fr 單位

`fr` 是 Grid 最重要的單位，代表可用空間的比例：

```css
/* 三欄：1:2:1 比例 */
grid-template-columns: 1fr 2fr 1fr;
```

固定寬度也可以混用：

```css
/* 第一欄 200px，剩下按比例分 */
grid-template-columns: 200px 1fr 1fr;
```

### repeat() + minmax()

自動適應的欄位數量：

```css
grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
```

`auto-fill` 會盡可能塞入欄位，`minmax(250px, 1fr)` 讓每欄最小 250px、最大等分空間。

## 場景一：頁面大框架

最經典的「Header + Main + Footer」三行結構：

```css
.layout {
  display: grid;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
}

header { /* 自然在最上層 */ }
main   { /* flex: 1 的 Grid 版 */ }
footer { /* 黏在底部 */ }
```

跟 Flexbox 的黏底 footer 解法幾乎一樣，但 Grid 更適合這個場景，因為本身就是二維結構。

## 場景二：Holy Grail 佈局

經典的三欄 + header/footer，用 `grid-template-areas` 最直觀：

```css
.holy-grail {
  display: grid;
  grid-template-columns: 200px 1fr 180px;
  grid-template-rows: auto 1fr auto;
  grid-template-areas:
    "header  header  header"
    "nav     main    aside"
    "footer  footer  footer";
  min-height: 100vh;
  gap: 1rem;
}

header { grid-area: header; }
nav    { grid-area: nav; }
main   { grid-area: main; }
aside  { grid-area: aside; }
footer { grid-area: footer; }
```

每一格 `grid-template-areas` 對應一個 `grid-area` 名稱，視覺上就跟實際排版一模一樣，非常好懂。

## 場景三：圖片畫廊

讓某些圖片跨兩欄或兩列，製造不對稱的動態感：

```css
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  grid-auto-rows: 150px;
  gap: 0.75rem;
}

/* 每第 3 張圖片跨 2 欄 2 列 */
.gallery-item:nth-child(3n) {
  grid-column: span 2;
  grid-row: span 2;
}
```

`span 2` 的意思是跨越 2 條格線（佔 2 格），不用精確計算位置。

## 場景四：表單對齊

跟 Flexbox 版類似，但用 Grid 可以更精準控制 Label 和 Input 的對齊：

```css
.form-grid {
  display: grid;
  grid-template-columns: 140px 1fr;
  gap: 1rem;
  align-items: center;
  max-width: 500px;
}

.form-grid label {
  text-align: right;
}

/* 跨兩欄的元素（例如送出按鈕） */
.form-grid .full-width {
  grid-column: 1 / -1;
}
```

`grid-column: 1 / -1` 從第一條格線到最後一條，等同於「跨全部欄位」。

## 學到的心得

- Grid 是「先畫格子再填東西」，Flexbox 是「東西自己排排站」
- `grid-template-areas` 讓版面結構一目瞭然
- `repeat(auto-fill, minmax(...))` 是 RWD 最強組合
- 大框架用 Grid，元件內部用 Flexbox，兩者互補


- [MDN — CSS Grid Layout](https://developer.mozilla.org/zh-TW/docs/Web/CSS/CSS_Grid_Layout)
- [CSS Tricks — A Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)
- [Bosh 的技術探索筆記 — CSS Grid](https://notes.boshkuo.com/docs/HTML_CSS/css-grid)
- [KD Tech Blog — Grid 網頁排版技巧入門教學筆記](https://tech.kdchang.com/blog/learning-notes-css-grid-intro-tutorial)
- [阮一峰 — CSS Grid 網格佈局教程](https://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html)
- [DEV Community — CSS Grid: The Complete Guide (2026)](https://dev.to/armorbreak/css-grid-the-complete-guide-to-layout-mastery-2026-4bcm)
