return {
 SMODS.Consumable {
  key = 'souvenir',
  set = 'garb_Stamp',
  loc_txt = {
    name = 'Souvenir',
    text = {
      "Exchange selected",
      "{C:uncommon}Uncommon{} Joker",
      "for a {C:attention}Voucher Tag{}"
    }
  },

  atlas = 'Stamps', pos = { x = 4, y = 0 },

    config = {extra = { }},
    
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {set = "Tag", key = "tag_voucher", specific_vars = {}}
        return { vars = {  }}
    end,

    can_use = function(self, card)
      if (#G.jokers.highlighted == 1) and (G.jokers.highlighted[1].config.center.rarity == 2 or G.jokers.highlighted[1].config.center.rarity == 0.9) and not (G.jokers.highlighted[1].ability.eternal) then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      add_tag(Tag('tag_voucher'))
      delay(0.6)
    end

},

}