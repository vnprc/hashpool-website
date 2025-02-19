+++
title = "What is Hashpool?"
slug = "what-is-hashpool"
template = "article.html"
+++

Hashpool is an accountless mining pool that uses ecash to represent mining shares. Unlike all existing pools, Hashpool cryptographically blinds the user's identity from the pool and creates a free market for trading mining shares.

### The Problem With Mining Pools

In the earliest days of bitcoin anyone could mine on a laptop by running the bitcoin client. Things have changed a lot in the last 15 years. These days miners need to buy special hardware called ASICs and mining pools are optimized for large mining farms with hundreds or thousands of ASIC appliances hashing away 24/7. The deck is stacked against small miners just getting started.

All mining pools have a minimum withdrawal threshold, which means that if you want to start with the smallest ASIC available it can take years or decades of hashing before you are able to withdraw your earnings on-chain.

Some pools offer lower thresholds for lightning withdrawals, but lightning comes with it's own challenges. If you use a custodial lightning wallet you give up all transaction privacy and your funds are always at risk of being rugged, stolen by the custodian. If you decide to use a self-custodial wallet you can eliminate the rug risk but you pay for it with technical complexity. You need to open a lightning channel before you can use your wallet. If you don't already have some bitcoin you can buy a channel from an inbound liquidity provider. I can already see your eyes glazing over. "Inbound liquidity...what? I just want to start mining. What does this have to do with bitcoin mining?" Good question, reader.

But that's not all! Mining pools today are terrible for privacy. Most pools require KYC before you create an account. Even for the pools that don't require KYC they know three critical pieces of information: your IP address (which can easily be linked to your identity), your hashrate, and your bitcoin payouts. If you want to mine privately or at a small scale, there just aren't any good options. There has to be a better way to get started!

### How Does Hashpool Help?

