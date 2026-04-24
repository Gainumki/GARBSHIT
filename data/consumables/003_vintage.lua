return {
 SMODS.Consumable {
  key = 'vintage',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Vintage',
    text = {
      "Exchange selected Joker",
      "for a different Joker",
      "of the {C:attention}same rarity",
      "{C:inactive,s:0.9}(New Joker will not be {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9})"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.eternal
			and not (
				type(G.jokers.highlighted[1].config.center.rarity) == "number"
				and G.jokers.highlighted[1].config.center.rarity >= 5
			) and not (
        G.jokers.highlighted[1].edition
        and G.jokers.highlighted[1].edition.key == 'e_negative'
        and (G.jokers.config.card_limit - #G.jokers.cards) <= 0
      )
    end,
  
    use = function(self, card, area, copier)
      local deleted_joker_key = G.jokers.highlighted[1].config.center.key
      local rarity = G.jokers.highlighted[1].config.center.rarity
      local legendary = nil
      if rarity == 1 then
        rarity = 0
      elseif rarity == 2 then
        rarity = 0.9
      elseif rarity == 3 then
        rarity = 0.99
      elseif rarity == 4 then
        check_for_unlock({ type = "albert_deck" })
        rarity = nil
        legendary = true
      end
      G.jokers.highlighted[1]:start_dissolve(nil, false)
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.4,
        func = function()
          play_sound("timpani")
          local card = create_card("Joker", G.jokers, legendary, rarity, nil, nil, nil, "IstoleThisCodeFromCryptid")
          card:add_to_deck()
          G.jokers:emplace(card)
          card:juice_up(0.3, 0.5)
          if card.config.center.key == deleted_joker_key then
            check_for_unlock({ type = "pr_unlock" })
          end
          return true
        end,
      }))
    end,
  

},

}