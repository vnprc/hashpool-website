+++
title = "The Life of a Mining Epoch"
slug = "mining-epochs"
template = "article.html"
description = """
Follow one mining share through hashpool: how it becomes ehash, what an epoch is, why freshly won ehash waits a few blocks before it can be spent, and how a blockchain reorg quietly unwinds without anyone losing anything. No ecash background needed.
"""
+++

Hashpool pays miners in ehash — digital cash notes backed by mining work. Every one of those notes is born, matures, and lives out its life inside an <em>epoch</em>: one round of the pool's history, bookended by block wins.

This page follows a single share all the way through that story. By the end you will know what an epoch is, why brand-new ehash waits a few blocks before it can be spent, and why a blockchain reorg costs nobody anything.

If you are new to hashpool itself, [What is Hashpool?](@/articles/what-is-hashpool.md) is the friendly introduction. You don't need any cashu or ecash background to read this page.

### A Share Is Born

A mining machine makes millions of guesses per second at a puzzle, and almost every guess misses.

A guess that comes close is still worth something: it proves the machine is genuinely working. Pools call these near-misses **shares**, and miners send a steady stream of them upstream. A share that proves more work counts for more.

Once in a very long while, a share doesn't just come close — it actually solves the puzzle. That share is a new **block**, and it carries the reward the whole pool has been working toward.

<figure class="epoch-fig">
<svg viewBox="0 0 640 190" role="img" aria-label="A miner sends a stream of small diamond-shaped shares to the pool. One larger share, marked with a star, also solves a block." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d1-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<path id="d1-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
<marker id="d1-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<rect class="card" x="24" y="58" width="120" height="80" rx="10" fill="#fff" stroke="#e5e5e5"/>
<rect class="sN" x="64" y="74" width="40" height="26" rx="4" fill="none" stroke="#6c6c6c" stroke-width="1.5"/>
<circle class="sN" cx="76" cy="87" r="7" fill="none" stroke="#6c6c6c" stroke-width="1.5"/>
<line class="sN" x1="90" y1="80" x2="90" y2="94" stroke="#6c6c6c"/>
<line class="sN" x1="96" y1="80" x2="96" y2="94" stroke="#6c6c6c"/>
<text x="84" y="122" text-anchor="middle" font-size="13" fill="#1f1f1f">your miner</text>
<rect class="card" x="496" y="58" width="120" height="80" rx="10" fill="#fff" stroke="#e5e5e5"/>
<rect class="sN" x="528" y="70" width="56" height="12" rx="3" fill="none" stroke="#6c6c6c" stroke-width="1.5"/>
<rect class="sN" x="528" y="87" width="56" height="12" rx="3" fill="none" stroke="#6c6c6c" stroke-width="1.5"/>
<circle class="fN" cx="537" cy="76" r="1.7" fill="#6c6c6c"/>
<circle class="fN" cx="537" cy="93" r="1.7" fill="#6c6c6c"/>
<text x="556" y="122" text-anchor="middle" font-size="13" fill="#1f1f1f">the pool</text>
<use href="#d1-sh" class="fA" x="176" y="92" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="206" y="102" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="236" y="90" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="266" y="100" fill="#b45309"/>
<use href="#d1-st" class="fI" x="300" y="72" fill="#1e1e1e"/>
<use href="#d1-sh" class="fA" transform="translate(300 96) scale(1.7)" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="334" y="90" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="364" y="102" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="394" y="92" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="424" y="100" fill="#b45309"/>
<use href="#d1-sh" class="fA" x="454" y="94" fill="#b45309"/>
<line class="sBd" x1="466" y1="96" x2="490" y2="96" stroke="#c9c9c9" stroke-width="1.5" marker-end="url(#d1-ar)"/>
<line class="sBd" x1="300" y1="108" x2="300" y2="122" stroke="#c9c9c9"/>
<text class="t2" x="300" y="136" text-anchor="middle" font-size="12" fill="#6c6c6c">one in millions also solves a block</text>
<use href="#d1-sh" class="fA" x="180" y="158" fill="#b45309"/>
<text class="t2" x="194" y="162" font-size="12" fill="#6c6c6c">= one share, proof of honest work</text>
</svg>
<figcaption><p>Shares flow from miner to pool, each one proof of effort. The rare share that also solves a block is the whole game.</p></figcaption>
</figure>

### The Mint Writes It Down

Hashpool's pool hands every accepted share to its cashier — a piece of software called the **mint**.

The mint keeps a book. For each share it writes one entry: this share arrived, it is worth this much, and it may be cashed in later. An entry in that book is called a **quote**. Nothing has been handed out yet — a quote is just the mint's written promise.

<figure class="epoch-fig">
<svg viewBox="0 0 640 220" role="img" aria-label="Shares arrive at the mint's book, where each becomes one row: a quote with an amount." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d2-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<marker id="d2-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<use href="#d2-sh" class="fA" x="44" y="104" fill="#b45309"/>
<use href="#d2-sh" class="fA" x="78" y="112" fill="#b45309"/>
<use href="#d2-sh" class="fA" x="112" y="106" fill="#b45309"/>
<line class="sBd" x1="130" y1="108" x2="184" y2="108" stroke="#c9c9c9" stroke-width="1.5" marker-end="url(#d2-ar)"/>
<rect class="card" x="196" y="30" width="300" height="160" rx="10" fill="#fff" stroke="#e5e5e5"/>
<text class="t1" x="346" y="56" text-anchor="middle" font-size="14" font-weight="600" fill="#1e1e1e">the mint's book</text>
<line class="sBd" x1="216" y1="68" x2="476" y2="68" stroke="#e5e5e5"/>
<use href="#d2-sh" class="fA" x="230" y="93" fill="#b45309"/>
<text class="t2" x="246" y="98" font-size="12.5" font-family="monospace" fill="#6c6c6c">share #4211</text>
<line class="sBd" x1="340" y1="94" x2="420" y2="94" stroke="#e5e5e5" stroke-dasharray="2 4"/>
<text x="464" y="98" text-anchor="end" font-size="13.5" font-family="monospace" fill="#1f1f1f">64</text>
<use href="#d2-sh" class="fA" x="230" y="127" fill="#b45309"/>
<text class="t2" x="246" y="132" font-size="12.5" font-family="monospace" fill="#6c6c6c">share #4212</text>
<line class="sBd" x1="340" y1="128" x2="420" y2="128" stroke="#e5e5e5" stroke-dasharray="2 4"/>
<text x="464" y="132" text-anchor="end" font-size="13.5" font-family="monospace" fill="#1f1f1f">32</text>
<use href="#d2-sh" class="fA" x="230" y="161" fill="#b45309"/>
<text class="t2" x="246" y="166" font-size="12.5" font-family="monospace" fill="#6c6c6c">share #4213</text>
<line class="sBd" x1="340" y1="162" x2="420" y2="162" stroke="#e5e5e5" stroke-dasharray="2 4"/>
<text x="464" y="166" text-anchor="end" font-size="13.5" font-family="monospace" fill="#1f1f1f">128</text>
<text class="t2" x="346" y="210" text-anchor="middle" font-size="12.5" fill="#6c6c6c">each entry is a quote — the mint's written promise</text>
</svg>
<figcaption><p>One share, one quote. A bigger proof of work gets a bigger entry.</p></figcaption>
</figure>

### Quotes Become ehash

Your wallet checks the book, finds your quotes, and cashes them in.

What it gets back are **ehash** notes: bearer tokens, like paper banknotes. Whoever holds them owns them. The cashing-in uses blind signatures, so the mint cannot tell which notes ended up in whose wallet — [What is Hashpool?](@/articles/what-is-hashpool.md) explains that trick.

<figure class="epoch-fig">
<svg viewBox="0 0 640 240" role="img" aria-label="Quotes in the mint's book are cashed in and come out as ehash notes, drawn like small banknotes, each carrying a stamp." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d3-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<marker id="d3-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<rect class="card" x="30" y="45" width="240" height="150" rx="10" fill="#fff" stroke="#e5e5e5"/>
<text class="t1" x="150" y="69" text-anchor="middle" font-size="13" font-weight="600" fill="#1e1e1e">the mint's book</text>
<line class="sBd" x1="48" y1="79" x2="252" y2="79" stroke="#e5e5e5"/>
<use href="#d3-sh" class="fA" x="60" y="100" fill="#b45309"/>
<text x="78" y="105" font-size="13" font-family="monospace" fill="#1f1f1f">128</text>
<rect class="sA" x="170" y="89" width="66" height="22" rx="11" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/>
<text x="203" y="104" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text>
<use href="#d3-sh" class="fA" x="60" y="132" fill="#b45309"/>
<text x="78" y="137" font-size="13" font-family="monospace" fill="#1f1f1f">64</text>
<rect class="sA" x="170" y="121" width="66" height="22" rx="11" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/>
<text x="203" y="136" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text>
<use href="#d3-sh" class="fA" x="60" y="164" fill="#b45309"/>
<text x="78" y="169" font-size="13" font-family="monospace" fill="#1f1f1f">32</text>
<rect class="sA" x="170" y="153" width="66" height="22" rx="11" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/>
<text x="203" y="168" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text>
<text class="t2" x="308" y="102" text-anchor="middle" font-size="12" fill="#6c6c6c">your wallet</text>
<text class="t2" x="308" y="117" text-anchor="middle" font-size="12" fill="#6c6c6c">cashes in</text>
<line class="sBd" x1="282" y1="128" x2="334" y2="128" stroke="#c9c9c9" stroke-width="1.5" marker-end="url(#d3-ar)"/>
<g transform="translate(416 138) rotate(-2)">
<rect class="sA" width="150" height="78" rx="8" fill="#b45309" fill-opacity="0.1" stroke="#b45309" stroke-width="1.4"/>
<rect class="sA" x="6" y="6" width="138" height="66" rx="5" fill="none" stroke="#b45309" stroke-opacity="0.5" stroke-dasharray="3 3"/>
<text class="t1" x="16" y="30" font-size="16" font-weight="700" font-family="monospace" fill="#1e1e1e">32</text>
<text class="t2" x="16" y="46" font-size="10.5" fill="#6c6c6c">ehash</text>
<rect class="sA" x="74" y="50" width="66" height="19" rx="4" fill="none" stroke="#b45309"/>
<text x="107" y="63" text-anchor="middle" font-size="9.5" font-family="monospace" fill="#1f1f1f">840000</text>
</g>
<g transform="translate(392 84) rotate(1)">
<rect class="sA" width="150" height="78" rx="8" fill="#b45309" fill-opacity="0.1" stroke="#b45309" stroke-width="1.4"/>
<rect class="sA" x="6" y="6" width="138" height="66" rx="5" fill="none" stroke="#b45309" stroke-opacity="0.5" stroke-dasharray="3 3"/>
<text class="t1" x="16" y="30" font-size="16" font-weight="700" font-family="monospace" fill="#1e1e1e">64</text>
<text class="t2" x="16" y="46" font-size="10.5" fill="#6c6c6c">ehash</text>
<rect class="sA" x="74" y="50" width="66" height="19" rx="4" fill="none" stroke="#b45309"/>
<text x="107" y="63" text-anchor="middle" font-size="9.5" font-family="monospace" fill="#1f1f1f">840000</text>
</g>
<g transform="translate(368 30) rotate(-1)">
<rect class="sA" width="150" height="78" rx="8" fill="#b45309" fill-opacity="0.1" stroke="#b45309" stroke-width="1.4"/>
<rect class="sA" x="6" y="6" width="138" height="66" rx="5" fill="none" stroke="#b45309" stroke-opacity="0.5" stroke-dasharray="3 3"/>
<text class="t1" x="16" y="30" font-size="16" font-weight="700" font-family="monospace" fill="#1e1e1e">128</text>
<text class="t2" x="16" y="46" font-size="10.5" fill="#6c6c6c">ehash</text>
<rect class="sA" x="74" y="50" width="66" height="19" rx="4" fill="none" stroke="#b45309"/>
<text x="107" y="63" text-anchor="middle" font-size="9.5" font-family="monospace" fill="#1f1f1f">840000</text>
</g>
</svg>
<figcaption><p>Quotes leave the book and come out as ehash notes in your wallet. Notice the little stamp on each note — that's next.</p></figcaption>
</figure>

### Every Epoch Is Its Own Money

The pool's life is divided into rounds. A round begins when the pool wins a block and ends when it wins the next one. In hashpool, these rounds are called **epochs**.

Each epoch issues its own money. Every ehash note is stamped with the epoch that minted it, and the epoch is named after a block height: the height of the winning block that opened it — the spot on the chain where the last reward landed.

<figure class="epoch-fig">
<svg viewBox="0 0 640 190" role="img" aria-label="A close-up of one ehash note showing its face value and its series stamp, which names the epoch that minted it." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d4b-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
</defs>
<rect class="sA" x="40" y="35" width="270" height="120" rx="10" fill="#b45309" fill-opacity="0.08" stroke="#b45309" stroke-width="1.6"/>
<rect class="sA" x="48" y="43" width="254" height="104" rx="6" fill="none" stroke="#b45309" stroke-opacity="0.5" stroke-dasharray="4 4"/>
<use href="#d4b-sh" class="fA" transform="translate(235 68) scale(2.6)" fill="#b45309" fill-opacity="0.18"/>
<text class="t1" x="66" y="92" font-size="30" font-weight="700" font-family="monospace" fill="#1e1e1e">128</text>
<text class="t2" x="66" y="114" font-size="12" fill="#6c6c6c">ehash</text>
<rect class="sA" x="164" y="98" width="124" height="28" rx="6" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/>
<text x="226" y="117" text-anchor="middle" font-size="12.5" font-family="monospace" fill="#1f1f1f">epoch 840000</text>
<line class="sBd" x1="313" y1="82" x2="352" y2="70" stroke="#c9c9c9"/>
<text x="360" y="63" font-size="13" fill="#1f1f1f">face value — how much</text>
<text x="360" y="80" font-size="13" fill="#1f1f1f">work this note stands for</text>
<line class="sBd" x1="292" y1="112" x2="352" y2="128" stroke="#c9c9c9"/>
<text x="360" y="126" font-size="13" fill="#1f1f1f">series stamp — the epoch</text>
<text x="360" y="143" font-size="13" fill="#1f1f1f">that minted this note</text>
</svg>
<figcaption><p>Two notes from the same epoch are interchangeable. Notes from different epochs are different money — like banknote series with different years printed on them.</p></figcaption>
</figure>

Why separate money for each round? Because all the shares in one epoch were part of the same chase for the same next reward. They belong together, and it would be unfair to mix them with another round's work.

On the blockchain, the pool's history looks like colored spans between wins:

<figure class="epoch-fig">
<svg viewBox="0 0 640 200" role="img" aria-label="A chain of blocks with two colored spans beneath it: epoch 840000 begins at a starred winning block at height 840000 and ends where a second starred winning block at height 840112 begins the next epoch." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d4a-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
<marker id="d4a-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<text x="48" y="44" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f">840000</text>
<text x="298" y="44" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f">840112</text>
<rect class="blk" x="30" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="sA" x="30" y="54" width="36" height="36" rx="7" fill="#b45309" fill-opacity="0.16" stroke="#b45309" stroke-width="1.5"/>
<use href="#d4a-st" class="fI" x="63" y="52" fill="#1e1e1e"/>
<rect class="lnk" x="66" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="80" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="116" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="130" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<text class="t2" x="198" y="78" text-anchor="middle" font-size="16" fill="#6c6c6c">···</text>
<rect class="blk" x="230" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="266" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="280" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="sB" x="280" y="54" width="36" height="36" rx="7" fill="#0d9488" fill-opacity="0.16" stroke="#0d9488" stroke-width="1.5"/>
<use href="#d4a-st" class="fI" x="313" y="52" fill="#1e1e1e"/>
<rect class="lnk" x="316" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="330" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="366" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="380" y="54" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="416" y="68" width="14" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="sBd" x="430" y="54" width="36" height="36" rx="7" fill="none" stroke="#c9c9c9" stroke-dasharray="4 3"/>
<line class="sBd" x1="48" y1="94" x2="48" y2="104" stroke="#c9c9c9" marker-end="url(#d4a-ar)"/>
<line class="sBd" x1="298" y1="94" x2="298" y2="104" stroke="#c9c9c9" marker-end="url(#d4a-ar)"/>
<rect class="fA" x="30" y="108" width="245" height="18" rx="4" fill="#b45309" fill-opacity="0.16"/>
<text x="152" y="121" text-anchor="middle" font-size="12" font-family="monospace" fill="#1f1f1f">epoch 840000</text>
<rect class="fB" x="280" y="108" width="200" height="18" rx="4" fill="#0d9488" fill-opacity="0.16"/>
<text x="380" y="121" text-anchor="middle" font-size="12" font-family="monospace" fill="#1f1f1f">epoch 840112</text>
<text class="t2" x="492" y="121" font-size="14" fill="#6c6c6c">→</text>
<text class="t2" x="320" y="165" text-anchor="middle" font-size="13" fill="#6c6c6c">every time a reward lands, the color changes — a new epoch begins</text>
</svg>
<figcaption><p>The pool's history, colored by epoch. A star marks a winning block; its height names the epoch it opens.</p></figcaption>
</figure>

One aside for the curious: under the hood, an epoch's full name also includes the pool's public key, so a single mint can serve many pools without their ehash ever getting mixed up. That's the whole story of the name — a pool and a height.

### The Pool Wins a Block

Now the big moment. One of those millions of shares actually solves the puzzle, and the pool's block joins the chain.

A block's very first transaction — called the **coinbase** — is the one that creates brand-new bitcoin. In hashpool, the coinbase pays that reward straight to the mint's address.

Nobody has to tell the mint it won. The mint watches the blockchain itself and recognizes its own address in the new block. A message can get lost; a payment recorded on the chain cannot.

<figure class="epoch-fig">
<svg viewBox="0 0 640 230" role="img" aria-label="The winning block's first transaction, the coinbase, pays the newly created reward to the mint's address. The mint sees it by watching the chain." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d5-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
<marker id="d5-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<rect class="blk" x="80" y="44" width="120" height="120" rx="10" fill="#fff" stroke="#6c6c6c"/>
<rect class="sB" x="80" y="44" width="120" height="120" rx="10" fill="#0d9488" fill-opacity="0.08" stroke="#0d9488" stroke-width="1.6"/>
<use href="#d5-st" class="fI" x="196" y="42" fill="#1e1e1e"/>
<rect class="sB" x="96" y="78" width="88" height="22" rx="4" fill="#0d9488" fill-opacity="0.22" stroke="#0d9488"/>
<text x="140" y="93" text-anchor="middle" font-size="10.5" fill="#1f1f1f">new coins</text>
<rect class="fN" x="96" y="112" width="88" height="10" rx="3" fill="#6c6c6c" fill-opacity="0.18"/>
<rect class="fN" x="96" y="130" width="88" height="10" rx="3" fill="#6c6c6c" fill-opacity="0.18"/>
<rect class="fN" x="96" y="148" width="60" height="10" rx="3" fill="#6c6c6c" fill-opacity="0.18"/>
<text x="140" y="186" text-anchor="middle" font-size="12" font-family="monospace" fill="#1f1f1f">block 840112</text>
<text class="t2" x="140" y="70" font-size="10.5" fill="#6c6c6c" text-anchor="middle">the coinbase ↓</text>
<path class="sBd" d="M188 89C270 66 320 82 392 106" fill="none" stroke="#c9c9c9" stroke-width="1.5" marker-end="url(#d5-ar)"/>
<circle class="sA" cx="290" cy="78" r="13" fill="#b45309" fill-opacity="0.15" stroke="#b45309" stroke-width="1.5"/>
<circle class="sA" cx="290" cy="78" r="8.5" fill="none" stroke="#b45309" stroke-opacity="0.6" stroke-dasharray="3 3"/>
<text class="t2" x="290" y="52" text-anchor="middle" font-size="12" fill="#6c6c6c">the block reward</text>
<rect class="card" x="400" y="84" width="176" height="86" rx="10" fill="#fff" stroke="#e5e5e5"/>
<path class="fN" d="M470 114l18-11 18 11z" fill="#6c6c6c" fill-opacity="0.5"/>
<rect class="fN" x="474" y="117" width="6" height="18" fill="#6c6c6c" fill-opacity="0.5"/>
<rect class="fN" x="485" y="117" width="6" height="18" fill="#6c6c6c" fill-opacity="0.5"/>
<rect class="fN" x="496" y="117" width="6" height="18" fill="#6c6c6c" fill-opacity="0.5"/>
<rect class="fN" x="470" y="137" width="36" height="4" fill="#6c6c6c" fill-opacity="0.5"/>
<text x="488" y="160" text-anchor="middle" font-size="12.5" fill="#1f1f1f">the mint's address</text>
<text class="t2" x="320" y="212" text-anchor="middle" font-size="12.5" fill="#6c6c6c">no announcement needed — the mint reads the chain itself</text>
</svg>
<figcaption><p>The reward lands at the mint's address, written into the chain for everyone — including the mint — to see.</p></figcaption>
</figure>

### The Epoch Turns Over

The moment that reward lands, the old epoch closes and a new one opens, named after the winning block's height.

The turnover is instant on purpose. The very next share to arrive is already part of the new round, so it gets stamped with the new epoch's name. If rotation waited, late shares would leak into the old round and water down what the people in that round had earned.

<figure class="epoch-fig">
<svg viewBox="0 0 640 250" role="img" aria-label="A close-up of the boundary: the winning block at height 840112 ends epoch 840000 and starts epoch 840112. Shares mined before the boundary carry the old stamp; shares mined after carry the new one." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d6-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<path id="d6-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
<marker id="d6-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<text class="t1" x="330" y="22" text-anchor="middle" font-size="12.5" font-weight="600" fill="#1e1e1e">the reward lands — the boundary</text>
<line class="sN" x1="327" y1="28" x2="327" y2="196" stroke="#6c6c6c" stroke-dasharray="5 4" stroke-width="1.2"/>
<rect class="blk" x="120" y="44" width="48" height="48" rx="8" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="168" y="64" width="22" height="8" fill="#6c6c6c" fill-opacity="0.3"/>
<rect class="blk" x="190" y="44" width="48" height="48" rx="8" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="238" y="64" width="22" height="8" fill="#6c6c6c" fill-opacity="0.3"/>
<rect class="blk" x="260" y="44" width="48" height="48" rx="8" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="308" y="64" width="22" height="8" fill="#6c6c6c" fill-opacity="0.3"/>
<rect class="blk" x="330" y="44" width="48" height="48" rx="8" fill="#fff" stroke="#6c6c6c"/>
<rect class="sB" x="330" y="44" width="48" height="48" rx="8" fill="#0d9488" fill-opacity="0.16" stroke="#0d9488" stroke-width="1.5"/>
<use href="#d6-st" class="fI" x="374" y="40" fill="#1e1e1e"/>
<rect class="lnk" x="378" y="64" width="22" height="8" fill="#6c6c6c" fill-opacity="0.3"/>
<rect class="blk" x="400" y="44" width="48" height="48" rx="8" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="448" y="64" width="22" height="8" fill="#6c6c6c" fill-opacity="0.3"/>
<rect class="sBd" x="470" y="44" width="48" height="48" rx="8" fill="none" stroke="#c9c9c9" stroke-dasharray="4 3"/>
<text class="t2" x="284" y="106" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840111</text>
<text class="t2" x="354" y="106" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840112</text>
<rect class="fA" x="120" y="118" width="204" height="18" rx="4" fill="#b45309" fill-opacity="0.16"/>
<text x="222" y="131" text-anchor="middle" font-size="11.5" font-family="monospace" fill="#1f1f1f">epoch 840000</text>
<rect class="fB" x="330" y="118" width="210" height="18" rx="4" fill="#0d9488" fill-opacity="0.16"/>
<text x="435" y="131" text-anchor="middle" font-size="11.5" font-family="monospace" fill="#1f1f1f">epoch 840112</text>
<use href="#d6-sh" class="fA" x="200" y="170" fill="#b45309"/>
<use href="#d6-sh" class="fA" x="226" y="178" fill="#b45309"/>
<use href="#d6-sh" class="fA" x="252" y="168" fill="#b45309"/>
<line class="sBd" x1="226" y1="160" x2="226" y2="142" stroke="#c9c9c9" marker-end="url(#d6-ar)"/>
<text class="t2" x="226" y="200" text-anchor="middle" font-size="12" fill="#6c6c6c">shares before the win</text>
<text class="t2" x="226" y="216" text-anchor="middle" font-size="12" fill="#6c6c6c">→ old stamp</text>
<use href="#d6-sh" class="fB" x="404" y="170" fill="#0d9488"/>
<use href="#d6-sh" class="fB" x="430" y="178" fill="#0d9488"/>
<use href="#d6-sh" class="fB" x="456" y="168" fill="#0d9488"/>
<line class="sBd" x1="430" y1="160" x2="430" y2="142" stroke="#c9c9c9" marker-end="url(#d6-ar)"/>
<text class="t2" x="430" y="200" text-anchor="middle" font-size="12" fill="#6c6c6c">shares after the win</text>
<text class="t2" x="430" y="216" text-anchor="middle" font-size="12" fill="#6c6c6c">→ new stamp</text>
</svg>
<figcaption><p>The reward's own block starts the new epoch, and the very next share is stamped with the new name.</p></figcaption>
</figure>

There is one catch: the brand-new epoch starts life on probation. That is the next idea, and it's the most important one on this page.

### The Maturity Window

For the first few blocks after a win, the new epoch's quotes are marked <em>waiting</em>. They sit safely in the mint's book, but they cannot be cashed into notes yet.

Why wait? Because the blockchain is allowed to change its mind about its newest blocks — we'll watch that happen in the next section — and printing a note is the one thing hashpool can never undo. So the mint holds the new epoch's quotes until the winning block has **six confirmations** — the block itself plus five more built on top, the same standard the rest of the bitcoin economy uses for finality. Then the epoch is <em>final</em>, and every waiting quote unlocks at once.

While the clock runs, two things are worth noticing:

- **The old epoch is untouched.** Every quote and note from before the win stays spendable the whole time.
- **Nothing real is delayed.** Bitcoin itself locks every block reward for 100 blocks before it can be spent. The six-block wait ends long before there was anything to spend anyway.

Miners on ordinary pools already know this feeling: it is the classic "immature balance" that appears after a pool finds a block. Hashpool just wears it openly.

<figure class="epoch-fig epoch-anim">
<svg viewBox="0 0 640 330" role="img" aria-label="Animation: after the winning block at 840112, five more blocks arrive one by one and the confirmation count climbs from one to six. At six, the epoch becomes final and its quotes flip from waiting to ready. A scale bar shows the six-block wait is tiny next to the 100-block lock bitcoin puts on the reward itself." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d7-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<path id="d7-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
</defs>
<rect class="blk" x="30" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="sB" x="30" y="44" width="36" height="36" rx="7" fill="#0d9488" fill-opacity="0.16" stroke="#0d9488" stroke-width="1.5"/>
<use href="#d7-st" class="fI" x="63" y="42" fill="#1e1e1e"/>
<text class="t2" x="48" y="96" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840112</text>
<g class="an a-p1"><rect class="lnk" x="66" y="58" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="76" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/></g>
<g class="an a-p2"><rect class="lnk" x="112" y="58" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="122" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/></g>
<g class="an a-p3"><rect class="lnk" x="158" y="58" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="168" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/></g>
<g class="an a-p4"><rect class="lnk" x="204" y="58" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="214" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/></g>
<g class="an a-p5"><rect class="lnk" x="250" y="58" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="260" y="44" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/></g>
<rect class="sBd" x="306" y="44" width="36" height="36" rx="7" fill="none" stroke="#c9c9c9" stroke-dasharray="4 3"/>
<text class="t2" x="518" y="52" text-anchor="middle" font-size="12.5" fill="#6c6c6c">confirmations</text>
<g font-family="monospace" font-size="24" font-weight="700" text-anchor="middle">
<text class="an a-c1" x="518" y="86" fill="#1e1e1e" opacity="0">1 / 6</text>
<text class="an a-c2" x="518" y="86" fill="#1e1e1e" opacity="0">2 / 6</text>
<text class="an a-c3" x="518" y="86" fill="#1e1e1e" opacity="0">3 / 6</text>
<text class="an a-c4" x="518" y="86" fill="#1e1e1e" opacity="0">4 / 6</text>
<text class="an a-c5" x="518" y="86" fill="#1e1e1e" opacity="0">5 / 6</text>
<text class="an a-c6" x="518" y="86" fill="#1e1e1e">6 / 6</text>
</g>
<g class="an a-fin"><text class="t1" x="518" y="112" text-anchor="middle" font-size="13" font-weight="600" fill="#1e1e1e">epoch 840112 is final</text><text class="t2" x="518" y="129" text-anchor="middle" font-size="11.5" fill="#6c6c6c">every waiting quote unlocks</text></g>
<rect class="fB" x="30" y="112" width="312" height="16" rx="4" fill="#0d9488" fill-opacity="0.16"/>
<rect class="an a-pre sB" x="30" y="112" width="312" height="16" rx="4" fill="none" stroke="#0d9488" stroke-dasharray="5 4" opacity="0"/>
<rect class="an a-fin sB" x="30" y="112" width="312" height="16" rx="4" fill="none" stroke="#0d9488"/>
<text class="an a-pre" x="186" y="124" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f" opacity="0">epoch 840112 — on hold</text>
<text class="an a-fin" x="186" y="124" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f">epoch 840112 — final</text>
<rect class="card" x="30" y="168" width="310" height="140" rx="10" fill="#fff" stroke="#e5e5e5"/>
<text class="t1" x="185" y="192" text-anchor="middle" font-size="13" font-weight="600" fill="#1e1e1e">the mint's book — epoch 840112</text>
<line class="sBd" x1="48" y1="202" x2="322" y2="202" stroke="#e5e5e5"/>
<use href="#d7-sh" class="fB" x="60" y="223" fill="#0d9488"/>
<text x="80" y="228" font-size="13" font-family="monospace" fill="#1f1f1f">64</text>
<g class="an a-dim"><rect class="sN" x="122" y="212" width="76" height="22" rx="11" fill="none" stroke="#6c6c6c" stroke-dasharray="3 3"/><text class="t2" x="160" y="227" text-anchor="middle" font-size="11" fill="#6c6c6c">waiting…</text></g>
<text class="t2" x="212" y="227" font-size="11" fill="#6c6c6c">→</text>
<g class="an a-lit"><rect class="sB" x="228" y="212" width="76" height="22" rx="11" fill="#0d9488" fill-opacity="0.12" stroke="#0d9488"/><text x="266" y="227" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text></g>
<use href="#d7-sh" class="fB" x="60" y="255" fill="#0d9488"/>
<text x="80" y="260" font-size="13" font-family="monospace" fill="#1f1f1f">32</text>
<g class="an a-dim"><rect class="sN" x="122" y="244" width="76" height="22" rx="11" fill="none" stroke="#6c6c6c" stroke-dasharray="3 3"/><text class="t2" x="160" y="259" text-anchor="middle" font-size="11" fill="#6c6c6c">waiting…</text></g>
<text class="t2" x="212" y="259" font-size="11" fill="#6c6c6c">→</text>
<g class="an a-lit"><rect class="sB" x="228" y="244" width="76" height="22" rx="11" fill="#0d9488" fill-opacity="0.12" stroke="#0d9488"/><text x="266" y="259" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text></g>
<use href="#d7-sh" class="fB" x="60" y="287" fill="#0d9488"/>
<text x="80" y="292" font-size="13" font-family="monospace" fill="#1f1f1f">16</text>
<g class="an a-dim"><rect class="sN" x="122" y="276" width="76" height="22" rx="11" fill="none" stroke="#6c6c6c" stroke-dasharray="3 3"/><text class="t2" x="160" y="291" text-anchor="middle" font-size="11" fill="#6c6c6c">waiting…</text></g>
<text class="t2" x="212" y="291" font-size="11" fill="#6c6c6c">→</text>
<g class="an a-lit"><rect class="sB" x="228" y="276" width="76" height="22" rx="11" fill="#0d9488" fill-opacity="0.12" stroke="#0d9488"/><text x="266" y="291" text-anchor="middle" font-size="11" fill="#1f1f1f">ready ✓</text></g>
<text class="t2" x="490" y="196" text-anchor="middle" font-size="12.5" fill="#6c6c6c">how long is six blocks, really?</text>
<rect class="fN" x="370" y="228" width="240" height="12" rx="6" fill="#6c6c6c" fill-opacity="0.15"/>
<rect class="fB" x="370" y="228" width="15" height="12" rx="6" fill="#0d9488"/>
<line class="sB" x1="385" y1="222" x2="385" y2="246" stroke="#0d9488"/>
<text x="376" y="216" font-size="11" fill="#1f1f1f">ehash unlocks: 6</text>
<g class="sN" stroke="#6c6c6c" fill="none"><path d="M596 224v-4a6 6 0 0 1 12 0v4"/><rect x="593" y="224" width="18" height="13" rx="2"/></g>
<text x="612" y="216" text-anchor="end" font-size="11" fill="#1f1f1f">the reward itself: 100</text>
<text class="t2" x="490" y="272" text-anchor="middle" font-size="11.5" fill="#6c6c6c">bitcoin locks every block reward for 100 blocks —</text>
<text class="t2" x="490" y="288" text-anchor="middle" font-size="11.5" fill="#6c6c6c">the six-block wait ends long before</text>
<text class="t2" x="490" y="304" text-anchor="middle" font-size="11.5" fill="#6c6c6c">there is anything to spend</text>
</svg>
<figcaption><p>The maturity window: one confirmation per new block, and at six the epoch is final — every waiting quote flips to ready. The bar shows why nothing real is lost in the wait.</p></figcaption>
</figure>

### When the Chain Changes Its Mind

Sometimes two miners find a block at nearly the same moment, and the network briefly disagrees about the newest link of the chain. One branch soon grows longer and wins; blocks on the losing branch are <em>orphaned</em> — struck from history. This is a **reorg**, and at shallow depths bitcoin does it routinely.

So suppose the worst: the pool's winning block gets orphaned before its six confirmations arrive, and the replacement block pays someone else. On the chain, that reward now never happened.

Hashpool's answer is quiet: the epoch that block opened simply dissolves. Every quote stamped into the young epoch slides back into the previous epoch — the round that, it turns out, never ended — and unlocks immediately, because that older epoch settled long ago. The shares were honest work, and they still count in full.

Nobody loses anything, because nothing irreversible ever happened: thanks to the maturity window, not a single note of the young epoch was printed. Quotes are just entries in a book, and entries can be moved. This is exactly the disaster the window exists for — met, absorbed, and shrugged off.

<figure class="epoch-fig epoch-anim">
<svg viewBox="0 0 640 490" role="img" aria-label="Animation: the pool's block at height 840112 wins and a provisional epoch opens. A competing block at the same height appears and its branch grows longer, so the pool's block is orphaned. The young epoch dissolves, its quotes slide back into epoch 840000's page of the book, and they are immediately ready — nothing was lost." xmlns="http://www.w3.org/2000/svg">
<defs>
<path id="d8-sh" d="M0 -6L6 0 0 6 -6 0Z"/>
<path id="d8-st" d="M0 -7L1.65 -2.27 6.66 -2.16 2.66 0.87 4.11 5.66 0 2.8 -4.11 5.66 -2.66 0.87 -6.66 -2.16 -1.65 -2.27Z"/>
<marker id="d8-ar" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5 0 10z" fill="#6c6c6c"/></marker>
</defs>
<rect class="blk" x="30" y="64" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<rect class="lnk" x="66" y="78" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/>
<rect class="blk" x="76" y="64" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/>
<text class="t2" x="94" y="116" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840111</text>
<path class="sBd" d="M112 82h16v-44h12" fill="none" stroke="#c9c9c9" stroke-width="1.5"/>
<path class="sBd" d="M112 82h16v44h12" fill="none" stroke="#c9c9c9" stroke-width="1.5"/>
<g class="an a-up1"><rect class="blk" x="140" y="20" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/><text class="t2" x="158" y="14" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840112</text></g>
<g class="an a-up2"><rect class="lnk" x="176" y="34" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="blk" x="186" y="20" width="36" height="36" rx="7" fill="#fff" stroke="#6c6c6c"/><rect class="lnk" x="222" y="34" width="10" height="8" fill="#6c6c6c" fill-opacity="0.35"/><rect class="sBd" x="232" y="20" width="36" height="36" rx="7" fill="none" stroke="#c9c9c9" stroke-dasharray="4 3"/><text class="t2" x="280" y="42" font-size="12" fill="#6c6c6c">…the chain keeps building here</text></g>
<g class="an a-rpre" opacity="0"><rect class="sB" x="140" y="108" width="36" height="36" rx="7" fill="#0d9488" fill-opacity="0.16" stroke="#0d9488" stroke-width="1.5"/></g>
<use href="#d8-st" class="fI" x="173" y="106" fill="#1e1e1e"/>
<g class="an a-orph"><rect class="sB" x="140" y="108" width="36" height="36" rx="7" fill="none" stroke="#0d9488" stroke-dasharray="5 4"/><line class="sN" x1="148" y1="116" x2="168" y2="136" stroke="#6c6c6c" stroke-width="2"/><line class="sN" x1="168" y1="116" x2="148" y2="136" stroke="#6c6c6c" stroke-width="2"/><text class="t2" x="158" y="162" text-anchor="middle" font-size="11" fill="#6c6c6c">orphaned</text></g>
<text class="t2" x="158" y="178" text-anchor="middle" font-size="10" font-family="monospace" fill="#6c6c6c">840112</text>
<text class="t2 an a-orph" x="290" y="130" font-size="12" fill="#6c6c6c">the pool's win, undone by the longer branch</text>
<g class="an a-rpre" opacity="0"><rect class="fA" x="30" y="200" width="106" height="16" rx="4" fill="#b45309" fill-opacity="0.16"/><rect class="fB" x="140" y="200" width="180" height="16" rx="4" fill="#0d9488" fill-opacity="0.16"/><text x="230" y="212" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f">epoch 840112 — on hold</text></g>
<g class="an a-rfin"><rect class="fA" x="30" y="200" width="440" height="16" rx="4" fill="#b45309" fill-opacity="0.16"/><text x="250" y="212" text-anchor="middle" font-size="11" font-family="monospace" fill="#1f1f1f">epoch 840000 — still the current epoch</text><text class="t2" x="492" y="212" font-size="13" fill="#6c6c6c">→</text></g>
<g class="an a-rfin"><rect class="sB" x="140" y="228" width="180" height="14" rx="4" fill="none" stroke="#0d9488" stroke-dasharray="4 4" stroke-opacity="0.6"/><text class="t2" x="230" y="239" text-anchor="middle" font-size="10.5" fill="#6c6c6c">epoch 840112 — dissolved</text></g>
<rect class="card" x="30" y="266" width="280" height="132" rx="10" fill="#fff" stroke="#e5e5e5"/>
<text class="t1" x="170" y="288" text-anchor="middle" font-size="12.5" font-weight="600" fill="#1e1e1e">the book — epoch 840000's page</text>
<line class="sBd" x1="48" y1="298" x2="292" y2="298" stroke="#e5e5e5"/>
<use href="#d8-sh" class="fA" x="56" y="317" fill="#b45309"/>
<text x="74" y="322" font-size="12.5" font-family="monospace" fill="#1f1f1f">128</text>
<rect class="sA" x="130" y="306" width="66" height="21" rx="10.5" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/>
<text x="163" y="320" text-anchor="middle" font-size="10.5" fill="#1f1f1f">ready ✓</text>
<g class="an a-slide"><use href="#d8-sh" class="fA" x="56" y="347" fill="#b45309"/><text x="74" y="352" font-size="12.5" font-family="monospace" fill="#1f1f1f">64</text><rect class="sA" x="130" y="336" width="66" height="21" rx="10.5" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/><text x="163" y="350" text-anchor="middle" font-size="10.5" fill="#1f1f1f">ready ✓</text><text class="t2" x="206" y="350" font-size="10.5" fill="#6c6c6c">came back</text></g>
<g class="an a-slide"><use href="#d8-sh" class="fA" x="56" y="377" fill="#b45309"/><text x="74" y="382" font-size="12.5" font-family="monospace" fill="#1f1f1f">32</text><rect class="sA" x="130" y="366" width="66" height="21" rx="10.5" fill="#b45309" fill-opacity="0.1" stroke="#b45309"/><text x="163" y="380" text-anchor="middle" font-size="10.5" fill="#1f1f1f">ready ✓</text><text class="t2" x="206" y="380" font-size="10.5" fill="#6c6c6c">came back</text></g>
<g class="an a-rpre" opacity="0"><rect class="card" x="350" y="266" width="260" height="132" rx="10" fill="#fff" stroke="#e5e5e5"/><text class="t1" x="480" y="288" text-anchor="middle" font-size="12.5" font-weight="600" fill="#1e1e1e">epoch 840112's page</text><line class="sBd" x1="368" y1="298" x2="592" y2="298" stroke="#e5e5e5"/><use href="#d8-sh" class="fB" x="378" y="317" fill="#0d9488"/><text x="396" y="322" font-size="12.5" font-family="monospace" fill="#1f1f1f">64</text><rect class="sN" x="452" y="306" width="72" height="21" rx="10.5" fill="none" stroke="#6c6c6c" stroke-dasharray="3 3"/><text class="t2" x="488" y="320" text-anchor="middle" font-size="10.5" fill="#6c6c6c">waiting…</text><use href="#d8-sh" class="fB" x="378" y="347" fill="#0d9488"/><text x="396" y="352" font-size="12.5" font-family="monospace" fill="#1f1f1f">32</text><rect class="sN" x="452" y="336" width="72" height="21" rx="10.5" fill="none" stroke="#6c6c6c" stroke-dasharray="3 3"/><text class="t2" x="488" y="350" text-anchor="middle" font-size="10.5" fill="#6c6c6c">waiting…</text></g>
<g class="an a-rfin"><rect class="sBd" x="350" y="266" width="260" height="132" rx="10" fill="none" stroke="#c9c9c9" stroke-dasharray="5 4"/><text class="t2" x="480" y="288" text-anchor="middle" font-size="12.5" fill="#6c6c6c">epoch 840112's page</text><text class="t2" x="480" y="336" text-anchor="middle" font-size="11.5" fill="#6c6c6c">(as if it never existed)</text><line class="sBd" x1="346" y1="352" x2="316" y2="352" stroke="#c9c9c9" stroke-width="1.5" marker-end="url(#d8-ar)"/></g>
<g font-size="12.5" fill="#1f1f1f">
<text class="an a-s1" x="40" y="424">1. the pool's block at 840112 wins — a new epoch opens, on probation</text>
<text class="an a-s2" x="40" y="442">2. a competing block at the same height appears, and its branch grows longer</text>
<text class="an a-s3" x="40" y="460">3. the pool's block is orphaned — epoch 840112 dissolves;</text>
<text class="an a-s3" x="54" y="478">its quotes slide back into epoch 840000, ready to spend — nothing lost</text>
</g>
</svg>
<figcaption><p>The reorg, absorbed: the boundary dissolves, the quotes slide back into the round that never ended, and the work still counts. Nothing was printed, so nothing is lost.</p></figcaption>
</figure>

One honest footnote: a reorg deeper than six blocks, arriving after notes exist, would genuinely hurt — but that is the same bet every pool, exchange, and bitcoin user makes when they treat six confirmations as settled. The wait doesn't make the risk zero; it buys it down to the level the whole bitcoin economy already lives with.

### After the Epoch

And when an epoch's round is over? Its notes don't vanish — they sit in wallets, waiting to be redeemed for bitcoin, and how that redemption works is the settlement chapter of hashpool's story, still being written.

Hashpool is under heavy development. You can follow along, or join in, at [github.com/vnprc/hashpool](https://github.com/vnprc/hashpool).

### The Whole Story

1. Your miner streams **shares** to the pool — proof of honest work.
2. The mint writes each share into its book as a **quote**: a promise it will honor.
3. Your wallet cashes quotes in for **ehash** notes, each stamped with the current **epoch** — one round of the pool's history, named after the block height where the last reward landed.
4. The pool wins a block; the **coinbase** pays the reward straight to the mint's address, and the mint sees it on the chain.
5. The epoch turns over instantly — but the new epoch's quotes **wait six confirmations** before they can become notes, a wait that delays nothing real.
6. If a **reorg** undoes the win first, the young epoch dissolves and its quotes slide back into the previous round, ready at once. Nothing irreversible had happened, so nothing is lost.

### Glossary

<dl class="epoch-glossary">
<dt>share</dt><dd>A near-miss solution to the mining puzzle — proof a miner is really working.</dd>
<dt>mint</dt><dd>The pool's cashier: it keeps the book of quotes and issues ehash notes.</dd>
<dt>quote</dt><dd>One entry in the mint's book — a promise that a share can be cashed in for ehash.</dd>
<dt>ehash</dt><dd>Hashpool's digital cash note, backed by proof of work. A bearer token: holding it is owning it.</dd>
<dt>epoch</dt><dd>One round of the pool's history, from one block win to the next. Each epoch's ehash is its own currency, named after the block height that opened it.</dd>
<dt>coinbase</dt><dd>The first transaction in a block — the one that creates the new bitcoin and pays the winner. Locked for 100 blocks by bitcoin's own rules.</dd>
<dt>confirmation</dt><dd>Each block built on top of a transaction's block, counting itself. More confirmations, harder to undo.</dd>
<dt>maturity window</dt><dd>The six-confirmation wait before a brand-new epoch's quotes can become notes.</dd>
<dt>reorg</dt><dd>The network replacing recent blocks with a longer competing branch. Shallow ones are routine; the maturity window is how hashpool shrugs them off.</dd>
</dl>
