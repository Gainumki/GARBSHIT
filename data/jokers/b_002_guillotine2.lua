return {
 SMODS.Joker {
      key = 'guillotine2',
      loc_txt = {
        name = 'Guillotine Essence',
        text = {
            "{C:red}Destroys{} {s:1.2}YOU{}",
            "if you score more than",
            "{C:attention}1.000.000.000{} chips"
          },
      },
      config = { extra = {  } },
      loc_vars = function(self, info_queue, card)

        return { vars = {  } }
      end,
      rarity = "garb_rainbow",
      atlas = 'GarbJokers',
      pos = {x = 1, y = 11},
      cost = 10,
      
        unlocked = true, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = false, --can it be eternal
        perishable_compat = false, --can it be perishable
  
      calculate = function(self, card, context)
        if (context.after or context.end_of_round) and to_big(G.GAME.chips) > 1000000000 and context.cardarea == G.jokers then 
          G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
          check_for_unlock({type = 'beheading'})
          card:juice_up()
          play_sound('slice1', 0.66+math.random()*0.08, 5)
          garb_blackout = true
        return true end}))


        G.E_MANAGER:add_event(Event({trigger = "after", delay = 5, func = function()
          G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false
          love.event.quit( 0 )
        return true end}))
        end
      end
    },
  
  }