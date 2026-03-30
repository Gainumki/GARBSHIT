----------------------------------------------
------------MOD CODE -------------------------
local mod = SMODS.current_mod
config = mod.config
garb_enabled = copy_table(config)

has_played_silksong =
    string.sub(mod.path, 1, string.find(mod.path, "AppData")) ..
        'ppData/LocalLow/Team Cherry/Hollow Knight Silksong/838914769/user1.dat'
has_played_silksong = NFS.getInfo(has_played_silksong)

local easedollars_ref = ease_dollars
function ease_dollars(mod, instant)
    G.GAME.BloomModifier = G.GAME.BloomModifier or 1
    if to_big(mod) > to_big(0) and G.GAME.BloomModifier > 1 then
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1,
        func = function()
            play_sound('garb_coin', 1.6, 0.4)
            easedollars_ref(math.floor(mod*(G.GAME.BloomModifier-1)), instant)
            return true
        end
        }))
    end
    easedollars_ref(mod, instant)
end

function jimboReturned()
    if pseudorandom('ohheyitsthegun') > 0.80 and G.GAME.objectivelysold and
        (#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit) then
        local new_card = SMODS.create_card {
            key = "j_garb_objectively",
            no_edition = true
        }
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        new_card:start_materialize()
        play_sound('timpani')
        play_sound('garb_ping')
        card_eval_status_text(new_card, "extra", nil, nil, nil, {message = "!!"})
        G.GAME.objectivelysold = false
    end
end

if next(SMODS.find_mod("balagay")) then
    config.gay = true
else
    config.gay = false
end

local fun = (mod.path .. "assets/fun.png")
fun = assert(NFS.newFileData(fun))
fun = love.graphics.newImage(fun)

local drawhook = love.draw
function love.draw()
    drawhook()
    local _xscale = love.graphics.getWidth() / 2560
    local _yscale = love.graphics.getHeight() / 1440

    if garb_blackout then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", -1000, -1000, 5000, 5000)
    end
    if garb_funisinfinite then
        check_for_unlock({type = 'funisinfinite'})
        G.FUNCS:exit_overlay_menu()
        if G.SPLASH_LOGO then G.SPLASH_LOGO:remove() end
        if G.SMODS_VERSION_UI then G.SMODS_VERSION_UI:remove() end
        if G.VERSION_UI then G.VERSION_UI:remove() end
        if G.MAIN_MENU_UI then G.MAIN_MENU_UI:remove() end
        if G.PROFILE_BUTTON then G.PROFILE_BUTTON:remove() end
        if G.title_top then G.title_top:remove() end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(fun, 0, 0, 0, _xscale, _yscale)
    end
end

local function garb_batch_load(txt)
    local joker_files = NFS.getDirectoryItems(mod.path .. "data/" .. txt)
    sendInfoMessage(mod.path .. "data/" .. txt)
    local txt = txt .. '/'
    for _, file in pairs(joker_files) do
        sendInfoMessage(file)
        if string.find(file, ".lua") then
            assert(SMODS.load_file("data/" .. txt .. file))()
        end
    end
    sendInfoMessage("FINISHED BATCH LOAD FOR " .. txt)
    return true
end

to_big = to_big or function(x, y) return x end

SMODS.current_mod.optional_features = function()
    return {cardareas = {discard = true, deck = true}}
end

local function config_matching()
    for k, v in pairs(garb_enabled) do
        if v ~= config[k] then return false end
    end
    return true
end

function G.FUNCS.garb_restart()
    if config_matching() then
        SMODS.full_restart = 0
    else
        SMODS.full_restart = 1
    end
end

GARB_TEXTURES = {'Standard', 'Repainted'}

G.FUNCS.garb_textures = function(args)
  G.SETTINGS.GRAPHICS.garb_textures = args.to_key
  config.repainted = (G.SETTINGS.GRAPHICS.garb_textures == 2) and true or false
  G:save_settings()
  G.FUNCS.garb_restart()
end


SMODS.current_mod.config_tab = function()
    garb_nodes = {
        {
            n = G.UIT.R,
            config = {align = "cm"},
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = "Options:",
                            colours = {G.C.WHITE},
                            shadow = true,
                            scale = 0.4
                        })
                    }
                }
            }
        }, create_toggle({
            label = "Custom Title Screen (Requires Restart)",
            ref_table = config,
            ref_value = "title",
            callback = G.FUNCS.garb_restart
        }), create_toggle({
            label = "Old Teto Sprite",
            ref_table = config,
            ref_value = "oldteto"
        }), create_toggle({
            label = "On-Card Credits",
            ref_table = config,
            ref_value = "on_card_credits"
        }), create_toggle({
            label = "Joker Music (Fukkireta, Yababaina)",
            ref_table = config,
            ref_value = "fukkireta"
        }), create_option_cycle({
            w = 4,
            scale = 0.8,
            label = "Mod Textures (Requires Restart)",
            options = GARB_TEXTURES,
            opt_callback = 'garb_textures',
            current_option = G.SETTINGS.GRAPHICS.garb_textures,
            ref_table = G.SETTINGS.GRAPHICS,
            ref_value = 'garb_textures'
        }), 
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

function card_transform(card, key, values)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip();
            play_sound('card1');
            card:juice_up(0.3, 0.3);
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            card:remove_from_deck()
            if G.P_CENTERS[key] then
                key = key
            else
                key = "j_joker"
            end
            card.config.center = G.P_CENTERS[key]
            card:set_ability(card.config.center.key, true)
            if values then card.ability.extra = values.ability.extra end
            card:add_to_deck()
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip();
            play_sound('tarot2');
            card:juice_up(0.3, 0.3);
            return true
        end
    }))
end

function card_transform_shop(card, key)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip();
            play_sound('card1');
            card:juice_up(0.3, 0.3);
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            if G.P_CENTERS[key] then
                key = key
            else
                key = "j_joker"
            end
            card.config.center = G.P_CENTERS[key]
            card:set_ability(card.config.center.key, true)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip();
            play_sound('tarot2');
            card:juice_up(0.3, 0.3);
            return true
        end
    }))
end

function get_straight(hand, min_length, skip, wrap)
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    local jumps = {}
    for k, _ in pairs(SMODS.Ranks) do ranks[k] = {} end
    for _, card in ipairs(hand) do
        local id = card:get_id()
        if SMODS.has_enhancement(card, 'm_garb_jump') then
            id = 0
            table.insert(jumps, card)
        end
        if id > 0 then
            for k, v in pairs(SMODS.Ranks) do
                if v.id == id then
                    table.insert(ranks[k], card);
                    break
                end
            end
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
        if not start and not wrap and rank.straight_edge then return ret end
        for _, v in ipairs(rank.next) do
            ret[#ret + 1] = v
            if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
                for _, w in ipairs(SMODS.Ranks[v].next) do
                    ret[#ret + 1] = w
                end
            end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _, k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) or #jumps >= 1 then
            tuples[#tuples + 1] = {k}
            tuples[#tuples].jumps_remaining = #jumps -
                                                  (next(ranks[k]) and 0 or 1)
        end
    end
    for i = 2, #hand + 1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i + tuple.jumps_remaining ~= #hand + 1 then
                for _, l in ipairs(next_ranks(tuple[i - 1], i == 2)) do
                    if next(ranks[l]) or #jumps >= 1 then
                        local new_tuple = {}
                        new_tuple.jumps_remaining =
                            tuple.jumps_remaining - (next(ranks[l]) and 0 or 1)
                        for _, v in ipairs(tuple) do
                            new_tuple[#new_tuple + 1] = v
                        end
                        new_tuple[#new_tuple + 1] = l
                        new_tuples[#new_tuples + 1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i + tuple.jumps_remaining > min_length and not any_tuple then
                local straight = {}
                for _, v in ipairs(tuple) do
                    for _, card in ipairs(ranks[v]) do
                        straight[#straight + 1] = card
                    end
                end
                for _, card in ipairs(jumps) do
                    straight[#straight + 1] = card
                end
                ret[#ret + 1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a, b) return #a > #b end)
    return ret
end

create_card_ref1 = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize,
                     soulable, forced_key, key_append)
    local _card = create_card_ref1(_type, area, legendary, _rarity,
                                   skip_materialize, soulable, forced_key,
                                   key_append)

    if _card.config.center.key == "j_garb_zoroark" then
        local evil_pool = get_current_pool('Joker')
        local _key = pseudorandom_element(evil_pool, pseudoseed('zoroark'))
        _card.ability.disguised = "j_garb_zoroark"
        card_transform_shop(_card, _key)

    end
    return _card
end

set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if G.SETTINGS.HIVE and center.set == 'Joker' then
        center = G.P_CENTERS["j_garb_hiveSCARE"]
    end
    set_ability_ref(self, center, initial, delay_sprites)
end

local update_ref = Card.update
function Card:update(dt)
    if self.config.center and self.config.center.rarity == 'garb_rainbow' and
        (not self.config.center.discovered) and (self.sprite_facing ~= 'back') then
        self.sprite_facing = 'back'
        self.facing = 'back'
        self.mystery = true
    end

    if self.config.center and self.config.center.rarity == 'garb_rainbow' and
        self.config.center.discovered and self.sprite_facing == 'back' and
        self.mystery then
        self.sprite_facing = 'front'
        self.facing = 'front'
        self.mystery = nil
    end

    if G.ALBERT_LEGENDARY and self.config.center.key == G.ALBERT_LEGENDARY and
        self.area.config.collection and not self.stickered then
        apply_remove_sticker(self, "garb_albert_selected")
        self.stickered = true
    end

    if self.stickered and
        (not G.ALBERT_LEGENDARY or G.ALBERT_LEGENDARY and self.config.center.key ~=
            G.ALBERT_LEGENDARY) then
        self:flip()
        apply_remove_sticker(self, "garb_albert_selected")
        self.stickered = false
        self:flip()
    end

    update_ref(self, dt)
end

local draw_ref = Card.draw
function Card:draw(layer)
    if self.config.center.rarity == 'garb_rainbow' and
        self.area.config.collection and not self.deckedoutinswag then
        self.children.back = Sprite(self.T.x, self.T.y, self.T.w, self.T.h,
                                    G.ASSET_ATLAS["garb_GarbDecks"],
                                    {x = 0, y = 2})
        self.children.back.states.hover = self.states.hover
        self.children.back.states.click = self.states.click
        self.children.back.states.drag = self.states.drag
        self.children.back.states.collide.can = false
        self.children.back:set_role({
            major = self,
            role_type = 'Glued',
            draw_major = self
        })
        self.deckedoutinswag = true
    elseif self.config.center.rarity == 'garb_rainbow' and
        self.area.config.collection and not self.deckedoutinswag then
        self.children.back = Sprite(self.T.x, self.T.y, self.T.w, self.T.h,
                                    G.ASSET_ATLAS["garb_GarbDecks"],
                                    {x = 0, y = 2})
        self.children.back.states.hover = self.states.hover
        self.children.back.states.click = self.states.click
        self.children.back.states.drag = self.states.drag
        self.children.back.states.collide.can = false
        self.children.back:set_role({
            major = self,
            role_type = 'Glued',
            draw_major = self
        })
        self.deckedoutinswag = true
    end

    if self.config.center.key == 'j_garb_showoff' and
        (self.edition and self.edition.negative) and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 1, y = 9})
    elseif self.config.center.key == 'j_garb_showoff' and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 6, y = 7})
    end

    if self.config.center.key == 'j_garb_zoroark' and
        (self.edition and self.edition.negative) and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 2, y = 10})
    elseif self.config.center.key == 'j_garb_zoroark' and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 1, y = 10})
    end

    if self.config.center.key == 'j_garb_blank' and (self.antimattered) and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 2, y = 12})
    elseif self.config.center.key == 'j_garb_blank' and
        self.config.center.discovered then
        self.children.center:set_sprite_pos({x = 4, y = 11})
    end

    if self.config.center.key == 'j_garb_teto' and
        (config.oldteto or config.repainted) and
        not (self.locked or not self.config.center.discovered) then
        self.children.center:set_sprite_pos({x = 0, y = 4})
    elseif self.config.center.key == 'j_garb_teto' and
        not (self.locked or not self.config.center.discovered) then
        self.children.center:set_sprite_pos({x = 3, y = 10})
    end

    draw_ref(self, layer)
end

function Card:dialogue_say_stuff(n, not_first, pitch)
    self.talking = true
    local pitch = pitch or 1
    if not not_first then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                if self.children.speech_bubble then
                    self.children.speech_bubble.states.visible = true
                end
                self:dialogue_say_stuff(n, true, pitch)
                return true
            end
        }))
    else
        if n <= 0 then
            self.talking = false;
            return
        end
        play_sound('voice' .. math.random(1, 11),
                   pitch * (math.random() * 0.2 + 1), 0.5)
        self:juice_up(0.4/G.SETTINGS.GAMESPEED, 0.4/G.SETTINGS.GAMESPEED)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            blockable = false,
            blocking = false,
            delay = 0.13,
            func = function()
                self:dialogue_say_stuff(n - 1, true, pitch)
                return true
            end
        }))
    end
end

function Card:add_dialogue(text_key, align, yap_amount, baba_pitch)
    if self.children.speech_bubble then self.children.speech_bubble:remove() end
    self.config.speech_bubble_align = {
        align = align or 'bm',
        offset = {x = 0, y = 0},
        parent = self
    }
    self.children.speech_bubble = UIBox {
        definition = G.UIDEF.speech_bubble(text_key, {quip = true}),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{
        role_type = "Minor",
        xy_bond = "Strong",
        r_bond = "Strong",
        major = self
    }
    self.children.speech_bubble.states.visible = false
    local yap_amount = (yap_amount or 5)*G.SETTINGS.GAMESPEED/2
    local baba_pitch = baba_pitch or 1
    self:dialogue_say_stuff(yap_amount, nil, baba_pitch)
end

function apply_remove_sticker(card, sticker)
    if card[sticker] or card.ability[sticker] then
        SMODS.Stickers[sticker]:apply(card, false)
    else
        SMODS.Stickers[sticker]:apply(card, true)
    end
end

function Card:remove_dialogue(timer)
    local timer = (timer * G.SETTINGS.GAMESPEED) or 0
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        blockable = false,
        blocking = false,
        delay = timer,
        func = function()
            if self.children.speech_bubble then
                self.children.speech_bubble:remove();
                self.children.speech_bubble = nil
            end
            return true
        end
    }))
end

local click_ref = Card.click
function Card:click()
    if not (self.talking or self.exploding) then
        self.counter = self.counter and (self.counter + 1) or 1
    end

    -- print("clicked!"..self.config.center.key)

    if self.config.center.key == "j_garb_ratboyTITLE" then
        play_sound('garb_squeak', 0.8 + math.random() * 0.3, 0.8)
        if self.counter >= 100 then check_for_unlock({type = 'cute'}) end
    end

    if (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')) and
        self.config.center and self.config.center.rarity == 4 and
        self.area.config.collection and
        not (G.P_CENTERS["b_garb_albert"].locked or self.locked or
            not self.config.center.discovered) then
        if G.ALBERT_LEGENDARY and G.ALBERT_LEGENDARY == self.config.center.key then
            G.ALBERT_LEGENDARY = nil
            play_sound('cancel', 0.8, 0.8)
        else
            self:flip()
            G.ALBERT_LEGENDARY = self.config.center.key
            play_sound('coin2')
            self:flip()
        end
    end

    if self.config.center.key == "j_garb_showoff" and
        self.area.config.collection and
        not (self.locked or not self.config.center.discovered) then
        play_sound('garb_click',
                   0.9 + (self.edition and self.edition.negative and 1 or 0) +
                       ((self.edition and self.edition.negative and -0.5 or 1) *
                           self.counter * 0.0833), 1)
        if self.edition and self.edition.negative and self.counter == 24 then
            self.counter = 0
            self:flip()
            play_sound('cancel', 0.8)
            self:set_edition({negative = false}, true, true)
            self:flip()
        elseif self.counter == 12 then
            self:flip()
            play_sound("garb_shiny", 1, 0.4)
            self:set_edition({negative = true}, true, true)
            self:flip()
            self:juice_up()
        end
    end

    if self.config.center.key == "j_garb_zoroark" and
        self.area.config.collection and
        not (self.locked or not self.config.center.discovered) then
        play_sound('garb_click',
                   0.9 + (self.edition and self.edition.negative and 1 or 0) +
                       ((self.edition and self.edition.negative and -0.5 or 1) *
                           self.counter * 0.0833), 1)
        if self.edition and self.edition.negative and self.counter == 24 then
            self.counter = 0
            self:flip()
            self:set_edition({negative = false}, true)
            self:flip()
        elseif self.counter == 12 then
            self:flip()
            self:set_edition({negative = true}, true)
            self:flip()
            self:juice_up()
        end
    end

    if self.area and self.area.config.collection and self.config.center.key ==
        "j_garb_blank" and self.config.center.discovered then
        play_sound('garb_click', 0.9 + (self.antimattered and 1 or 0) +
                       ((self.antimattered and -1 or 1) * self.counter * 0.0833),
                   1)
        if self.counter >= 12 then
            self:flip()
            self.antimattered = not self.antimattered
            self:set_edition(self.antimattered and "e_negative" or {})
            self.counter = 0
            self:flip()
        end
    end

    if self.area and self.area.config.collection and self.config.center.key ==
        "j_garb_objectively" and self.config.center.discovered then
        if self.counter >= 12 then
            garb_funisinfinite = true
            play_sound('cancel', 0.7, 0.8)
        end
    end

    if G.GAME.jimmies then
        for k, v in pairs(G.GAME.jimmies) do
            if v == self then
                if self.children.speech_bubble then
                    self:remove_partner_speech_bubble()
                elseif not G.GAME.partner_click_deal then
                    G.GAME.partner_click_deal = true
                    local ret = v:calculate_partner({partner_click = true})
                    if ret then
                        SMODS.trigger_effects({{individual = ret}}, v)
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.partner_click_deal = nil
                            return true
                        end
                    }))
                end
            end
        end
    end
    click_ref(self)
end

local Rclick_ref = Card.partner_R_click
function Card:partner_R_click()
    if G.GAME.jimmies then
        for k, v in pairs(G.GAME.jimmies) do
            if v == self then
                if not G.GAME.partner_R_click_deal then
                    G.GAME.partner_R_click_deal = true
                    local ret = v:calculate_partner({partner_R_click = true})
                    if ret then
                        SMODS.trigger_effects({{individual = ret}}, v)
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.partner_R_click_deal = nil
                            return true
                        end
                    }))
                end
            end
        end
    end
    Rclick_ref(self)
end

local use_consumeable_old = Card.use_consumeable
local quadrant_hands = {
    "garb_blush", "garb_caliginous", "garb_ashen", "garb_pale"
}
function Card:use_consumeable(area, copier)
    for i = 1, #quadrant_hands do
        if self.ability.consumeable.hand_type == "Flush" and SHIPPINGWALL_HAND and
            localize(quadrant_hands[i], 'poker_hands') == SHIPPINGWALL_HAND then
            update_hand_text({
                sound = 'button',
                volume = 0.7,
                pitch = 0.8,
                delay = 0.3
            }, {
                handname = localize(quadrant_hands[i], 'poker_hands'),
                chips = G.GAME.hands[quadrant_hands[i]].chips,
                mult = G.GAME.hands[quadrant_hands[i]].mult,
                level = G.GAME.hands[quadrant_hands[i]].level
            })
            level_up_hand(self, quadrant_hands[i], nil, 1)
            update_hand_text({
                sound = 'button',
                volume = 0.7,
                pitch = 1.1,
                delay = 0
            }, {mult = 0, chips = 0, handname = '', level = ''})
        elseif self.ability.consumeable.hand_type == "Flush" then
            level_up_hand(self, quadrant_hands[i], true, 1)
        end
    end
    local ret = use_consumeable_old(self)
    return ret
end

function conversionTarot(hand, newcenter)
    -- Animation ported from basegame Tarot
    -- Hi Unstable devs I love you I ported this code over from your mod, hope you don't mind

    for i = 1, #hand do
        local percent = 1.15 - (i - 0.999) / (#hand - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                hand[i]:flip();
                play_sound('card1', percent);
                hand[i]:juice_up(0.3, 0.3);
                return true
            end
        }))
    end
    delay(0.2)

    -- Handle the conversion
    for i = 1, #hand do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                hand[i]:set_ability(G.P_CENTERS[newcenter])
                return true
            end
        }))
    end

    for i = 1, #hand do
        local percent = 0.85 + (i - 0.999) / (#hand - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                hand[i]:flip();
                play_sound('tarot2', percent, 0.6);
                hand[i]:juice_up(0.3, 0.3);
                return true
            end
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            G.hand:unhighlight_all();
            return true
        end
    }))
    delay(0.5)
end

local Getid_old = Card.get_id
function Card:get_id()
    local ret = Getid_old(self)
    if ret == 12 and next(find_joker("j_garb_equality")) then ret = 13 end
    return ret
end

-- TITLE SCREEN
if config.title and not next(SMODS.find_mod("Cryptid")) and
    not next(SMODS.find_mod("balatrostuck")) then
    SMODS.Atlas({
        key = "balatro",
        path = G.SETTINGS.HIVE and "Logo_HIVE.png" or
            (config.repainted and "repainted/" or "") .. "Logo.png",
        px = 333,
        py = 216,
        prefix_config = {key = false}
    })

    function add_card_to_title(use_key)
        local newcard = SMODS.create_card({
            set = "Joker",
            area = G.title_top,
            key = use_key,
            no_edition = true
        })
        -- recenter the title
        newcard:start_materialize({G.C.WHITE, G.C.SECONDARY_SET.Personality},
                                  true, 2.5)
        G.title_top:emplace(newcard)
        -- make the card look the same way as the title screen Ace of Spades
        newcard.T.scale = 1.32
        newcard.no_ui = true
    end

    local main_menu_ref = Game.main_menu
    Game.main_menu = function(change_context)
        if has_played_silksong then check_for_unlock({type = 'silksong'}) end
        if config.repainted then check_for_unlock({type = 'micio'}) end
        if GARB_SPECIAL_THANKS then GARB_SPECIAL_THANKS = false end
        local ret = main_menu_ref(change_context)
        add_card_to_title(G.HIVE and "j_garb_truehivemind" or "j_garb_garbTITLE")
        G.title_top.T.w = G.title_top.T.w * 1.7675 * 1.2
        G.title_top.T.x = G.title_top.T.x - 0.8 * 1.8
        G.SPLASH_BACK:define_draw_steps({
            {
                shader = 'splash',
                send = {
                    {
                        name = 'time',
                        ref_table = G.TIMERS,
                        ref_value = 'REAL_SHADER'
                    }, {name = 'vort_speed', val = 0.4}, {
                        name = 'colour_1',
                        ref_table = G.C,
                        ref_value = G.SETTINGS.HIVE and 'BLACK' or 'GARB_T2'
                    }, {
                        name = 'colour_2',
                        ref_table = G.C,
                        ref_value = G.SETTINGS.HIVE and 'GREY' or 'GARB_T1'
                    }
                }
            }
        })
        return ret
    end
end

SMODS.current_mod.description_loc_vars = function()
    return {background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2}
end

SMODS.ConsumableType {
    key = 'Stamp',
    primary_colour = HEX("73A557"),
    secondary_colour = HEX("73A557"),
    loc_txt = {
        name = 'Stamp', -- used on card type badges
        collection = 'Stamp Cards', -- label for the button to access the collection
        undiscovered = { -- description for undiscovered cards in the collection
            name = 'Not Discovered',
            text = {
                "Purchase or use", "this card in an", "unseeded run to",
                "learn what it does"
            }
        }
    },
    shop_rate = 0.0,
    default = "c_garb_fruit"
}

SMODS.Booster:take_ownership_by_kind('Standard', {
    create_card = function(self, card, i)
        local _key = nil
        local _edition = poll_edition('standard_edition' ..
                                          G.GAME.round_resets.ante, 2, true)
        local _seal = SMODS.poll_seal({mod = 10})
        local hiveminded = next(find_joker("j_garb_truehivemind")) and
                               G.GAME.hivemind_stage > 1
        if hiveminded then _key = 'm_garb_infected' end
        return {
            key = _key,
            set = ((pseudorandom(
                pseudoseed('stdset' .. G.GAME.round_resets.ante)) > 0.6) or
                hiveminded) and "Enhanced" or "Base",
            edition = _edition,
            seal = _seal,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "sta"
        }
    end
}, true)

SMODS.Booster:take_ownership_by_kind('Arcana', {
    create_card = function(self, card, i)
        local _key = nil
        if next(find_joker("j_garb_truehivemind")) and G.GAME.hivemind_stage > 2 then
            _key = 'c_garb_hunger'
        end

        return {
            key = _key,
            set = "Tarot",
            area = G.pack_cards,
            skip_materialize = true
        }
    end
}, true)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- do not copy or reference this code, it's a mistake, trust me.
function DeepScale(t, failsafe, amount)
    local failsafe = failsafe and (failsafe + 1) or 1
    local amount = amount or 4
    if t.x_mult and t.x_mult ~= 1 then t.x_mult = t.x_mult * amount end
    if t.Xmult and t.Xmult ~= 1 then t.Xmult = t.Xmult * amount end
    if not t then return false end
    -- print("initial check success")
    for k, v in pairs(t) do
        if type(v) == "table" and failsafe < 3 then
            -- print("recursing")
            t[k] = DeepScale(v, failsafe, amount)
        elseif type(v) == "number" then
            if (t.x_mult and v == t.x_mult) or (t.Xmult and v == t.Xmult) then
                goto continue
            end
            local isround = (v - round(v) == 0)
            if (t.x_mult or t.Xmult) and
                (t.x_mult == 1 / amount or t.Xmult == 1 / amount) then
                t.x_mult, t.Xmult = 1 / amount
            end
            t[k] = isround and round(v * amount) or v * amount
            -- print(t[k])
        end
        ::continue::
    end
    -- print(tprint(t))
    return t
end

function scale_blind(amount)
    local amount = amount or 1
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            if G.hand_text_area.blind_chips then
                local new_chips = math.floor(G.GAME.blind.chips * (1 + amount))
                local mod_text = number_format(math.floor(
                                                   G.GAME.blind.chips *
                                                       (1 + amount)) -
                                                   G.GAME.blind.chips)
                G.GAME.blind.chips = new_chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate()

                attention_text({
                    text = '+' .. mod_text,
                    scale = 0.8,
                    hold = 0.7,
                    cover = chips_UI.parent,
                    cover_colour = G.C.RED,
                    align = 'cm'
                })

                chips_UI:juice_up()

                play_sound('chips2')
            else
                return false
            end
            return true
        end
    }))
end

garb_batch_load("jokers")
garb_batch_load("consumables")
garb_batch_load("boosters")
garb_batch_load("enhancements")
garb_batch_load("decks")
garb_batch_load("tags")
garb_batch_load("vouchers")
garb_batch_load("poker_hands")
garb_batch_load("misc")

if next(SMODS.find_mod("CardSleeves")) then
    garb_batch_load("cross-mod/cardsleeves")
end

if next(SMODS.find_mod("partner")) then garb_batch_load("cross-mod/partners") end

if next(SMODS.find_mod("malverk")) then garb_batch_load("cross-mod/malverk") end
