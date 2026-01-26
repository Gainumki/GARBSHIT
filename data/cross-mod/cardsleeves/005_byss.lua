return {
 CardSleeves.Sleeve {
        key = "byss",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 0, y = 1 },
        config = {
            slots = 1
        },
        loc_vars = function(self)
            local key, vars
            vars = {self.config.slots}
            if self.get_current_deck_key() == "b_garb_byss" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key, vars = vars }
        end,    
        apply = function(self, back)
            G.GAME.starting_params.joker_slots = 1
        end,
        calculate = function(self,card,context)
            if context.buying_card and context.card.ability.set == "Voucher" and self.get_current_deck_key() ~= "b_garb_byss" then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('garb_bisso')    
                card_eval_status_text(G.jokers, 'extra', nil, nil, nil, {message = "+1 Slots!", colour = G.C.DARK_EDITION})
            elseif context.buying_card and context.card.ability.set == "Voucher" and self.get_current_deck_key() == "b_garb_byss" then
                G.hand.config.card_limit = G.hand.config.card_limit + 1
                card_eval_status_text(G.hand, 'extra', nil, nil, nil, {message = "+1 Size!", colour = G.C.DARK_EDITION})                    
            end
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_garb_cycle'},
        check_for_unlock = function(self, args)
            if args.type == "win_deck" then
                if get_deck_win_stake(self.unlock_condition.deck) > 0 then
                    return true
                end
            end          
        end,    

    },

}