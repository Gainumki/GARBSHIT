return {
 SMODS.Joker {
            key = 'hiveSCARE',
            loc_txt = {
              name = 'True Hivemind',
              text = config.repainted and {
                "You Got {C:red,s:1.5}Garb'd{}"
              } or {
                "{C:red,s:1.5}YOU{} are compromised"
              }
            },
            config = { extra = {  } },
            loc_vars = function(self, info_queue, card)
              return { vars = {  } }
            end,
          
            in_pool = function(self)
              return false
          end,

            rarity = "garb_rainbow",
            atlas = 'GarbJokers',
            pos = { x = 5, y = 11 },
            cost = 5,
              no_collection = true,
              unlocked = true, 
              discovered = true, --whether or not it starts discovered
              blueprint_compat = true, --can it be blueprinted/brainstormed/other
              eternal_compat = true, --can it be eternal
              perishable_compat = true, --can it be perishable
              },
    
}