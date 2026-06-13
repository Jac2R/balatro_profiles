--- STEAMODDED HEADER
--- MOD_NAME: Jojos Tarot Cards
--- MOD_ID: JojoTs
--- MOD_AUTHOR: [KaptenApten]
--- MOD_DESCRIPTION: Replaces the tarot cards with ones from Jojos Bizzare Adventure

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.NegateTexturePack()

    local jojo_tarot = SMODS.findModByID("JojoTs")
    local sprite_trt = SMODS.Sprite:new("Tarot", jojo_tarot.path, "jojo-tarots.png", 71, 95, "asset_atli")


    sprite_trt:register()
end

----------------------------------------------
------------MOD CODE END----------------------