return {

    -- META STUFF

    SMODS.UndiscoveredSprite {
        key = 'Stamp',
        atlas = 'Stamps',
        pos = {x = 0, y = 0}
    },

    SMODS.Atlas({key = "GarbPartner", path = "partners.png", px = 46, py = 58}),

    SMODS.Atlas({key = "modicon", path = "garb_icon.png", px = 32, py = 32}),

    SMODS.Atlas({
        key = "GarbTags",
        path = (config.repainted and "repainted/" or "") .. "tags.png",
        px = 34,
        py = 34
    }),

    SMODS.Atlas({key = "GarbSleeves", path = "Sleeves.png", px = 73, py = 95}),

    SMODS.Atlas({key = "GarbVouchers", path = "Vouchers.png", px = 71, py = 95}),

    SMODS.Atlas {
        key = 'GarbJokers', -- atlas key
        path = (config.repainted and "repainted/" or "") .. 'Jokers.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Atlas {
        key = 'GarbBoosters', -- atlas key
        path = (config.repainted and "repainted/" or "") .. 'Boosters.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Atlas {
        key = 'Stamps', -- atlas key
        path = 'Stamps.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Atlas {
        key = 'GarbConsumables', -- atlas key
        path = (config.repainted and "repainted/" or "") .. 'Consumables.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Atlas {
        key = 'GarbDecks', -- atlas key
        path = 'Decks.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Atlas {
        key = 'GarbEnhancements', -- atlas key
        path = (config.repainted and "repainted/" or "") .. 'Enhancements.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    }, SMODS.Sound {key = "mirrorz", path = {["default"] = "mirror2.ogg"}},

    SMODS.Atlas{      
        key = 'GarbStickers', -- atlas key
        path = 'Stickers.png', -- atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
        px = 71, -- width of one card
        py = 95 -- height of one card
    },
    SMODS.Sound {
        key = "abadeus1",
        path = {["default"] = "abadeus2.ogg"},
        volume = 0.5
    }, SMODS.Sound {
        key = "explosion",
        path = {["default"] = "explosion.ogg"},
        volume = 0.5
    },

    SMODS.Sound {
        key = "surge",
        path = {["default"] = "surge2.ogg"},
        volume = 0.4
    },

    SMODS.Sound {
        key = "surge",
        path = {["default"] = "surge2.ogg"},
        volume = 0.2
    },

    SMODS.Sound {
        key = "squeak",
        path = {["default"] = "squeak.wav"},
        volume = 0.4
    }, SMODS.Sound {
        key = "scopacane",
        path = {["default"] = "scopacane2.ogg"},
        volume = 0.5
    }, SMODS.Sound {
        key = "jimboss_defeat",
        path = {["default"] = "jimboss_defeat.ogg"},
        volume = 0.5
    }, SMODS.Sound {
        key = "jimboss_hit",
        path = {["default"] = "jimboss_hit.wav"},
        volume = 0.5
    },

    SMODS.Sound {
        key = "infect",
        path = {["default"] = "infect.ogg"},
        volume = 0.5
    },

    SMODS.Sound {key = "honk", path = {["default"] = "honk.ogg"}, volume = 0.8},

    SMODS.Sound {key = "snap", path = {["default"] = "snap_nodrama.ogg"}},

    SMODS.Sound {key = "bisso", path = {["default"] = "bisso.ogg"}},

    SMODS.Sound {key = "gong", path = {["default"] = "gong.ogg"}, volume = 0.5},

    SMODS.Sound {
        key = "gunshot",
        path = {["default"] = "gunshot.ogg"},
        volume = 0.4
    }, SMODS.Sound {key = "bubble", path = {["default"] = "bubble.ogg"}},

    SMODS.Sound {key = "kirby_powerup",path = {["default"] = "kirby_powerup.ogg"}}, 
    SMODS.Sound {key = "ping", path = {["default"] = "ping.ogg"}},
    SMODS.Sound {key = "coin", path = {["default"] = "coin.ogg"}},

    SMODS.Sound {key = "knock", path = {["default"] = "knock.ogg"}},
    SMODS.Sound {key = "click", path = {["default"] = "click.ogg"}},
    SMODS.Sound {key = "shiny", path = {["default"] = "shiny.ogg"}},
    SMODS.Sound {key = "secret", path = {["default"] = "secret.ogg"}},
    SMODS.Sound {key = "shade1", path = {["default"] = "shade.ogg"}},
    SMODS.Sound {key = "shade2", path = {["default"] = "shade2.ogg"}},

    SMODS.Sound {
        key = "music_stamps",
        path = {["default"] = "music_stamps.ogg"},
        sync = true,
        pitch = 1,
        select_music_track = function()
            return
                G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and
                    G.pack_cards.cards[1].ability.set == "Stamp"
        end
    }, SMODS.Sound {
        key = "music_minigame",
        path = {["default"] = "music_minigame.ogg"},
        pitch = 1,
        volume = 0.4,
        sync = false,
        select_music_track = function()
            return (G.STATE == 20 and G.garb_MINIGAME and G.garb_MINIGAME.score > 0)
        end
    }, SMODS.Sound {
        key = "music_minigametutorial",
        path = {["default"] = "music_minigametutorial.ogg"},
        pitch = 1,
        select_music_track = function() return G.STATE == 21 end
    }, SMODS.Sound {
        key = "music_rainbow",
        path = {["default"] = "music_3dsfunk.ogg"},
        sync = true,
        pitch = 1,
        select_music_track = function()
            return
                G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and
                    G.pack_cards.cards[1].config.center.rarity == "garb_rainbow"
        end
    }, SMODS.Sound {
        key = "music_fukkireta",
        path = {["default"] = "music_fukkireta.ogg"},
        sync = false,
        pitch = 1,
        select_music_track = function()
            return next(SMODS.find_card("j_garb_teto")) and 20 and
                       config.fukkireta or false
        end
    }, SMODS.Sound {
        key = "music_calliope",
        path = {["default"] = "music_calliope.ogg"},
        sync = false,
        pitch = 1,
        select_music_track = function()
            return G.SETTINGS.HIVE and 100 or false
        end
    }, 
    SMODS.Sound {
        key = "music_fun",
        path = {["default"] = "music_funisinfinite.ogg"},
        sync = false,
        pitch = 1,
        select_music_track = function()
            return garb_funisinfinite and 100
        end
    }, 
     SMODS.Sound {
        key = "music_yababaina",
        path = {["default"] = "music_yababaina.ogg"},
        sync = false,
        pitch = 1,
        select_music_track = function()
            return next(SMODS.find_card("j_garb_yababaina")) and 100 and
                       config.fukkireta or false
        end
    }, 
    SMODS.Sound({key = "music_hall", path = 'music_hall.ogg', sync = false, pitch = 1, volume = 0.7, select_music_track = function() return (G.STATE == G.STATES.garb_SPECIAL_THANKS) end}),

    SMODS.Atlas({key = "fish", path = "fish.png", px = 71, py = 95}),

    SMODS.Shader {
        key = 'fish',
        path = 'fish.fs',
        send_vars = function(sprite, card)
            return {fishTexture = G.ASSET_ATLAS['garb_fish'].image}
        end
    }
}
