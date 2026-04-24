return {
 SMODS.Consumable {
  key = 'twindrill',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Twindrill',
    text = {
      "Exchange selected Joker",
      "for a {C:mult}Teto{} Joker",
    }
  },
  dependencies = "Incognito",

  atlas = 'Stamps', pos = { x = 3, y = 2 },

    config = {extra = { max_highlighted = 1}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { }}
    end,

    can_use = function(self, card)
      return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.eternal
      and not (
        G.jokers.highlighted[1].edition
        and G.jokers.highlighted[1].edition.key == 'e_negative'
        and (G.jokers.config.card_limit - #G.jokers.cards) <= 0
      )
    end,
  
    use = function(self, card, area, copier)
      local rarity = "nic_teto"
      G.jokers.highlighted[1]:start_dissolve(nil, false)
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.4,
        func = function()
          play_sound("timpani")
          local card = create_card("Joker", G.jokers, nil, rarity, nil, nil, nil, "IstoleThisCodeFromCryptid")
          card:add_to_deck()
          G.jokers:emplace(card)
          card:juice_up(0.3, 0.5)
          return true
        end,
      }))
    end,
  

},

}