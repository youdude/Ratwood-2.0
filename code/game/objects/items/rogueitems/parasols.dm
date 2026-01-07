/obj/item/rogueweapon/mace/parasol
	force = 8
	force_wielded = 8
	name = "paper parasol"
	desc = "A delicate instrument intended to shield one's delicate head from the rain and sun."
	icon = 'icons/roguetown/items/parasols.dmi'
	icon_state = "parasol"
	wbalance = WBALANCE_SWIFT
	wdefense = 1
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = null
	smeltresult = /obj/item/ash
	anvilrepair = /datum/skill/craft/sewing
	max_integrity = 200 // The working man's parasol
	minstr = 1
	resistance_flags = FLAMMABLE
	slot_flags = null
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 32
	grid_height = 64

/obj/item/rogueweapon/mace/parasol/noble
	name = "fine parasol"
	desc = "A delicate instrument intended to shield one's delicate head from the rain and sun. This one is a beautiful luxurious white and gold, with fringes."
	icon_state = "parasol_fancy"
	max_integrity = 100 // Fashion over function
	sellprice = 45 // Takes master sewing and silk to create

/obj/item/rogueweapon/mace/parasol/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)

// /datum/component/parasol

// /datum/component/parasol/Initialize()
// 	if(!istype(parent, /obj/item/rogueweapon/mace/parasol))
// 		return COMPONENT_INCOMPATIBLE
// 	src.parasol = parasol

// /datum/component/parasol/RegisterWithParent()
// 	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
// 	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

// /datum/component/parasol/UnregisterFromParent()
// 	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

// /datum/component/parasol/proc/on_equipped(obj/item/equipped, mob/user, slot)
// 	if(is_blessed && slot & ITEM_SLOT_HANDS)
// 		user.add_stress(/datum/stressevent/blessed_weapon)

// /datum/component/parasol/proc/on_dropped(obj/item/dropped, mob/user, slot)
// 	if(is_blessed)
// 		user.remove_stress(/datum/stressevent/blessed_weapon)
