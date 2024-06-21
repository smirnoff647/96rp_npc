Npc = {
    data = nil,
}

function Npc:new(t)
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

function Npc:show()
    while not HasModelLoaded(self.data.model) do 
        RequestModel(self.data.model)
        Wait(100)
    end
    local ped = CreatePed(4, self.data.model, self.data.coords.x, self.data.coords.y, self.data.coords.z - 1.03, self.data.heading, false, false)
    self.ped = ped
    if ped then 
        if self.data.clothing then  -- set clothing for the npc if clothing value is added to config
            for i = 1, #self.data.clothing.component, 1 do
                SetPedComponentVariation(
                    ped,     -- ped: Ped, 
                    self.data.clothing.component[i].componentId,    -- componentId: number, 
                    self.data.clothing.component[i].drawableId,     -- drawableId: number, 
                    self.data.clothing.component[i].textureId,    -- textureId: number, 
                    self.data.clothing.component[i].paletteId     -- paletteId: number
                )
            end
            for i = 1, #self.data.clothing.prop, 1 do
                SetPedPropIndex(
                    ped,    -- ped: Ped, 
                    self.data.clothing.prop[i].componentId,    -- componentId: number, 
                    self.data.clothing.prop[i].drawableId,    -- drawableId: number, 
                    self.data.clothing.prop[i].textureId,    -- textureId: number, 
                    self.data.clothing.prop[i].attach    -- attach: boolean
                )
            end
        end

        SetEntityAsMissionEntity(ped, false, false) -- make ped persistent (prevent from beeing removed by engine)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanBeTargetted(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCanLosePropsOnDamage(ped, false, 0)

        if self.data.animation then 
            while not HasAnimDictLoaded(self.data.animation.animDict) do 
                RequestAnimDict(self.data.animation.animDict)
                Wait(100)
            end
            TaskPlayAnim(self.data.data, self.data.animation.animDict, self.data.animation.anim, 8.0, 8.0, -1, self.data.animation.taskFlag, 0.0, 0, 0, 0)
            if not IsEntityPlayingAnim(self.data.data, self.data.animation.animDict, self.data.animation.anim, self.data.animation.taskFlag) then 
                Wait(3000)
                TaskPlayAnim(self.data.data, self.data.animation.animDict, self.data.animation.anim, 8.0, 8.0, -1, self.data.animation.taskFlag, 0.0, 0, 0, 0)
            end
        end

    end
end

npcList = {}
function RegisterNPCs()
    for key,value in pairs(Config.NPCs) do
        local alreadyAdded = false
        for i = 1, #npcList do
            if npcList[i].name == key then
                alreadyAdded = true
            end
        end

        if not alreadyAdded then
            npc = Npc:new({
                name = key,
                data = lib.points.new(value.coords, value.radius, value),
            })
            npc:show()
            table.insert(npcList, npc)
        end
    end
    print("Spawned: "..tonumber(#npcList).." npcs")
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function() 
    RegisterNPCs()
end)

RegisterCommand('testnpc', function()
    RegisterNPCs()
end)
