return {
    SMODS.Tag {
        key = 'mail',
        loc_txt = {
          name = 'Mail Tag',
          text = {
            "Gives a free",
            "{C:garb_Stamp}Mega Postal Pack"
        }
        },
        atlas = 'GarbTags', 
        pos = { x = 0, y = 0 },
        in_pool = function()
		    return (G.GAME.round_resets.ante > 1)
	    end,
        apply = function(self, tag, context)
              if context.type == "new_blind_choice" then
                  tag:yep("+", G.C.ATTENTION, function()
                      local key = "p_garb_stamp_booster_m"
                      local card = Card(
                          G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                          G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                          G.CARD_W * 1.27,
                          G.CARD_H * 1.27,
                          G.P_CARDS.empty,
                          G.P_CENTERS[key],
                          { bypass_discovery_center = true, bypass_discovery_ui = true }
                      )
                      card.cost = 0
                      card.from_tag = true
                      G.FUNCS.use_card({ config = { ref_table = card } })
                      card:start_materialize()
                      return true
                  end)
                  tag.triggered = true
                  return true
              end
          end,
      },
    }