return {
 CardSleeves.Sleeve {
        key = "doodle",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 2, y = 0 },
        config = {
            vouchers = {
                'v_garb_postcard',
            },
            consumables = {
                "c_garb_mascot"
            }
        },
        unlocked = false,
        unlock_condition = {deck = "b_garb_doodle", stake = "stake_black"},

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_doodle" then
                vars = {localize{type = 'name_text', key = 'v_garb_guano', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'garb_Stamp'}}
                self.config.consumables = {}
                self.config.vouchers = { "v_garb_guano" }
                key = self.key .. "_alt"
            else
                vars = {localize{type = 'name_text', key = 'v_garb_postcard', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'garb_Stamp'}}
                self.config.vouchers = { "v_garb_postcard" }
                self.config.consumables = { "c_garb_mascot" }
            end
            return { key = key, vars = vars }
        end,    
    },

    }