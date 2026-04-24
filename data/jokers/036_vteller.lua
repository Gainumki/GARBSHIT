return {
 SMODS.Joker {
    key = 'vteller',
    loc_txt = {
      name = 'Two of Cups',
      text = {
        "Gains {X:mult,C:white} X#1# {} every time", 
        "a {C:tarot}Tarot{} card is used,",
        "resets if hand is played",
        "with more than {C:money}$#2#{}",
        "{C:inactive}(Currently: {X:mult,C:white} X#3# {C:inactive})"
      },
      unlock = {
        "Have the {E:1,C:tarot}Vagabond{}",
        "and {E:1,C:tarot}Fortune Teller{}",
        "Jokers at the same time"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult_gain = 0.2, dollars = 4, Xmult = 1} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 7 },
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 5,
      loc_vars = function(self, info_queue, card)
      if config.on_card_credits and not config.repainted then
        info_queue[#info_queue+1] = {set = "Other", key = "credits", specific_vars = {"64suns"}} 
      end
      return { vars = { card.ability.extra.Xmult_gain,card.ability.extra.dollars, card.ability.extra.Xmult} }
    end,
      
    check_for_unlock = function(self, args)
      if args.type == "vteller" then
        return true
      end
    end,

     calculate = function(self, card, context)
      if context.using_consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
              card = card
            }
      end
  
      if context.before and to_big(G.GAME.dollars) > to_big(card.ability.extra.dollars) then
        card.ability.extra.Xmult = 1
        return {
          message = localize('k_reset'),
          colour = G.C.RED
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