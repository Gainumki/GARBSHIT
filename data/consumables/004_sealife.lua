return {
 SMODS.Consumable {
  key = 'sealife',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Sealife',
    text = {
      "Exchange selected Joker",
      "for a {C:attention}Boss Blind reroll{}"
    }
  },

  atlas = 'Stamps', pos = { x = 3, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.from_boss_tag = true
      G.FUNCS.reroll_boss()
      delay(0.6)
    end

},

}