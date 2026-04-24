return {
 SMODS.Consumable {
  key = 'matcha',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Matcha',
    text = {
      "Exchange selected Joker",
      "for {C:mult}+#1#{} discards",
      "for one round"
    }
  },
    atlas = 'Stamps', pos = { x = 0, y = 2 },

    config = {extra = { discards = 3 }},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.GAME.round_resets.temp_discards = (G.GAME.round_resets.temp_discards or 0) + card.ability.extra.discards
      G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
      ease_discard(card.ability.extra.discards)
      delay(0.6)
    end
},

}