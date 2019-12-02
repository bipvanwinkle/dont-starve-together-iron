local assets=
{
	Asset("ANIM", "anim/iron_ore.zip"),
}

local function onsave(inst, data)
	data.anim = inst.animname
end

local function onload(inst, data)
    if data and data.anim then
        inst.animname = data.anim
	    inst.AnimState:PlayAnimation(inst.animname)
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    -- This is for Hamlet
    --MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    
    inst.AnimState:SetBank("iron_ore")
    inst.AnimState:SetBuild("iron_ore")
    inst.AnimState:PlayAnimation("idle")

    -- In Hamlet they have the food as an elemental type, but I want to have it as it's own type
    --inst:AddComponent("edible")
    --inst.components.edible.foodtype = "ELEMENTAL"
    --inst.components.edible.hungervalue = 1
    --inst:AddComponent("tradable")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")

    inst:AddComponent("bait")
    inst:AddTag("molebait")

	--inst:AddComponent("repairer")
	--inst.components.repairer.repairmaterial = "orp"
	--inst.components.repairer.healthrepairvalue = TUNING.REPAIR_ROCKS_HEALTH
    
    -- In the future I'll make it edible with it's own type
    --inst:AddComponent("edible")
    --inst.components.edible.foodtype = FOODTYPE.IRON_ORE
    --inst.components.edible.healthvalue = TUNING.HEALING_HUGE
    --inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
    --inst.components.edible.sanityvalue = TUNING.SANITY_HUGE

    inst.OnSave = onsave 
    inst.OnLoad = onload 
    return inst
end

return Prefab( "common/inventory/iron", fn, assets) 
