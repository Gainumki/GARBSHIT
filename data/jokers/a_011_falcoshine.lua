return {
 SMODS.Joker {
      key = 'falcoshine',
      loc_txt = {
        name = 'Falcoshine',
        text = {
        "Gives {X:mult,C:white} X1 {} Mult for",
        "each remaining {C:blue}Hand{}",
        "{C:inactive}(Currently {X:mult,C:white} X#1# {}{C:inactive} Mult)"
        },
      unlock = {
        "{E:1,s:1.3}?????"
      }
      },
      config = { extra = { Xmult = 1 } },
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
      end,
      rarity = 4,
      atlas = 'GarbJokers',
      pos = { x = 1, y = 13 },
      soul_pos = { x = 2, y = 13 },
      cost = 20,
      
        unlocked = false, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = true, --can it be eternal
        perishable_compat = true, --can it be perishable
      add_to_deck = function(self, card, from_debuff)
          card.ability.extra.Xmult = G.GAME.current_round.hands_left
      end,

      calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
              return {
              Xmult_mod = card.ability.extra.Xmult,
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            }
        end

        if context.after or context.starting_shop or context.first_hand_drawn then
          card.ability.extra.Xmult = G.GAME.current_round.hands_left
          return {
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            card = card
          }
        end

      end
    },
  
  }