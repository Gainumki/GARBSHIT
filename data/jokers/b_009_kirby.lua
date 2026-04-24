return {
 SMODS.Joker {
      key = 'kirby',
      loc_txt = {
        name = config.repainted and 'kirbo' or 'Kirby',
        text = {
            "When selecting blind,",
            "{C:attention}eats{} Joker to the right",
            "and {C:attention}copies{} it with",
            "{X:dark_edition,C:white} X#1# {} their original values",
            "{C:inactive}(Ability resets every ante)"
          },
      },
      config = { extra = { value = 4 } },
      loc_vars = function(self, info_queue, card)
        if config.on_card_credits and not config.repainted then
          info_queue[#info_queue+1] = {set = "Other", key = "credits", specific_vars = {"Astro"}} 
        end
        if G.garb_kirby and G.garb_kirby.cards[1] then
          local copy_ability = G.P_CENTERS[G.garb_kirby.cards[1].config.center.key]
          info_queue[#info_queue + 1] = copy_ability
        end
        return {vars = {card.ability.extra.value}}
      end,
      rarity = "garb_rainbow",
      atlas = 'GarbJokers',
      pos = {x = 0, y = 12},
      soul_pos = {x = 1, y = 12},
      cost = 10,
      
        unlocked = true, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = false, --can it be eternal
        perishable_compat = false, --can it be perishable
  

      calculate = function(self, card, context)
        if context.setting_blind then
          local index
          for k, v in pairs(G.jokers.cards) do
            if v == card then index = k+1 end
          end
          if not G.jokers.cards[index] then return false end
          if G.garb_kirby.cards[1] then G.garb_kirby.cards[1]:start_dissolve(nil, true) end
          play_sound("garb_kirby_powerup")
          G.jokers.cards[index]:juice_up(1, 0.3)
          draw_card(G.jokers, G.garb_kirby, 100, "left", nil, G.jokers.cards[index], 0.035)
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = (function() 
              G.garb_kirby.cards[1].ability = DeepScale(G.garb_kirby.cards[1].ability, 0, card.ability.extra.value) 
              return true end)
            }))
          card:juice_up()
          return {message = "Copied!"}
          end

        if context.ante_end and context.cardarea == G.jokers and G.garb_kirby.cards[1] then
            G.garb_kirby.cards[1]:start_dissolve(nil, true)
            return {message = localize('k_reset')}
        end

        local ret = SMODS.blueprint_effect(card, G.garb_kirby.cards[1], context)
        if ret then return ret end
      end,

      remove_from_deck = function(self, card, from_debuff)
      end
    },
  
  }