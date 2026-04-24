return {
 SMODS.Consumable {
  key = 'spaceship',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Spaceship',
    text = {
      "Exchange selected Joker",
      "to upgrade {C:attention}most played",
      "{C:attention}poker hand{} by {C:attention}#1#{} levels"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 1 },

    config = {extra = { orbital_hand = 1, levels = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      local _planet, _hand, _tally = nil, nil, 0
      for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
          _hand = v
          _tally = G.GAME.hands[v].played
        end
      end
      _hand = _hand or "High Card"
      update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
        handname= _hand,
        chips = G.GAME.hands[_hand].chips,
        mult = G.GAME.hands[_hand].mult,
        level= G.GAME.hands[_hand].level})
      level_up_hand(card, _hand, nil, card.ability.extra.levels)
      update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})      
      delay(0.6)
    end

},

}