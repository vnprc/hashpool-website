+++
title = "The Life of a Mining Epoch"
slug = "mining-epochs"
template = "article.html"
weight = 2
description = """
A pool's income arrives one block reward at a time, and each reward takes a few blocks to settle. Every ehash token has to belong to exactly one of them. Follow a single share through that problem: how epochs tie it to the right reward, why it waits before becoming ehash, and what happens if pool mines an orphan block.
"""
+++

Hashpool pays miners in **ehash**: digital cash tokens backed by mining work. Those tokens are issued by an online service called an **ecash mint** and live out their lives inside a **mining epoch**: one round of the pool's history in between mining rewards. When an epoch expires its ehash can be redeemed for **bitcoin**. See the glossary at the bottom of the page for more definitions.

If you are new to hashpool itself, [What is Hashpool?](/articles/what-is-hashpool/) is the friendly introduction.

### A Share Is Born

A bitcoin mining machine makes millions of attempts per second to find a new bitcoin block, and almost every attempt misses.

An attempt that comes close is still worth something: it proves the machine is genuinely working. Pools call these near-misses **shares**, and miners send a steady stream of them upstream. A share that proves more work carries more value.

Once in a while, a share doesn't just come close, it finds a new **bitcoin block** and earns the mining reward the whole pool has been working toward.

{{ epoch_share_flow() }}

### The Mint Records It

Hashpool's pool hands every accepted share to its cashier — an online software service called the **mint**.

The mint keeps a record of work done. For each share it writes one entry: this share arrived, it is worth this much, and it may be cashed in later. An entry in that ledger is called a **quote**. Nothing has been handed out yet — a quote is just the mint's written promise.

{{ epoch_quote_book() }}

### Quotes Become ehash

Your wallet checks the ledger, finds your quotes, and cashes them in.

What it gets back are **ehash** tokens: bearer instruments, like paper banknotes. Whoever holds them owns them. The cashing-in uses blind signatures, so the mint cannot tell which tokens ended up in whose wallet — [What is Hashpool?](/articles/what-is-hashpool/) explains that trick.

{{ epoch_ehash_minting() }}

-### Every Epoch Is Its Own Currency

The pool's life is divided into rounds. A round begins when the pool wins a block and ends when it wins the next one. In hashpool, these rounds are called **epochs**.

Each epoch issues its own currency. Every ehash token is tagged with both the hashpool instance that minted it and the block height that opened its epoch. That combination lets several hashpool instances use one mint while each issues a different currency for its current epoch. Two tokens from the same epoch are interchangeable, while tokens from different epochs are different currencies — like banknote series with different years printed on them.

{{ epoch_note_anatomy() }}

Why separate currency for each round? Because all shares in one epoch split the same mining reward, and both the reward amount and the number of shares are unknown until the reward is won. They belong together, and it would be unfair to mix them with another round's work.

On the blockchain, the pool's history looks like colored spans between wins:

{{ epoch_timeline() }}

The currency name is simply "hash" plus the pool's identifier and the block height that opened the epoch. The pool and height keep currencies from different hashpool instances and epochs from getting mixed up.

### The Pool Wins a Block

Now the big moment. One of those millions of shares finds a valid bitcoin block, and the new block joins the chain.

A block's very first transaction — called the **coinbase** — is the one that creates brand-new bitcoin. This is where the mining reward comes from. In hashpool, the coinbase pays that reward straight to the mint's address.

Nobody has to tell the mint it won. The mint watches the blockchain itself and recognizes its own address in the new block. A message can get lost; a payment recorded on the blockchain cannot.

{{ epoch_block_win() }}

### The Epoch Turns Over

The moment that reward lands, the old epoch closes and a new one opens. The new epoch also creates a new ehash currency whose value will be distinct from all other ehash currencies.

The turnover is instant on purpose. The very next share to arrive is already part of the new round, so its quote is stamped with the new currency's name. If rotation waited, late shares would leak into the old round and dilute what the people in that round had earned.

{{ epoch_turnover() }}

There is one catch: the brand-new epoch starts life on probation.

### The Maturity Window

For the first few blocks after a win, quotes for shares in the new epoch are marked *unpaid*. They sit safely in the mint's ledger, but wallets cannot see or redeem them for ehash tokens yet.

Why wait? Because sometimes a valid block isn't accepted into the blockchain, and minting an ecash token is something the mint can never undo. So the mint holds the new epoch's quotes until the winning block has **six confirmations** — the block itself plus five more built on top, the same standard the rest of the bitcoin economy uses for finality. Then the epoch is *final*, and the mint marks every unpaid quote as paid.

The wait separates two different groups of work:

- **Shares found right after the new block are provisionally assigned to a new epoch.** Their quotes remain unpaid, so no ehash tokens exist to transfer or redeem until the new epoch becomes final.
- **The previous epoch is closed.** It accepts no new shares. If the new epoch reaches finality, the closed epoch's mining reward and total share count are fixed, so every ehash token from that epoch now represents a concrete fraction of that reward.

Miners on ordinary pools already know this kind of wait as an "immature balance." Hashpool represents it explicitly with unpaid quotes.

{{ epoch_maturity() }}

### When the Chain Changes Its Mind

Sometimes two miners find a block at nearly the same moment, and the network briefly disagrees about the newest link of the chain. One branch soon grows longer and wins; blocks on the losing branch are *orphaned* — struck from history. This is a **reorg** — rare in practice these days, but a normal part of how the network resolves a tie.

So suppose the worst: the pool's winning block gets orphaned before its six confirmations arrive, and the replacement block pays someone else. On the chain, that mining reward now never happened.

Hashpool's answer is quiet: the epoch that block opened simply dissolves. Every quote stamped into the young epoch slides back into the previous epoch — the round that, it turns out, never ended — and the mint marks it paid immediately. The shares were honest work, and they still count in full.

Nobody loses anything, because nothing irreversible ever happened: thanks to the maturity window, not a single token of the young epoch was printed. Quotes are just entries in a ledger, and entries can be moved. This is why the window exists — so hashpool can shrug off reorgs.

{{ epoch_reorg() }}

One honest footnote: a reorg deeper than six blocks, arriving after tokens exist, would genuinely hurt — but that is the same bet every pool, exchange, and bitcoin user makes when they treat six confirmations as settled. The wait doesn't make the risk zero; it brings the risk down to a level the whole bitcoin economy already lives with.

### After the Epoch

And when an epoch's round is over? Its tokens don't vanish — they sit in wallets, waiting to be redeemed for bitcoin, and how that redemption works is the settlement chapter of hashpool's story, still being written.

Hashpool is under heavy development. You can follow along, or join in, at [forge.anarch.diy/vnprc/hashpool](https://forge.anarch.diy/vnprc/hashpool).

### The Whole Story

1. Your miner streams **shares** to the pool — proof of honest work.
2. The mint records each share in its ledger as a **quote**: a promise it will honor.
3. Your wallet cashes quotes in for **ehash** tokens, each stamped with the epoch it was mined in — a currency named for the hashpool instance plus the block height where the last reward landed.
4. The pool wins a block; the **coinbase** pays the reward straight to the mint's address, and the mint sees it on the chain.
5. The epoch turns over instantly — but the new epoch's quotes **wait six confirmations** before they can become tokens, so that new work cannot yet be transferred or redeemed.
6. If a **reorg** invalidates the block first, the young epoch dissolves, its quotes slide back into the previous round, and the mint marks them paid. Nothing irreversible had happened, so nothing is lost.

### Glossary

<dl>
<dt>share</dt><dd>A proof-of-work result that misses Bitcoin's network target but meets the pool's easier target — proof a miner is really working.</dd>
<dt>mint</dt><dd>The pool's cashier: it keeps the ledger of quotes and issues ehash tokens.</dd>
<dt>quote</dt><dd>One entry in the mint's ledger — a promise that a share can be cashed in for ehash.</dd>
<dt>ehash</dt><dd>Hashpool's digital cash token, backed by proof of work. A bearer token: holding it is owning it.</dd>
<dt>mining reward</dt><dd>The new bitcoin and transaction fees paid to the miner or pool that finds a valid block.</dd>
<dt>epoch</dt><dd>One round of the pool's history, from one block win to the next. Each epoch's ehash is a unique currency, named after the pool and the block height that opened it.</dd>
<dt>coinbase</dt><dd>The first transaction in a block — the one that creates the new bitcoin and pays the winner. Its output is unspendable for 100 blocks under bitcoin's rules.</dd>
<dt>confirmation</dt><dd>A count of how deeply a block is buried: the block starts with one confirmation, and each additional block built on top adds another. More confirmations mean less risk that the block will be invalidated.</dd>
<dt>maturity window</dt><dd>The six-confirmation wait before quotes from a provisional epoch become paid and can be minted into tokens.</dd>
<dt>reorg</dt><dd>The network replacing recent blocks with a longer competing branch. Short ones happen from time to time; the maturity window is how hashpool shrugs them off.</dd>
</dl>
