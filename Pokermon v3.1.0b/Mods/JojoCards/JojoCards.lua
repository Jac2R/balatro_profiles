--- STEAMODDED HEADER
--- MOD_NAME: Jojo Cards
--- MOD_ID: JojoCards
--- PREFIX: JojoCards
--- MOD_AUTHOR: [ArgentumG]
--- MOD_DESCRIPTION: Faces and Aces for JJBA parts 1-4. Enjoy!
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0.0
--- BADGE_COLOR: E895FC

local atlas_key = 'JojoCards'-- Format: PREFIX_KEY
local atlas_path = 'JojoCards.png' -- Filename for the image in the asset folder
local atlas_path_hc = 'JojoCardsHiC.png' -- Filename for the high-contrast version of the texture, if existing

local suits = {'spades', 'diamonds', 'hearts', 'clubs'} -- Which suits to replace
local ranks = {'Jack', 'Queen', 'King', "Ace"} -- Which ranks to replace

local description = 'JJBA' -- English-language description, also used as default


SMODS.Atlas { -- modicon
  key = 'modicon',
  px = 32,
  py = 32,
  path = 'modicon.png'
}

SMODS.Atlas{  
    key = atlas_key..'_lc',
    px = 71,
    py = 95,
    path = atlas_path,
    prefix_config = {key = false},
}

if atlas_path_hc then
    SMODS.Atlas{  
        key = atlas_key..'_hc',
        px = 71,
        py = 95,
        path = atlas_path_hc,
        prefix_config = {key = false},
    }
end

for _, suit in ipairs(suits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = ranks,
        lc_atlas = atlas_key..'_lc',
        hc_atlas = (atlas_path_hc and atlas_key..'_hc') or atlas_key..'_lc',
        loc_txt = {
            ['en-us'] = description
        },
        posStyle = 'deck'
    }
end