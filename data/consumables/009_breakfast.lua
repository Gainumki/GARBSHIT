return {
 SMODS.Consumable {
  key = 'breakfast',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Breakfast',
    text = {
      "Exchange selected Joker",
      "for {C:chips}+#1#{} hands",
      "for one round"
    }
  },
    atlas = 'Stamps', pos = { x = 3, y = 1 },

    config = {extra = { hand = 2 }},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.GAME.round_resets.temp_hands = (G.GAME.round_resets.temp_hands or 0) + card.ability.extra.hand
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
      ease_hands_played(card.ability.extra.hand)
      delay(0.6)
    end
},

}