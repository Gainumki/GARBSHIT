return {
 SMODS.Consumable {
  key = 'mushroom',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Mushroom',
    text = {
      "Exchange selected Joker",
      "to add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
      "{C:dark_edition}Polychrome{} edition",
      "to a random {C:attention}Joker"
    }
  },

  atlas = 'Stamps', pos = { x = 0, y = 1 },

    config = {extra = { }},
    
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.e_foil
      info_queue[#info_queue+1] = G.P_CENTERS.e_holo
      info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return { vars = {  }}
    end,

    can_use = function(self, card)
      local exchange = (#G.jokers.highlighted == 1) and not (G.jokers.highlighted[1].ability.eternal)
      eligible_strength_jokers = EMPTY(eligible_strength_jokers)
      for k, v in pairs(G.jokers.cards) do
        if v.ability.set == 'Joker' and (not v.edition) and v ~= G.jokers.highlighted[1] then
            table.insert(eligible_strength_jokers, v)
        end
      end
      return (#eligible_strength_jokers > 0 or false) and exchange
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      local eligible_card = pseudorandom_element(eligible_strength_jokers, pseudoseed("shroomie"))
      local edition = poll_edition('shroomie', nil, true, true,  {"e_foil", "e_holo","e_polychrome"})
      eligible_card:set_edition(edition, true)
      check_for_unlock({type = 'have_edition'})
      delay(0.6)
      return true
    end

},

}