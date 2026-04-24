return {
 SMODS.Consumable {
  key = 'jimbo',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Jimbo',
    text = {
      "Exchange selected",
      "{V:1}#1#{} Joker for {C:money}$#2#{}",
      "{C:inactive,E:1}(Hey! That's me!)"
    }
  },
    atlas = 'Stamps', pos = { x = 1, y = 2 },

    config = {extra = { rarity = 1, rarity_text = "Common", money = 5 }},
    
    set_ability = function(self, card, initial, delay_sprites)
      local rarities = {}
      if G.jokers then
        for k, v in pairs(G.jokers.cards) do
          if v.ability.set == 'Joker'	and type(v.config.center.rarity) == "number" and not (type(v.config.center.rarity) == "number" and v.config.center.rarity >= 5) then
             table.insert(rarities, v.config.center.rarity)
          end
        end  
      end
      card.ability.extra.rarity = pseudorandom_element(rarities, pseudoseed('JohnBalatro')) or 1
      card.ability.extra.rarity_text =  ((card.ability.extra.rarity == 1) and "Common") or ((card.ability.extra.rarity == 2) and "Uncommon") or ((card.ability.extra.rarity == 3) and "Rare") or ((card.ability.extra.rarity == 4) and "Legendary")
      card.ability.extra.money = 5 * card.ability.extra.rarity
    end,

    loc_vars = function(self, info_queue, card)
      local rarity_color = G.C.RARITY[card.ability.extra.rarity]
      return { vars = { card.ability.extra.rarity_text, card.ability.extra.money, colours = {rarity_color}}}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].config.center.rarity == card.ability.extra.rarity and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      ease_dollars(card.ability.extra.money)
      delay(0.6)
    end
},

}