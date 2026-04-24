return {
 SMODS.Joker {
      key = 'yaoi',
      loc_txt = {
        name = 'Bobburga Yaoi',
        text = { 
            "Scored {C:attention}Enhanced{} cards create",
            "random {C:dark_edition}Negative{} consumables",
            "Using or selling {C:dark_edition}Negative{} consumables",
            "{C:red}explodes{} all other {C:dark_edition}Negative{} consumables"
        },
      },
      config = { extra = { } },
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative

        return { vars = {  } }
      end,
      rarity = "garb_rainbow",
      atlas = 'GarbJokers',
      pos = {x = 6, y = 10},
      cost = 10,
      
        unlocked = true, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = false, --can it be eternal
        perishable_compat = false, --can it be perishable
  
      calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
          if context.other_card.ability.set == 'Enhanced' then
            G.E_MANAGER:add_event(Event{
				func = function()
			        local c = SMODS.add_card { set = "Consumeables", area = G.consumeables, edition = "e_negative" }
					card:juice_up()
					c:juice_up()
					play_sound('timpani', 1 + pseudorandom("yaoi",0,0.5))
					return true
				end
			})
              return {
              message = "Magic!",
              colour = G.C.DARK_EDITION 
            }
          end
        end

        if context.using_consumeable and context.consumeable.edition and context.consumeable.edition.key == "e_negative" or (context.selling_card and context.card.ability.consumeable) then
            for k, v in pairs(G.consumeables.cards) do 
                if v.edition and v.edition.key == "e_negative" then
                    v:explode()
                end
            end
        end
      end
    },
  
  }