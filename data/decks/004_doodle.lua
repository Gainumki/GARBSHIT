return {
 SMODS.Back {
        key = 'doodle',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 2, y = 0 },    
        unlocked = false,
        discovered = true,
        config = {
            vouchers = {
                'v_garb_postcard',
            },
            consumables = {
                "c_garb_mascot"
            }
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {localize{type = 'name_text', key = 'v_garb_postcard', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'garb_Stamp'}}}
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_garb_garbdeck'},
        check_for_unlock = function(self, args)
            if args.type == "win_deck" then
                if get_deck_win_stake(self.unlock_condition.deck) > 0 then
                    return true
                end
            end          
        end,    
    },

    }