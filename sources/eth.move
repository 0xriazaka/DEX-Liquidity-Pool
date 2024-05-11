
module eth::eth {
    use sui::coin::{Coin, TreasuryCap, Self};
    use std::option;
    use sui::transfer;
    use sui::tx_context::{TxContext, Self};

    struct ETH has drop {}

    #[allow(unused_function)]
    fun init(otw: ETH, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(otw, 6, b"ETH", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<ETH>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<ETH>, coin: Coin<ETH>) {
        coin::burn(treasury_cap, coin);
    }
}
