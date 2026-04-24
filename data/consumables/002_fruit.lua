return {
 SMODS.Consumable {
  key = 'fruit',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Fruit',
    text = { 
      "Exchange {C:attention}#2#{} {C:red}discard",
      "for {C:attention}+#1#{} hand size",
      "for one round"
    }
  },
    atlas = 'Stamps', pos = { x = 1, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3, discards = 1}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.discards}}
    end,

    can_use = function(self, card)
      if G.GAME.round_resets.discards >= 1 then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      ease_discard(-card.ability.extra.discards)
      G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
      G.GAME.round_resets.temp_discards = (G.GAME.round_resets.temp_discards or 0) + card.ability.extra.discards
      G.hand:change_size(card.ability.extra.h_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
      delay(0.6)

    end

},

}