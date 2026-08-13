+++
title = "The Life of a Mining Epoch"
slug = "mining-epochs"
template = "article.html"
description = """
Follow one mining share through hashpool: how it becomes ehash, what an epoch is, why shares found just after a block win must wait before becoming ehash, and how a reorg before finality quietly unwinds without anyone losing anything.
"""
+++

Hashpool pays miners in ehash — digital cash notes backed by mining work. Those notes are issued and live out their lives inside an *epoch*: one round of the pool's history, bookended by block wins.

This page follows a single share all the way through that story. By the end you will know what an epoch is, why shares found just after a block win must wait before becoming transferable ehash, and why a reorg before finality costs nobody anything.

If you are new to hashpool itself, [What is Hashpool?](/articles/what-is-hashpool/) is the friendly introduction.

### A Share Is Born

A mining machine makes millions of attempts per second to find a new bitcoin block, and almost every attempt misses.

An attempt that comes close is still worth something: it proves the machine is genuinely working. Pools call these near-misses **shares**, and miners send a steady stream of them upstream. A share that proves more work counts for more.

Once in a very long while, a share doesn't just come close — it finds a valid new **block** and carries the reward the whole pool has been working toward.

{{ epoch_share_flow() }}

### The Mint Records It

Hashpool's pool hands every accepted share to its cashier — a piece of software called the **mint**.

The mint keeps a book. For each share it writes one entry: this share arrived, it is worth this much, and it may be cashed in later. An entry in that book is called a **quote**. Nothing has been handed out yet — a quote is just the mint's written promise.

{{ epoch_quote_book() }}

### Quotes Become ehash

Your wallet checks the book, finds your quotes, and cashes them in.

What it gets back are **ehash** notes: bearer tokens, like paper banknotes. Whoever holds them owns them. The cashing-in uses blind signatures, so the mint cannot tell which notes ended up in whose wallet — [What is Hashpool?](/articles/what-is-hashpool/) explains that trick.

{{ epoch_ehash_minting() }}

### Every Epoch Is Its Own Currency

The pool's life is divided into rounds. A round begins when the pool wins a block and ends when it wins the next one. In hashpool, these rounds are called **epochs**.

Each epoch issues its own currency. Every ehash note is tagged with both the hashpool instance that minted it and the block height that opened its epoch. That combination lets several hashpool instances use one mint while each issues a different currency for its current epoch.

{{ epoch_note_anatomy() }}

Why separate currency for each round? Because all shares in one epoch split the same mining reward, and both the reward amount and the number of shares are unknown until the reward is won. They belong together, and it would be unfair to mix them with another round's work.

On the blockchain, the pool's history looks like colored spans between wins:

{{ epoch_timeline() }}

The exact currency name is `hash_<pool>_<height>`. The `pool` identifier is its full compressed public key in lowercase hexadecimal, and `height` is the block whose reward opened the epoch. Together they keep currencies from different pools and epochs from getting mixed up.

### The Pool Wins a Block

Now the big moment. One of those millions of shares finds a valid new block, and the pool's block joins the chain.

A block's very first transaction — called the **coinbase** — is the one that creates brand-new bitcoin. This is where the mining reward comes from. In hashpool, the coinbase pays that reward straight to the mint's address.

Nobody has to tell the mint it won. The mint watches the blockchain itself and recognizes its own address in the new block. A message can get lost; a payment recorded on the chain cannot.

{{ epoch_block_win() }}

### The Epoch Turns Over

The moment that reward lands, the old epoch closes and a new one opens, named after the hashpool instance and the winning block's height.

The turnover is instant on purpose. The very next share to arrive is already part of the new round, so it gets stamped with the new epoch's name. If rotation waited, late shares would leak into the old round and water down what the people in that round had earned.

{{ epoch_turnover() }}

There is one catch: the brand-new epoch starts life on probation.

### The Maturity Window

For the first few blocks after a win, quotes for shares in the new epoch are marked *unpaid*. They sit safely in the mint's book, but wallets cannot see or cash them into ehash notes yet.

Why wait? Because the blockchain is allowed to change its mind about its newest blocks, and printing a note is the one thing hashpool can never undo. So the mint holds the new epoch's quotes until the winning block has **six confirmations** — the block itself plus five more built on top, the same standard the rest of the bitcoin economy uses for finality. Then the epoch is *final*, and the mint marks every unpaid quote as paid at once.

The wait separates two different groups of work:

- **Shares found after the win are delayed.** Their quotes remain unpaid, so no ehash notes exist to transfer or redeem until the new epoch becomes final.
- **The reward belongs to the epoch that just closed.** Its coinbase output is unspendable for 100 blocks. That is a separate bitcoin rule governing the reward earned by shares from before the win.

Miners on ordinary pools already know this kind of wait as an "immature balance." Hashpool represents it explicitly with unpaid quotes.

{{ epoch_maturity() }}

### When the Chain Changes Its Mind

Sometimes two miners find a block at nearly the same moment, and the network briefly disagrees about the newest link of the chain. One branch soon grows longer and wins; blocks on the losing branch are *orphaned* — struck from history. This is a **reorg**, and at shallow depths bitcoin does it routinely.

So suppose the worst: the pool's winning block gets orphaned before its six confirmations arrive, and the replacement block pays someone else. On the chain, that reward now never happened.

Hashpool's answer is quiet: the epoch that block opened simply dissolves. Every quote stamped into the young epoch slides back into the previous epoch — the round that, it turns out, never ended — and the mint marks it paid immediately. The shares were honest work, and they still count in full.

Nobody loses anything, because nothing irreversible ever happened: thanks to the maturity window, not a single note of the young epoch was printed. Quotes are just entries in a book, and entries can be moved. This is why the window exists — so hashpool can shrug off reorgs.

{{ epoch_reorg() }}

One honest footnote: a reorg deeper than six blocks, arriving after notes exist, would genuinely hurt — but that is the same bet every pool, exchange, and bitcoin user makes when they treat six confirmations as settled. The wait doesn't make the risk zero; it brings the risk down to a level the whole bitcoin economy already lives with.

### After the Epoch

And when an epoch's round is over? Its notes don't vanish — they sit in wallets, waiting to be redeemed for bitcoin, and how that redemption works is the settlement chapter of hashpool's story, still being written.

Hashpool is under heavy development. You can follow along, or join in, at [forge.anarch.diy/vnprc/hashpool](https://forge.anarch.diy/vnprc/hashpool).

### The Whole Story

1. Your miner streams **shares** to the pool — proof of honest work.
2. The mint records each share in its book as a **quote**: a promise it will honor.
3. Your wallet cashes quotes in for **ehash** notes, each stamped with the current **epoch** — one round of the pool's history, named after the pool and the block height where the last reward landed.
4. The pool wins a block; the **coinbase** pays the reward straight to the mint's address, and the mint sees it on the chain.
5. The epoch turns over instantly — but the new epoch's quotes **wait six confirmations** before they can become notes, so that new work cannot yet be transferred or redeemed.
6. If a **reorg** undoes the win first, the young epoch dissolves, its quotes slide back into the previous round, and the mint marks them paid at once. Nothing irreversible had happened, so nothing is lost.

### Glossary

<dl class="epoch-glossary">
<dt>share</dt><dd>A proof-of-work result that misses Bitcoin's network target but meets the pool's easier target — proof a miner is really working.</dd>
<dt>mint</dt><dd>The pool's cashier: it keeps the book of quotes and issues ehash notes.</dd>
<dt>quote</dt><dd>One entry in the mint's book — a promise that a share can be cashed in for ehash.</dd>
<dt>ehash</dt><dd>Hashpool's digital cash note, backed by proof of work. A bearer token: holding it is owning it.</dd>
<dt>epoch</dt><dd>One round of the pool's history, from one block win to the next. Each epoch's ehash is its own currency, named after the pool and the block height that opened it.</dd>
<dt>coinbase</dt><dd>The first transaction in a block — the one that creates the new bitcoin and pays the winner. Its output is unspendable for 100 blocks under bitcoin's rules.</dd>
<dt>confirmation</dt><dd>A count of how deeply a block is buried: the block starts with one confirmation, and each additional block built on top adds another. More confirmations mean less risk that the block will be undone.</dd>
<dt>maturity window</dt><dd>The six-confirmation wait before quotes from a provisional epoch become paid and can be minted into notes.</dd>
<dt>reorg</dt><dd>The network replacing recent blocks with a longer competing branch. Shallow ones are routine; the maturity window is how hashpool shrugs them off.</dd>
</dl>
