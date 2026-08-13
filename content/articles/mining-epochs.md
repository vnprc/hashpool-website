+++
title = "The Life of a Mining Epoch"
slug = "mining-epochs"
template = "article.html"
description = """
Follow one mining share through hashpool: how it becomes ehash, what an epoch is, why freshly won ehash waits a few blocks before it can be spent, and how a blockchain reorg quietly unwinds without anyone losing anything. No ecash background needed.
"""
+++

Hashpool pays miners in ehash — digital cash notes backed by mining work. Every one of those notes is born, matures, and lives out its life inside an *epoch*: one round of the pool's history, bookended by block wins.

This page follows a single share all the way through that story. By the end you will know what an epoch is, why brand-new ehash waits a few blocks before it can be spent, and why a blockchain reorg costs nobody anything.

If you are new to hashpool itself, [What is Hashpool?](/articles/what-is-hashpool/) is the friendly introduction. You don't need any cashu or ecash background to read this page.

### A Share Is Born

A mining machine makes millions of guesses per second at a puzzle, and almost every guess misses.

A guess that comes close is still worth something: it proves the machine is genuinely working. Pools call these near-misses **shares**, and miners send a steady stream of them upstream. A share that proves more work counts for more.

Once in a very long while, a share doesn't just come close — it actually solves the puzzle. That share is a new **block**, and it carries the reward the whole pool has been working toward.

{{ epoch_share_flow() }}

### The Mint Writes It Down

Hashpool's pool hands every accepted share to its cashier — a piece of software called the **mint**.

The mint keeps a book. For each share it writes one entry: this share arrived, it is worth this much, and it may be cashed in later. An entry in that book is called a **quote**. Nothing has been handed out yet — a quote is just the mint's written promise.

{{ epoch_quote_book() }}

### Quotes Become ehash

Your wallet checks the book, finds your quotes, and cashes them in.

What it gets back are **ehash** notes: bearer tokens, like paper banknotes. Whoever holds them owns them. The cashing-in uses blind signatures, so the mint cannot tell which notes ended up in whose wallet — [What is Hashpool?](/articles/what-is-hashpool/) explains that trick.

{{ epoch_ehash_minting() }}

### Every Epoch Is Its Own Money

The pool's life is divided into rounds. A round begins when the pool wins a block and ends when it wins the next one. In hashpool, these rounds are called **epochs**.

Each epoch issues its own money. Every ehash note is stamped with the epoch that minted it, and the epoch is named after a block height: the height of the winning block that opened it — the spot on the chain where the last reward landed.

{{ epoch_note_anatomy() }}

Why separate money for each round? Because all the shares in one epoch were part of the same chase for the same next reward. They belong together, and it would be unfair to mix them with another round's work.

On the blockchain, the pool's history looks like colored spans between wins:

{{ epoch_timeline() }}

One aside for the curious: under the hood, an epoch's full name also includes the pool's public key, so a single mint can serve many pools without their ehash ever getting mixed up. That's the whole story of the name — a pool and a height.

### The Pool Wins a Block

Now the big moment. One of those millions of shares actually solves the puzzle, and the pool's block joins the chain.

A block's very first transaction — called the **coinbase** — is the one that creates brand-new bitcoin. In hashpool, the coinbase pays that reward straight to the mint's address.

Nobody has to tell the mint it won. The mint watches the blockchain itself and recognizes its own address in the new block. A message can get lost; a payment recorded on the chain cannot.

{{ epoch_block_win() }}

### The Epoch Turns Over

The moment that reward lands, the old epoch closes and a new one opens, named after the winning block's height.

The turnover is instant on purpose. The very next share to arrive is already part of the new round, so it gets stamped with the new epoch's name. If rotation waited, late shares would leak into the old round and water down what the people in that round had earned.

{{ epoch_turnover() }}

There is one catch: the brand-new epoch starts life on probation. That is the next idea, and it's the most important one on this page.

### The Maturity Window

For the first few blocks after a win, the new epoch's quotes are marked *waiting*. They sit safely in the mint's book, but they cannot be cashed into notes yet.

Why wait? Because the blockchain is allowed to change its mind about its newest blocks — we'll watch that happen in the next section — and printing a note is the one thing hashpool can never undo. So the mint holds the new epoch's quotes until the winning block has **six confirmations** — the block itself plus five more built on top, the same standard the rest of the bitcoin economy uses for finality. Then the epoch is *final*, and every waiting quote unlocks at once.

While the clock runs, two things are worth noticing:

- **The old epoch is untouched.** Every quote and note from before the win stays spendable the whole time.
- **Nothing real is delayed.** Bitcoin itself locks every block reward for 100 blocks before it can be spent. The six-block wait ends long before there was anything to spend anyway.

Miners on ordinary pools already know this feeling: it is the classic "immature balance" that appears after a pool finds a block. Hashpool just wears it openly.

{{ epoch_maturity() }}

### When the Chain Changes Its Mind

Sometimes two miners find a block at nearly the same moment, and the network briefly disagrees about the newest link of the chain. One branch soon grows longer and wins; blocks on the losing branch are *orphaned* — struck from history. This is a **reorg**, and at shallow depths bitcoin does it routinely.

So suppose the worst: the pool's winning block gets orphaned before its six confirmations arrive, and the replacement block pays someone else. On the chain, that reward now never happened.

Hashpool's answer is quiet: the epoch that block opened simply dissolves. Every quote stamped into the young epoch slides back into the previous epoch — the round that, it turns out, never ended — and unlocks immediately, because that older epoch settled long ago. The shares were honest work, and they still count in full.

Nobody loses anything, because nothing irreversible ever happened: thanks to the maturity window, not a single note of the young epoch was printed. Quotes are just entries in a book, and entries can be moved. This is exactly the disaster the window exists for — met, absorbed, and shrugged off.

{{ epoch_reorg() }}

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
