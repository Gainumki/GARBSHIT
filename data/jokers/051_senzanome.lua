return {
    SMODS.Joker {
        key = 'senzanome',
        loc_txt = {
            name = 'Senza Nome',
            text = {
                "Gain an additional {C:attention}Tag{}",
                "after {C:attention}skipping{} a blind"
            }
        },
        -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
        config = {extra = {}},
        rarity = 2,
        atlas = 'GarbJokers',
        pos = {x = 5, y = 13},

        unlocked = true,
        discovered = false, -- whether or not it starts discovered
        blueprint_compat = true, -- can it be blueprinted/brainstormed/other
        eternal_compat = true, -- can it be eternal
        perishable_compat = true, -- can it be perishable
        cost = 6,
        loc_vars = function(self, info_queue, card) 
        if config.on_card_credits and not config.repainted then
          info_queue[#info_queue+1] = {set = "Other", key = "credits2", specific_vars = {"SaraMint"}} 
        end
          return {vars = {}} 
        end,

        calculate = function(self, card, context)
            if context.skip_blind then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local tagkey = get_next_tag_key()
                        local tag = Tag(tagkey)
                        if tagkey == 'tag_orbital' then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end

                            tag.ability.orbital_hand =
                                pseudorandom_element(_poker_hands,
                                                     pseudoseed('orbital'))
                        end
                        add_tag(tag)
                        return true
                    end
                }))
                return {message = "+1 Tag!"}

            end
        end
    }

}
