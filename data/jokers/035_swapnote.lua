return {
 SMODS.Joker {
    key = 'swapnote',
    loc_txt = {
      name = 'Swapnote',
      text = {
        "This Joker gains",
        "{C:chips}+#1#{} Chips every time",
        "a {C:garb_Stamp}Stamp{} card is used",
        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
      }
    },
    config = { extra = { chip_gain = 20, chips = 0} },
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 7 },
    cost = 4,
  
    unlocked = true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
  
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chip_gain, card.ability.extra.chips} }
    end,
  
    calculate = function(self, card, context)
      if context.using_consumeable and context.consumeable.ability.set == 'garb_Stamp' and not context.blueprint then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
              message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
              card = card
            }
      end
  
      if context.joker_main and card.ability.extra.chips > 1 then
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
          card = card
        }
      end
  
    end
  },

  }