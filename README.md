# 96rp_npc
 
This resource allows the creation of npc peds. 
Npcs are spawned on the client side for every player upon loading into the server.

## Installation
1. Drag and drop into you resource folder or use `git clone`.
2. Add `ensure 96rp_npc` to you server.cfg.

## How to use
New Npcs can be added be added inside the config file.

example: 
```lua
Config.NPCs = {
  Toolshop = { 
        coords = vec3(428.96, 3714.26, 4.67),
        heading = 162.0,
        model = `mp_m_freemode_01`,
        clothing = { -- not needed if model is ped
            component = {
                {componentId = 2,  drawableId = 29, textureId = 61, paletteId = 0}, -- Hairstyle
                {componentId = 8,  drawableId = 29, textureId = 1, paletteId = 0}, -- TShirt
                {componentId = 9,  drawableId = 61, textureId = 0, paletteId = 0}, -- bproof_1
                {componentId = 11,  drawableId = 380, textureId = 1, paletteId = 0}, -- Torso
                {componentId = 3,  drawableId = 3, textureId = 0, paletteId = 0}, -- Arms
                {componentId = 7,  drawableId = 104, textureId = 2, paletteId = 0}, -- Chains
                {componentId = 4,  drawableId = 143, textureId = 4, paletteId = 0}, -- Pants
                {componentId = 6,  drawableId = 137, textureId = 0, paletteId = 0}, -- Shoes
            },
            prop = {
                {componentId = 0,  drawableId = 127, textureId = 10, attach = true}, -- Hat
            }
        },
        radius = 3, -- radius of the npc
        animation = { -- animation the npc does while standing (false if no anim)
            animDict = 'missbigscore2aig_3',
            anim = 'wait_for_van_c',
            taskFlag = 33 
        },
    },
}
```
