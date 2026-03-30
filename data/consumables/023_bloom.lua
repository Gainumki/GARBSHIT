return {
 SMODS.Consumable {
    key = 'bloom',
    set = 'Spectral',
    loc_txt = {
      name = 'Bloom',
      text = {
      "{C:white,X:money} X1.25 {} permanent {C:attention}money{} gain",
      "from all sources",
      "{C:red}-#1#{} hand size"
      }
    },
    atlas = 'GarbConsumables', pos = { x = 3, y = 2 },
        
    loc_vars = function(self, info_queue, card)
          return { vars = { (G.GAME.Bloom_minus or 1) }}
      end,

    can_use = function(self, card)
      return true
    end,

    use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        play_sound('garb_coin', 1.6, 0.4)
        G.GAME.Bloom_minus = G.GAME.Bloom_minus or 1
        G.hand:change_size(-G.GAME.Bloom_minus)
        G.GAME.Bloom_minus = G.GAME.Bloom_minus + 1
        G.GAME.BloomModifier = G.GAME.BloomModifier or 1
        G.GAME.BloomModifier = G.GAME.BloomModifier * 1.25
        card:juice_up(0.3, 0.5)
        return true end }))
      delay(0.6)
      return true
    end
  } 
}