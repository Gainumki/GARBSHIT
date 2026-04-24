return {
 SMODS.Enhancement {
	key = "royal",
	atlas = "GarbEnhancements",
	pos = {x = 3, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {card_limit = 1,extra = {active = false }},
	
  update = function(self, card)
    if not card.R_active and not card.debuff and card.area and card.area == G.hand then 
      card.R_active = true
    end

    if card.R_active and card.area and card.area ~= G.hand then 
      card.R_active = false
    end
  end,

	loc_vars = function(self, info_queue, card)
        return { vars = {  }}
  end,  

  remove_from_deck = function(self, card, from_debuff)
    if card.R_active then
      card.R_active = false
    end
  end,

  calculate = function(self, card, context)
    if card.R_active and context.after then
      draw_card(G.hand,G.discard, 90, 'up', nil, card)
    end
  end
}
}