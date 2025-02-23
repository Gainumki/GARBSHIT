--- STEAMODDED HEADER
--- MOD_NAME: Garbshit
--- MOD_ID: GARBPACK
--- MOD_AUTHOR: [garb]
--- BADGE_COLOUR: 7E5A7D
--- MOD_DESCRIPTION: Garb's silly collection of good and bad jokers.
--- PREFIX: garb
----------------------------------------------
------------MOD CODE -------------------------

local config = SMODS.current_mod.config


SMODS.current_mod.config_tab = function()
  garb_nodes = {{n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = "Options:", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
  }},create_toggle({label = "Teto Joker Music (Fukkireta)", ref_table = config, ref_value = "fukkireta",
})
  }
  return {
    n = G.UIT.ROOT,
    config = {
        emboss = 0.05,
        minh = 6,
        r = 0.1,
        minw = 10,
        align = "cm",
        padding = 0.2,
        colour = G.C.BLACK
    },
    nodes = garb_nodes
  }  
end

SMODS.Atlas({
	key = "modicon",
	path = "garb_icon.png",
	px = 32,
	py = 32,
})

SMODS.Atlas{
    key = 'GarbJokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

	SMODS.Sound {
    key = "mirrorz",
    path = {
        ["default"] = "mirror2.ogg"
    }
	}
	
	SMODS.Sound {
    key = "abadeus1",
    path = {
        ["default"] = "abadeus2.ogg"
    },
	volume = 0.5
	}
	
	SMODS.Sound {
    key = "explosion",
    path = {
        ["default"] = "explosion.ogg"
    },
	volume = 0.5
	}
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.4
	}
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.2
	}
	
	SMODS.Sound {
    key = "squeak",
    path = {
        ["default"] = "squeak.wav"
    },
	volume = 0.4
	}

  SMODS.Sound {
    key = "scopacane",
    path = {
        ["default"] = "scopacane2.ogg"
    },
	volume = 0.5
	}

  SMODS.Sound {
    key = "music_fukkireta",
    path = {
        ["default"] = "music_fukkireta.ogg"
    },
    sync = false,
    pitch = 1,
    select_music_track = function()
      return next(SMODS.find_card("j_garb_teto")) and config.fukkireta
    end
    
	}
  
SMODS.Joker {
  key = 'corrupted',
  loc_txt = {
    name = 'Corrupted Joker',
    text = {
	  "Gains or loses",
	  "a random amount of {C:chips}Chips{C:chips}",
      "after every hand played",
      "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
    }
  },
  config = { extra = { chips = 0, chip_gain = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  rarity = 1,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 0 },
  cost = 3,

    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	
loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
      }
    end
	
    if context.after and not context.blueprint then
		card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
		card.ability.extra.chip_gain = pseudorandom('104420', -20, 20)
      return {
        message = 'Upgraded?',
        colour = G.C.CHIPS,
        card = card
      }
    end
	
  end
}


SMODS.Joker {
  key = 'rolling',
  loc_txt = {
    name = 'Rolling Stone',
    text = {
	  "Adds one {C:attention}Stone{} card",
	  "to deck when",
	  "{C:attention}Shop{} is {C:attention}Rerolled{}"
    }
  },
  config = { extra = { } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    return { vars = {  } }
  end,
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 0 },
  cost = 7,
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	
  
  calculate = function(self, card, context)
	if context.reroll_shop then
		G.E_MANAGER:add_event(Event({
                    func = function() 
                        local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                        card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                        G.deck:emplace(card)
                        table.insert(G.playing_cards, card)
						return true
                    end}))
		return {
            message = "Stone!",
            colour = G.C.CHIPS,
            playing_cards_created = {true},
		    card = card
            }
    end

	
  end
}

SMODS.Joker {
  -- How the code refers to the joker.
  key = 'mirror',
  -- loc_text is the actual name and description that show in-game for the card.
  loc_txt = {
    name = 'Mirror',
    text = {
	  "Inverts {C:chips}Chips{} and {C:mult}Mult{}"
    }
  },
  config = { extra = { chips = 1, mult = 1, temp = 1 } },

  -- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
  rarity = 3,
  -- Which atlas key to pull from.
  atlas = 'GarbJokers',
  -- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
  pos = { x = 1, y = 3 },
  -- Cost of card in shop.
  cost = 7,
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

  calculate = function(self, card, context)
  
    if context.joker_main then
	  card.ability.extra.temp = mult
	  
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound('garb_mirrorz', 0.9 + math.random()*0.1, 0.8)
				card:juice_up(0.3, 0.4)
				return true
			end
			}))
      return {
		mult_mod = -mult + hand_chips,
		chip_mod = -hand_chips + card.ability.extra.temp,
            message = "Inverted!",
			card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'luckiest',
  loc_txt = {
    name = 'Golden Lucky Cat',
    text = {
	  "Earn {C:money}$#1#{} every time",
	  "a {C:attention}Lucky{} card",
	  "{C:green}successfully{} triggers"
    }
  },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

  config = { extra = { money = 4 } },
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 3 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    return { vars = { card.ability.extra.money } }
  end,
  
   calculate = function(self, card, context)

    if context.individual and not context.other_card.debuff and context.other_card.lucky_trigger then
                                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                                return {
                                    dollars = card.ability.extra.money,
                                    colour = G.C.MONEY
                                }
    end
  end
}


SMODS.Joker {
  key = 'colorful',
  loc_txt = {
    name = 'Colorful Joker',
    text = {
      "If poker hand contains a",
	  "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
	  "{C:hearts}Heart{} card, and a {C:spades}Spade{} card,",
	  "all scoring cards become",
	  "{C:dark_edition}Polychrome{} after scoring"
    }
  },
  config = { extra = {} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 3 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 6,
	loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
    return { vars = { } }
  end,
	
   calculate = function(self, card, context)
   
    if context.after then
							local suits = {
                                ['Hearts'] = 0,
                                ['Diamonds'] = 0,
                                ['Spades'] = 0,
                                ['Clubs'] = 0
                            }
                            for i = 1, #context.scoring_hand do
                                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                                end
                            end
                            for i = 1, #context.scoring_hand do
                                if SMODS.has_any_suit(context.scoring_hand[i]) then
                                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                                end
                            end
                            if suits["Hearts"] > 0 and
                            suits["Diamonds"] > 0 and
                            suits["Spades"] > 0 and
                            suits["Clubs"] > 0 then
								for k, v in ipairs(context.scoring_hand) do
								G.E_MANAGER:add_event(Event({
									func = function()
										v:juice_up()
										v:set_edition("e_polychrome", true)
										return true
									end
								}))
								delay(0.3)
								end
								return {
								message = "Rainbow!",
								colour = G.C.DARK_EDITION,
								card = card
      }
							end
	end
  end
}

SMODS.Joker {
  key = 'devils',
  loc_txt = {
    name = "Devil's Deal",
    text = {
	  "Prevents Death",
	  "Adds {C:attention}#1#{} {C:mult}Debuffed{} {C:attention}Stone{}",
	  "{C:attention}Cards{} to deck",
	  "{C:mult}Self-Destructs{}"
    }
  },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

  config = { extra = { duds = 66 } },
  rarity = 1,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 2 },
  cost = 3,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.duds } }
  end,
  
   calculate = function(self, card, context)

    if context.game_over then
                    G.E_MANAGER:add_event(Event({
						func = function() 
							local front = pseudorandom_element(G.P_CARDS, pseudoseed('devil'))
							G.playing_card = (G.playing_card and G.playing_card + 1) or 1
							for i = 1, card.ability.extra.duds do
								local _card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
								_card:start_materialize({G.C.SECONDARY_SET.Enhanced})
								_card.ability.perma_debuff, _card.debuff = true
								G.deck:emplace(_card)
								table.insert(G.playing_cards, _card)
							end
							return true
						end
						
                    })) 
					G.E_MANAGER:add_event(Event({
					    func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('tarot1')
                            card:start_dissolve()
                            return true
                        end
					})) 
                    return {
                        message = localize('k_saved_ex'),
                        saved = true,
                        colour = G.C.RED
                    }
    end
  end
}


SMODS.Joker {
  key = 'devil_essence',
  loc_txt = {
    name = "Essence of Devil's Deal",
    text = {
	  "When {C:attention}Blind{} is selected,",
      "{C:red}destroy{} all {C:red}debuffed{} cards"
    }
  },

  config = { extra = {} },
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 2 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 6,
	loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
	
   calculate = function(self, card, context)
   
    if context.blind or context.first_hand_drawn then
		local card = context.other_card
            for k, v in pairs(G.playing_cards) do
				if v.debuff == true then
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
			end
	end
  end
}


SMODS.Joker {
  key = 'Stupid',
  loc_txt = {
    name = 'Stupid Joker',
    text = {
	  "Consumes {C:attention}lead{} from Steel Cards",
      "Gains {C:chips}+#2#{} Chips",
      "every time {C:attention}lead{} is consumed",
      "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"	  
    }
  },
  config = { extra = { chips = 0, chip_gain = 25 } },
  rarity = 1,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 4 },
  cost = 3,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
  end,
  unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
  calculate = function(self, card, context)
  
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
      }
    end

	if context.individual and context.cardarea == G.play and not context.blueprint then
                        for i = 1, #context.scoring_hand do
							local _card = context.other_card
							if _card.ability.name == 'Steel Card' then
								_card:juice_up()
								colour = G.C.CHIPS
								card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
								_card:set_ability(G.P_CENTERS.c_base, G.P_CENTERS.c_steel, true)
								return {
									message = "lead consumed!",
								card = card
								}
                            end
						end

	end
end
}

SMODS.Joker {
  key = 'd20',
  loc_txt = {
    name = 'Critical Roll',
    text = {
      "Gives {X:mult,C:white} X#1# {} Mult every time",
	  "a {C:attention}Lucky{} card",
	  "{C:green}successfully{} triggers"
    }
  },

  config = { extra = {Xmult = 4} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 4 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 7,
	loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    return { vars = { card.ability.extra.Xmult } }
  end,
	
   calculate = function(self, card, context)

    if context.individual and not context.other_card.debuff and context.other_card.lucky_trigger then
								return {
                  Xmult_mod = card.ability.extra.Xmult,
									message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
									card = card
                                }
    end
  end
}

SMODS.Joker {
  key = 'Jim',
  loc_txt = {
    name = 'Jim',
    text = {
      "{X:mult,C:white} X#1# {} Mult",
	  "Fills all free Joker slots with {C:red}Jim{}",
	  "{C:inactive}(If one Jim goes away, all Jims go away){}"
    }
  },

  config = { extra = {Xmult = 1.5} },
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 5 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
	
	cost = 5,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
	
   calculate = function(self, card, context)

        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
  end,
  
  add_to_deck = function(self, card, from_debuff)

	G.E_MANAGER:add_event(Event({
		delay = 0.1,
		func = (function()
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				local new_card = SMODS.create_card{key = "j_garb_Jim", no_edition = true}
				new_card:add_to_deck()
				G.jokers:emplace(new_card)
			end
			return true
        end)}))
  end,

  remove_from_deck = function(self, card, from_debuff)
		local jims = SMODS.find_card("j_garb_Jim")
		local _first_dissolve = nil

		for k, v in pairs(jims) do
            if v ~= chosen_joker then 
                v:start_dissolve(nil, _first_dissolve)
                _first_dissolve = true
            end
        end
  end
}

SMODS.Joker {
  key = 'Surmacchio',
  loc_txt = {
    name = 'Surmacchio',
    text = {
	  "{C:green}#3# in #2#{} chance to",
	  "create a {C:dark_edition}Negative Tag{}",
	  "when shop is {C:attention}rerolled{}"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {odds = 15} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 5 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 10,
	loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {set = "Tag", key = "tag_negative", specific_vars = {}}
    return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
  end,
	
   calculate = function(self, card, context)
        if context.reroll_shop and pseudorandom('MioPadre') < G.GAME.probabilities.normal/card.ability.extra.odds then
            add_tag(Tag('tag_negative'))
			return {
                card = card,
                message = 'Surmacchio!',
                colour = G.C.PURPLE
            }
        end
  end
}

SMODS.Joker {
  key = 'SURGE',
  loc_txt = {
    name = 'THE SURGE',
    text = {
      "{X:mult,C:white} X#1# {} MULT",
	  "DESTROYS {s:1.2,C:red}ALL JOKERS{} IF CHIPS SCORED",
	  "ARE {C:attention}LESS THAN TWO TIMES{} REQUIRED SCORE"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {Xmult = 10} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 1, y = 4 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 10,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
	
   calculate = function(self, card, context)
   	
    if context.joker_main then
		return {
            Xmult_mod = card.ability.extra.Xmult,
			message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			card = card
        }
    end
	
		if context.end_of_round and G.GAME.chips / G.GAME.blind.chips < 2 then 
			local deletable_jokers = {}
			local _first_dissolve = nil
			play_sound('garb_surge', 1, 0.08)
			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
			end
			
			for k, v in pairs(deletable_jokers) do
                if v ~= chosen_joker then 
                    v:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
            end
		return {
			message = "SURGED!",
      card = card
		}
	end
  end
}

SMODS.Joker {
  key = 'chem7',
  loc_txt = {
    name = 'Chemical Seven',
    text = {
      "Sell this card for {C:money}7${}",
	  "If you own 3 copies of",
	  "{C:attention}Chemical Seven{}, gain {C:money}#1#${}",
	  "{C:red}self-destructs{}",
	  "{C:inactive}(This Joker may appear multiple times){}"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {money = 77, value = 6} },
  rarity = 1,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 2 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 3,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
	
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	
   add_to_deck = function(self, card, context)
		card.ability.extra_value = 6
		card:set_cost()
		local chemical7 = SMODS.find_card("j_garb_chem7")
		local _first_dissolve = nil
			
		if #chemical7 == 2 then
			chemical7[#chemical7 + 1] = card
			ease_dollars(card.ability.extra.money)
			
			for k, v in pairs(chemical7) do
                if v ~= chosen_joker then 
                    v:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
            end
		end
  end
}

SMODS.Joker {
  key = 'midasbomb',
  loc_txt = {
    name = 'Midas Bomb',
    text = {
      "Sell this card to",
	  "{C:red}destroy{} all {C:attention}Jokers{} and",
	  "earn {C:money}7x the sell value{} of all",
	  "{C:attention}Jokers{} destroyed this way"
    }
  },
  config = { extra = {value = 0} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 1, y = 2 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 7,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
	
   calculate = function(self, card, context)
   
	if context.buying_card then
			card.ability.extra_value = -3
			card:set_cost()
	end
	
    if context.selling_self then

            local sell_cost = 0
			local deletable_jokers = {}
			local _first_dissolve = nil

			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
			end
			
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= self and not G.jokers.cards[i].ability.eternal and (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
                    sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                end
			      end
				
			for k, v in pairs(deletable_jokers) do
                if v ~= chosen_joker then 
                    v:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
            end
			
			play_sound('garb_explosion')
			card.ability.extra_value = sell_cost*7 - 3
			card:set_cost()
				return {
					message = "Kaboom!",
                    colour = G.C.MONEY
                }
	end
  end
}

SMODS.Joker {
  key = 'black_hole',
  loc_txt = {
    name = 'Event Horizon',
    text = {
      "When a {C:planet}Planet{} card is used,",
	  "{C:green}#3# in #2#{} chance to",
	  "upgrade every {C:attention}poker hand{}"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {odds = 8} },
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 1, y = 5 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 10,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
  end,
	
   calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.set == 'Planet' and pseudorandom('BlackHole') < G.GAME.probabilities.normal/card.ability.extra.odds then
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
			card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
		    play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
		    play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end
  end
}

SMODS.Joker {
  key = 'd8',
  loc_txt = {
    name = 'Fluorite Octet',
    text = {
      "If played hand contains an {C:attention}8{},",
	  "{C:green}#3# in #2#{} chance to",
	  "give {X:mult,C:white} X#1# {} Mult"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {Xmult = 8, odds = 8} },
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 5 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 4,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
  end,
	
   calculate = function(self, card, context)

    if context.joker_main then
		local eight = 0
	    for i = 1, #context.scoring_hand do
			if context.scoring_hand[i]:get_id() == 8 then
				eight = 1
			end
		end
		
		if eight == 1 and pseudorandom('HUGE8ITCH') < G.GAME.probabilities.normal/card.ability.extra.odds then 
								return {
                  Xmult_mod = card.ability.extra.Xmult,
									message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
									card = card
                                }
		end
    end
  end
}

SMODS.Joker {
  key = 'ratboy',
  loc_txt = {
    name = 'Ratboy',
    text = {
      "{C:mult}+#1#{} Mult",
      "Plays a {C:attention}squeaky sound{}",
	  "every time a card is",
	  "{C:attention}triggered{}"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {mult = 4} },
  rarity = 1,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 6 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 2,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
	
   calculate = function(self, card, context)
   
    if context.individual and context.cardarea == G.play then

		G.E_MANAGER:add_event(Event({
			func = function()
			play_sound('garb_squeak', 0.8 + math.random()*0.3, 0.8)
				card:juice_up(0.1, 0.2)
				return true
			end
		}))
	end
	
	if context.joker_main then
      -- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

SMODS.Joker {
  key = 'onibi',
  loc_txt = {
    name = 'Onibi',
    text = {
      "When any {C:attention}Joker{} is sold,",
	  "{C:green}#3# in #2#{} chance to create a",
	  "{C:spectral}Spectral{} card"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {odds = 4} },
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 0 },
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	cost = 1,
	loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
  end,
	
   calculate = function(self, card, context)
	if context.selling_card and context.card.config.center.set == "Joker" and pseudorandom('ONIBI') < G.GAME.probabilities.normal/card.ability.extra.odds then
		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sixth')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
        return true
	end
  end
}

SMODS.Joker {
  key = 'equality',
  loc_txt = {
    name = 'Gender Equality',
    text = {
	  "All {C:attention}Queens{} are treated like", 
    "they were {C:attention}Kings{}"
    }
  },
  config = { extra = { chips = 0, chip_gain = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  rarity = 2,
  atlas = 'GarbJokers',
  pos = { x = 1, y = 6 },
  cost = 5,

    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	
loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end
}

local Getid_old = Card.get_id
function Card:get_id()
  local ret = Getid_old(self)
  if ret == 12 and next(find_joker("j_garb_equality")) then ret = 13 end
  return ret
end

if next(SMODS.find_mod("voc_deckall")) or next(SMODS.find_mod("vocalatro")) then
  SMODS.Joker {
    key = 'teto',
    loc_txt = {
      name = 'Teto!!!!',
      text = {
      "All scored {C:hearts}Kings of Hearts{}",
      "give {X:mult,C:white} X#1# {} Mult",
      "{s:0.8}i fucking love kasane teto{}"
      }
    },
    config = { extra = { Xmult = 2 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 7 },
    cost = 7,
      unlocked = true, --where it is unlocked or not: if true, 
      discovered = true, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 13 and context.other_card:is_suit("Hearts") then
          return {
            Xmult_mod = card.ability.extra.Xmult,
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            card = context.other_card
          }
        end
      end
    end
  }
end


SMODS.Joker {
  key = 'snowball',
  loc_txt = {
    name = 'Snowball',
    text = {
	  "{C:chips}+#1#{} Chips",
    "Amount is {C:attention}doubled{} when",
    "a card is {C:attention}retriggered{}",
    "{C:inactive}(Amount resets each hand){}",
    "{C:inactive}(Last payout: {C:chips}+#2#{} {C:inactive}Chips){}"
    }
  },
  config = { extra = { chips = 5, last_scored = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 1, y = 7 },
  cost = 7,

    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	
loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.last_scored} }
  end,
  
  calculate = function(self, card, context)

    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
        card = card}
    end

    if context.after then
      card.ability.extra.chips = 5
    end
	
    if context.individual and context.cardarea == G.play then
      local _card = context.other_card
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i] == _card then
                    if context.scoring_hand[no_retrigger] == _card then
                      card.ability.extra.chips = card.ability.extra.chips*2
                      card.ability.extra.last_scored = card.ability.extra.chips
                      return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips/2 } },
                        card = card
                      }
                    end
                    no_retrigger = i
                end
              end
          return nil
    end


  end
}

SMODS.Joker {
  key = 'angel',
  loc_txt = {
    name = 'The Angel of Salt',
    text = {
    "{C:green}#2# in #3#{} chance to destroy",
    "each scored {C:attention}Stone{} card",
    "This Joker gains {X:mult,C:white} X#4# {} Mult",
    "for card {C:attention}destroyed{} this way",
    "{C:inactive}(Currently {X:mult,C:white} X#1# {} Mult)"
    }
  },
  config = { extra = { Xmult = 1, odds = 4, Xmult_gain = 0.75 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.Xmult_gain } }
  end,
  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 7 },
  cost = 7,

    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
  
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
    local _card = context.other_card
                        if _card.ability.name == 'Stone Card' and pseudorandom('Salt') < G.GAME.probabilities.normal/card.ability.extra.odds then
                          _card.destroyme = true
                          G.E_MANAGER:add_event(Event({
                            func = function()
                              _card:start_dissolve(nil, _first_dissolve)
                              return true
                            end
                          }))
                          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                        return {
                          message = "Absorbed!",
                          card = card,
                        }
                      end
    end

    if context.destroying_card and context.destroying_card.destroyme then
      return{
          remove = true,
      }
  end


    if context.joker_main then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        card = card
      }
    end

  end
}

 -- LEGENDARIES
 
 
SMODS.Joker {
  key = 'abadeus',
  loc_txt = {
    name = 'Abadeus',
    text = {
	  "If current Blind is a {C:attention}Boss Blind{},",
	  "add a random {C:attention}Enhancement{},",
	  "{C:attention} Seal{} or {C:attention}Edition{} to each scored card"
    }
  },
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

  config = { extra = {swag = 1} },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 3 },
  
  -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
  soul_pos = { x = 0, y = 4 },
  cost = 20,
  -- SMODS specific function, gives the returned value in dollars at the end of round, double checks that it's greater than 0 before returning.
  
    calculate = function(self, card, context)

    if context.joker_main and G.GAME.blind.boss then
			for k, v in ipairs(context.scoring_hand) do
				local _abadeus = pseudorandom('abadeus', 1, 3)
        local triggered = false
				
				if _abadeus == 1 and not v.seal and not v.debuff  then
          triggered = true
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v:set_seal(SMODS.poll_seal({guaranteed = true}), nil, true)
							return true
						end
					}))
				end
				
				if _abadeus == 2 and not v.edition and not v.debuff then
          triggered = true
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v:set_edition(poll_edition("Abadeus", nil, true, true), true, true)
							return true
						end
					}))
				end
				
				if triggered == false and not v.debuff then
				local new_enhancement = SMODS.poll_enhancement {
					key = "abadeus",
					guaranteed = true
				}
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v:set_ability(G.P_CENTERS[new_enhancement])
							return true
						end
					}))
				end
			end	
		
			G.E_MANAGER:add_event(Event({
				func = function()
				play_sound('garb_abadeus1', 0.9 + math.random()*0.1, 0.8)
					card:juice_up(0.3, 0.4)
					return true
				end
			}))
			
			return {
				message = "Magic!",
				card = card
			}
    end
  end
  
}

SMODS.Joker {
  key = 'sara',
  loc_txt = {
    name = 'Sara :3',
    text = {
      "On {C:attention}first hand{} of round,",
	  "add a permanent copy of",
      "all scored {C:attention}Glass Cards{} to deck",
      "and draw them to {C:attention}hand",
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {} },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 1 },
  
  -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
  soul_pos = { x = 3, y = 1 },
  cost = 20,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_glass
    return { vars = {  } }
  end,
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
	
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
                        for i = 1, #context.scoring_hand do
						local card = context.other_card
                        if card.ability.name == 'Glass Card' then
                            G.playing_card = (G.playing_card and G.playing_card + i) or i
                            local _card = copy_card(context.other_card, nil, nil, G.playing_card)
                            _card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, _card)
                            G.hand:emplace(_card)
                            _card.states.visible = nil

                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    _card:start_materialize()
                                    return true
                                end
                            })) 
                            return {
                                message = localize('k_copied_ex'),
                                colour = G.C.CHIPS,
                                card = card,
                                playing_cards_created = {true}
                            }
						end
      end
    end
  end
}


SMODS.Joker {
  key = 'garb',
  loc_txt = {
    name = 'Garb',
    text = {
    "On {C:attention}first hand{} of round,",
	  "all listed probabilities are",
	  "{C:green}guaranteed"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {} },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 0, y = 1 },
  
  -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
  soul_pos = { x = 1, y = 1 },
  cost = 20,
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
	
   calculate = function(self, card, context)
   
    if context.first_hand_drawn and G.GAME.current_round.hands_played == 0 then
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = 777777
            end
    end
	
    if context.end_of_round or context.after then
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = 1
            end
    end
	
  end,
  
    remove_from_deck = function(self, card, from_debuff)
    -- Adds - instead of +, so they get subtracted when this card is removed.
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = 1
            end
  end
}

SMODS.Joker {
  key = 'scopacane',
  loc_txt = {
    name = 'Scopacane',
    text = {
    "When hand is played, unleash",
	  "the {C:dark_edition}True Arcana{} power of a",
	  "random {C:tarot}Tarot{} in consumable area",
	  "{C:inactive}(Unleashed {}{C:tarot}Tarots{}{C:inactive} are consumed){}"
    }
  },
  -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
  config = { extra = {} },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 2, y = 6 },
  
  -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
  soul_pos = { x = 3, y = 6 },
  cost = 20,
  
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
	
   calculate = function(self, card, context)
   
    local tarots = {}
    if context.before then
            for k, v in ipairs(G.consumeables.cards) do 
              if v.ability.set == "Tarot" then
                tarots[#tarots + 1] = v
              end
            end
              local to_kill = pseudorandom('Scopacane', 1, #tarots)
              if #tarots == 0 then return nil end

              ut = tarots[to_kill]

              play_sound('garb_scopacane')
              ut:juice_up(0.3, 0.5)

              local fool_c = G.GAME.last_tarot_planet or nil
              if ut.config.center.key == "c_fool" and fool_c ~= "c_fool" and fool_c ~= nil then
                local _card = SMODS.create_card{key = G.GAME.last_tarot_planet}
                _card:set_edition('e_negative', true)
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                local _card = SMODS.create_card{key = G.GAME.last_tarot_planet}
                _card:set_edition('e_negative', true)
                _card:add_to_deck()
                G.consumeables:emplace(_card)
              elseif ut.config.center.key == "c_fool" and fool_c == nil then
                return {
                  focus = ut,
                  message = "Not Copiable!",
                  colour = G.C.PURPLE
                  }
              end

              if ut.config.center.key == "c_hermit" then
                ease_dollars(math.max(0,math.min(G.GAME.dollars, 50)), true)    
              end

              if ut.config.center.key == "c_high_priestess" then
                add_tag(Tag('tag_meteor'))
              end

              if ut.config.center.key == "c_emperor" then
                  local _card = SMODS.create_card{set = 'Tarot'}
                  _card:set_edition('e_negative', true)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  local _card = SMODS.create_card{set = 'Tarot'}
                  _card:set_edition('e_negative', true)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
              end

              if ut.config.center.key == "c_wheel_of_fortune" then
                local eli = {}
                for k, v in pairs(G.jokers.cards) do
                  if v.ability.set == 'Joker' and (not v.edition) then
                      table.insert(eli, v)
                  end
                end  
                local chosen = pseudorandom('Scopacane', 1, #eli)
                alter = eli[chosen]
                  if pseudorandom('Scoparuota') < G.GAME.probabilities.normal/2 then
                    alter:set_edition(poll_edition("Scoparuota", nil, false, true, {"e_negative","e_polychrome"}))
                  else 	
                    ut:start_dissolve(nil, _first_dissolve)
                    return {
                    message = "Nope!",
                    colour = G.C.PURPLE
                    }
                  end
              end

              if ut.config.center.key == "c_temperance" then
                local sell_cost = 0
                for i = 1, #G.jokers.cards do
                  if G.jokers.cards[i] ~= self and (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
                      sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                  end
                end
                ease_dollars(sell_cost)
              end

              if ut.config.center.key == "c_hanged_man" then
                for i = 1, #G.hand.cards do
                    local _card = G.hand.cards[i]
                    _card.destroyme = true
                    _card:start_dissolve(nil, _first_dissolve)
                end
              end

              if ut.config.center.key == "c_strength" then
                for i = 1, #context.scoring_hand do
                  local _card = context.scoring_hand[i]
                  if _card:is_face() then
                    _card:flip()
                    SMODS.change_base(_card, nil, 'King')
                  else 
                    _card:flip()
                    SMODS.change_base(_card, nil, '10')
                  end
                  _card:juice_up(0.3, 0.5)
                end
              end

              if ut.config.center.key == "c_death" then
                  local _card = context.scoring_hand[#context.scoring_hand]
                  for i = 1, #context.scoring_hand-1 do
                    if i < 3 then
                    _card:flip()
                    copy_card(_card, context.scoring_hand[i])
                    context.scoring_hand[i]:juice_up(0.3, 0.5)
                    end
                  end
              end

              if ut.config.center.key == "c_judgement" then
              if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local new_card = SMODS.create_card{set = 'Joker'}
                new_card:set_edition(poll_edition("Scoparuota", nil, false, true, {"e_negative","e_polychrome"}))
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                else 	
                  return {
                  message = "Joker Slots Full!",
                  colour = G.C.PURPLE
                  }
              end
              end

              local enhancers = {"c_magician", "c_empress", "c_heirophant", "c_lovers", "c_chariot", "c_justice", "c_devil", "c_tower"}
              local enhancements = {G.P_CENTERS.m_lucky, G.P_CENTERS.m_mult, G.P_CENTERS.m_bonus, G.P_CENTERS.m_wild, G.P_CENTERS.m_steel, G.P_CENTERS.m_glass, G.P_CENTERS.m_gold, G.P_CENTERS.m_stone}
              for k, v in pairs(enhancers) do
              if ut.config.center.key == v then
                for i = 1, #context.scoring_hand do
                  local _card = context.scoring_hand[i]
                  _card:flip()
                  _card:juice_up(0.3, 0.5)
                  _card:set_ability(enhancements[k], nil, true)
                  end
              end
              end
              
            local suiters = {"c_star", "c_moon", "c_sun", "c_world"}
            local suites = {"Diamonds", "Clubs", "Hearts", "Spades"}
            for k, v in pairs(suiters) do
              if ut.config.center.key == v then
                for i = 1, #G.hand.cards do
                  local _card = G.hand.cards[i]
                  _card:flip()
                  _card:juice_up(0.3, 0.5)
                  SMODS.change_base(_card, suites[k], nil)
                end
              end
            end

              G.GAME.last_tarot_planet = ut.config.center.key
              ut:start_dissolve(nil, _first_dissolve)
              card:juice_up(0.3, 0.4)
              return nil 
            end

            if context.individual and context.cardarea == G.play then
                local _card = context.other_card
                if _card.facing == 'back' then 
                  G.E_MANAGER:add_event(Event({
                    func = function() 
                      for i=1, #context.scoring_hand do
                          if context.scoring_hand[i] == _card then
                            if context.scoring_hand[no_retrigger] == _card then return true end
                              local percent = 0.85 + (i-0.99)/(#context.scoring_hand-0.98)*0.3
                              play_sound('tarot2', percent, 0.6)
                              no_retrigger = i
                              _card:flip()
                            end
                          end
						        return true
                    end}))
                end
            end

            if context.individual and context.cardarea == G.hand then
              local _card = context.other_card
              if _card.facing == 'back' then 
                G.E_MANAGER:add_event(Event({
                  func = function() 
                    for i=1, #G.hand.cards do
                        if G.hand.cards[i] == _card then
                            if G.hand.cards[no_retrigger] == _card then return true end
                            local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                            play_sound('tarot2', percent, 0.6)
                            no_retrigger = i
                            _card:flip()
                          end
                        end
                  return true
                  end}))
              end
          end

          if context.destroying_card and context.destroying_card.destroyme then
            return{
                remove = true,
            }
        end
  end
}
assert(SMODS.load_file('unleashed_tarots.lua'))()

----------------------------------------------
------------MOD CODE END----------------------
    
