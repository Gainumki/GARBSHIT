return {
 SMODS.Joker {
    key = 'snap',
    loc_txt = {
      name = config.repainted and 'The Guy from Fortnite' or 'The Snap',
      text = {
        "Sell this card to",
        "halve the current",
        "Blind's {C:attention}score",
        "{C:attention}requirement{}",
        "{s:0.7,C:inactive}Currently: {s:0.7,V:1}#1#",
    }
    },
    config = { extra = { difficulty = 0.5 } },
    loc_vars = function(self, info_queue, card)
      local activate_text = 'Inactive'
      local activate_color = G.C.RED
      if G.STATE == G.STATES.SELECTING_HAND then
        activate_text = 'Active'
        activate_color = G.C.GREEN
      end
    
      return {vars = {activate_text,
          colours = {activate_color} }}
    end,
  
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 6 },
    cost = 5,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
      
      calculate = function(self, card, context)
        if context.selling_self and G.STATE == G.STATES.SELECTING_HAND then
            scale_blind(-card.ability.extra.difficulty)
            play_sound('garb_snap', 1)
            return {
              message = "Snap!",
              card = card
          }
        end
    end,
  },

  }