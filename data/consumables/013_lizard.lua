return {
 SMODS.Consumable {
  key = 'lizard',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Lizard',
    text = {
      "Exchange selected Joker",
      "for up to {C:attention}#1#{} copies",
      "of {C:tarot}The Fool{}",
      "{C:inactive}(Must have room)"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 2 },

    config = {extra = { max_highlighted = 1, copies = 2, }},
    
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.c_fool
      return { vars = { card.ability.extra.copies }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal and (G.consumeables.config.card_limit - #G.consumeables.cards) > 0 then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      for i = 1, math.min(card.ability.extra.copies, G.consumeables.config.card_limit - #G.consumeables.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = SMODS.create_card{key = "c_fool", no_edition = true}
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
      end
      delay(0.6)
    end

},

-- PLANETS
  }