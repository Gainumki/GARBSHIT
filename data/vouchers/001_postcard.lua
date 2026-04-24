return {
SMODS.Voucher{
    key = 'postcard',
    loc_txt = {
      name = 'Postcard',
      text = {
        "{C:garb_Stamp}Stamp{} cards can",
        "be purchased",
        "from the {C:attention}shop"
    }
    },
      atlas = 'GarbVouchers', pos = { x = 0, y = 0 },
      redeem = function(self, card)
        G.GAME.stamp_rate = (G.GAME.stamp_rate or 0) + 4
      end
  },
}