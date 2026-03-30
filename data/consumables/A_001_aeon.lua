return {
 SMODS.Consumable {
    key = 'aeon',
    set = 'Spectral',
    loc_txt = {
      name = 'The Aeon',
      text = {
        "Creates a {E:1,C:dark_edition}Negative{} copy",
      "of selected {C:attention}Joker{}",
      }
    },
    atlas = 'GarbConsumables', pos = { x = 0, y = 0 },
    hidden = true, 
    soul_set = 'Tarot', 
    soul_pos = { x = 1, y = 0 },
  
    can_use = function(self, card)
      if #G.jokers.highlighted == 1 then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local new_card = copy_card(G.jokers.highlighted[1], nil, nil, nil, true)
        new_card:set_edition('e_negative', true)
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true end }))
      delay(0.6)
      return true
    end
  } 
}