return {
 SMODS.Joker {
      key = 'astro',
      loc_txt = {
        name = 'Astro',
        text = {
        "Gains {X:mult,C:white} X#2# {} Mult for",
        "each {C:spades}Spade{} card drawn",
        "when {C:attention}starting Blind",
        "{C:inactive}(Currently {X:mult,C:white} X#1# {}{C:inactive} Mult)"
        },
      unlock = {
        "{E:1,s:1.3}?????"
      }
      },
      config = { extra = { Xmult = 1, Xmult_gain = 0.2 } },
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
      end,
      rarity = 4,
      atlas = 'GarbJokers',
      pos = { x = 3, y = 13 },
      soul_pos = { x = 4, y = 13 },
      cost = 20,
      dependencies = "starspace",
      
        unlocked = false, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = true, --can it be eternal
        perishable_compat = true, --can it be perishable

      calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
              return {
              Xmult_mod = card.ability.extra.Xmult,
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            }
        end

        if context.first_hand_drawn then
          local curXmult = card.ability.extra.Xmult
          for k,v in pairs(G.hand.cards) do 
            if v:is_suit('Spades', true) then
              card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            end
          end
          if curXmult ~= card.ability.extra.Xmult then
            return {
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
              card = card
            }
          end
        end
      end
    },
  
  }