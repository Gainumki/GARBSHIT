return {
 SMODS.Joker {
  key = 'androsius',
  loc_txt = {
    name = 'Androsius',
    text = {
      "This Joker gains",
      "{X:mult,C:white} X#1# {} Mult every time",
      "a {C:garb_Stamp}Stamp{} card is used",
      "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
    },
    unlock = {
      "{E:1,s:1.3}?????"
    }
  },
  config = { extra = { Xmult_gain = 1, Xmult = 1} },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 6 },
  soul_pos = { x = 4, y = 6 },
  cost = 20,

  unlocked = false, 
  discovered = false, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = true, --can it be eternal
  perishable_compat = true, --can it be perishable

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult} }
  end,


  add_to_deck = function(self, card)
    check_for_unlock({ type = "discover_androsius" })
  end,

  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.set == 'garb_Stamp' and not context.blueprint then
      card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          return {
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            card = card
          }
    end

    if context.joker_main and card.ability.extra.Xmult > 1 then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        card = card
      }
    end

  end
},

}