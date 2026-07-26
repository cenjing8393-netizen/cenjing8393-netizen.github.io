---
title: HTML 語意化標籤入門
date: 2026-07-08
updated: 2026-07-10
tags:
  - HTML
  - SEO
  - Accessibility
  - Semantics
categories:
  - 前端
description: 我的 HTML 語意化標籤學習筆記，記錄 header、main、article 等常用語意標籤與完整頁面骨架範例。
---

![HTML 語意化標籤](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/blog-cover-accessibility.png)

## 為什麼要學

我剛學 HTML 的時候，很習慣什麼都用 `<div>` 包。左邊一個 div，右邊一個 div，全部塞進 div。

後來回頭看自己寫的 code，滿滿的 `<div class="header-wrapper">`、`<div class="content-container">`、`<div class="footer-box">`……我的 HTML 什麼都沒說，只是靠 class 名稱在解釋自己。

這就是為什麼需要語意化標籤。

## 學到的重點

語意化標籤就是用標籤名字來表達內容用途。與其寫 `<div class="nav">`，不如直接寫 `<nav>`。瀏覽器、搜尋引擎、螢幕閱讀器一看就知道這是什麼意思。

好處：
1. SEO 更好 — Google 知道哪裡是主要內容
2. 無障礙友善 — 螢幕閱讀器可以直接跳到 `<main>` 或 `<nav>`
3. 自己看得懂 — 三個月後回來改 code 不用猜

## 我常用的語意標籤

### `<header>` — 頁首

放 Logo、主標題、導覽列。一頁可以有多個 `<header>`，文章裡也可以有。

```html
<header>
  <h1>我的技術部落格</h1>
  <nav>
    <ul>
      <li><a href="/">首頁</a></li>
      <li><a href="/about">關於我</a></li>
    </ul>
  </nav>
</header>
```

### `<nav>` — 導覽區

包主要導覽連結，通常放 `<header>` 裡。

```html
<nav aria-label="主要選單">
  <ul>
    <li><a href="/posts">文章列表</a></li>
    <li><a href="/tags">標籤</a></li>
  </ul>
</nav>
```

### `<main>` — 主要內容

一頁只能有一個，放獨特內容，不要把導覽列或側邊欄塞進來。

### `<article>` — 獨立內容單元

部落格文章、新聞、產品卡片都適用。判斷方式：抽出來貼到別的地方還說得通嗎？

```html
<article>
  <h2>用 Flexbox 還是 Grid？</h2>
  <p>很多新手會問這個問題。其實重點很簡單……</p>
</article>
```

### `<section>` — 主題區塊

把相關內容分組。跟 `<article>` 的差別是：`<section>` 的內容脫離上下文可能會沒頭沒尾。

### `<aside>` — 補充資訊

側邊欄、相關文章、廣告。

### `<footer>` — 頁尾

版權宣告、聯絡方式。一頁可以有多個。

## 完整頁面骨架

把上面全部兜起來的結果：

```html
<body>
  <header>
    <h1>我的技術部落格</h1>
    <nav>
      <ul>
        <li><a href="/">首頁</a></li>
        <li><a href="/posts">文章</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <article>
      <header>
        <h2>HTML 語意化標籤入門</h2>
        <p>2026-07-08</p>
      </header>
      <section>
        <h3>為什麼要語意化？</h3>
        <p>內容……</p>
      </section>
    </article>

    <aside>
      <h3>相關文章</h3>
      <ul>
        <li><a href="/css-guide">CSS 入門</a></li>
      </ul>
    </aside>
  </main>

  <footer>
    <p>&copy; 2026 我的技術部落格</p>
  </footer>
</body>
```

## 學到的一句話

下次寫 HTML 的時候問自己：「這個 div 真的需要嗎？還是換成語意標籤更適合？」

![對比漫畫：div vs 語意化標籤](https://cdn.jsdelivr.net/gh/cenjing8393-netizen/tech-blog-images/images/blog-cover-semantic-comparison.png)

## 參考資料

- [MDN Web Docs — HTML 語意元素](https://developer.mozilla.org/zh-CN/docs/Glossary/Semantics)
- [iThome 鐵人賽 — HTML5 的語意標籤介紹](https://ithelp.ithome.com.tw/articles/10240446)
- [vocus — 我花了兩週學會 HTML：5 個語意標籤初學者真正需要](https://vocus.cc/article/690078ddfd897800017e9d4c)
- [愛立歐網路 — 2026 HTML 架構教學：從草稿到語意化版型](https://www.ileo.com.tw/school-detail/html5-website-structure-guide/)
- [W3C — HTML5 規範：The aside element](https://html.spec.whatwg.org/multipage/sections.html#the-aside-element)
- [新視野網頁設計 — HTML \<strong\>、\<b\>、\<em\> 標籤語意與正確用法](https://www.nsc.tw/article_detail/html-strong-b-em-tags-usage-guide)
- [文網股份 — HTML 語意標籤：提升網頁設計的語意結構與可訪問性](https://www.cx.com.tw/modules/news/article.php?storyid=135)
- [Sean 工作版 — HTML 5 基本語法、語意標籤、元素總整理](https://seanacnet.com/html/html5-tag/)
