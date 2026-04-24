return {
 SMODS.Joker {
    key = 'alain',
    loc_txt = {
      name = 'Alain',
      text = {
        "{C:attention}Sell{} a non-negative {C:planet}Planet{} card to",        
        "create two {C:dark_edition}Negative{} copies of it",
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 6 },
    soul_pos = { x = 1, y = 6 },
    cost = 20,

    unlocked = false, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

    add_to_deck = function(self, card)
      check_for_unlock({ type = "discover_alain" })
    end,

    calculate = function(self, card, context)
      --[[ OLD ALAIN
      if context.after and not context.debuffed_hand then
        G.E_MANAGER:add_event(Event({
          func = function()
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
              if v.config.hand_type == context.scoring_name then
                _planet = v.key
              end
            end
            local _card = SMODS.create_card{key = _planet or "c_jupiter", no_edition = true}
            _card:set_edition('e_negative', true)
            _card:add_to_deck()
            G.consumeables:emplace(_card)
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local _card2 = SMODS.create_card{key = _planet or "c_jupiter", no_edition = true}
            _card2:add_to_deck()
            G.consumeables:emplace(_card2)
            end
            return true
          end
        }))
        return {
          message = localize('k_plus_planet'),
            colour = G.C.PLANET,
            card = card or context.blueprint_card
          }
    end
    ]]
    for i = 1, 2 do
      if context.selling_card and context.card == G.consumeables.highlighted[1] and G.consumeables.highlighted[1].ability.set == "Planet" and (not G.consumeables.highlighted[1].edition or (G.consumeables.highlighted[1].edition.key ~= "e_negative")) then
        local new_card = copy_card(G.consumeables.highlighted[1], nil, nil, nil, true)
        new_card:set_edition('e_negative', true)
        new_card:add_to_deck()
        G.consumeables:emplace(new_card)
        card:juice_up(0.3, 0.5)
      end
    end
  end
},
  
}