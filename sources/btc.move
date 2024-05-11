
module btc::btc {
    use sui::coin::{Coin, TreasuryCap, Self};
    use std::option;
    use sui::transfer;
    use sui::tx_context::{TxContext, Self};

    struct BTC has drop {}

    #[allow(unused_function)]
    fun init(otw: BTC, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(otw, 6, b"BTC", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<BTC>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<BTC>, coin: Coin<BTC>) {
        coin::burn(treasury_cap, coin);
    }
}
