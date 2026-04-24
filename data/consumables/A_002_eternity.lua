return {
 SMODS.Consumable {
  key = 'eternity',
  set = 'Spectral',
  loc_txt = {
    name = config.repainted and 'Flashback' or 'Eternity',
    text = {
      "Exchange selected Joker",
      "to go back to {E:1,C:legendary}Ante 1"
    }
  },

  atlas = 'GarbConsumables', pos = { x = 3, y = 0 },
  hidden = true, 
  soul_set = 'garb_Stamp', 
  soul_pos = { x = 4, y = 0 },

    config = {extra = { max_highlighted = 1}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      check_for_unlock({ type = "cycle_deck" })
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      ease_ante(-G.GAME.round_resets.ante+1)
      delay(0.6)
    end
},

}