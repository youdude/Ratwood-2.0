/datum/advclass/mercenary/anthrax
	name = "Crocs de l'araignée Cavalier"
	tutorial = "The Crocs de l'araignée, translated literally to mean 'Spider's Teeth', is a renowned collective of blades, whips, and riders for hire often employed in the vast drow undercity complexes and occasionally the surface above. Infamous for their battlefrenzy, sadism, and mastery over arachnid cavalry, a member of the Spider's Teeth stands among some of the fiercest if cruelest warriors in Psydonia. Dark elves ultimately are only truly aligned to themselves and their own interests; this trait makes them surprisingly pragmatic and straightforward mercenaries, as a drow can be counted on to do any job so long as the price is right and it serves whatever higher ambition they might have."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/elf/dark,
		/datum/species/human/halfelf, // Because half-drows are half-elves, guh.
	)
	outfit = /datum/outfit/job/roguetown/mercenary/anthrax
	class_select_category = CLASS_CAT_RACIAL
	category_tags = list(CTAG_MERCENARY)

	cmode_music = 'sound/music/combat_delf.ogg'

	traits_applied = list(TRAIT_DARKVISION, TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_WIL = 2,
		STATKEY_PER = 1,
	)

	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, 
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN, 
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/alchemy = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,

	)
	extra_context = "This subclass is race-limited to: Dark Elves Only."

/datum/outfit/job/roguetown/mercenary/anthrax/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shadowpants
	backl = /obj/item/storage/backpack/rogue/satchel/black
	head = /obj/item/clothing/neck/roguetown/chaincoif/full/black
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1, 
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1, 
		/obj/item/rogueweapon/huntingknife/idagger/steel/corroded/dirk = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/strongpoison = 1,
		/obj/item/rogueweapon/scabbard/sheath)
	armor = /obj/item/clothing/suit/roguetown/armor/plate/fluted/shadowplate
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/shadowrobe
	gloves = /obj/item/clothing/gloves/roguetown/plate/shadowgauntlets
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/facemask/shadowfacemask
	neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	backr = /obj/item/rogueweapon/shield/tower/spidershield
	beltr = /obj/item/rogueweapon/whip/spiderwhip
	beltl = /obj/item/rope/chain

	if(H.mind)
		var/riding = list("I'm a spider rider (your pet with you)", "I walk on my legs (+1 for athletics)")
		var/ridingchoice = input(H, "Choose your faith", "FAITH") as anything in riding
		switch(ridingchoice)
			if("I'm a spider rider (your pet with you)")
				l_hand = /obj/item/bait/spider
			if("I walk on my legs (+1 for athletics)")
				H.adjust_skillrank_up_to(/datum/skill/misc/athletics, SKILL_LEVEL_MASTER, TRUE)

	H.merctype = 15

/datum/advclass/mercenary/anthrax/assassin
	name = ""Crocs de l'araignée Assassin"
	outfit = /datum/outfit/job/roguetown/mercenary/anthrax/assassin
	traits_applied = list(TRAIT_DARKVISION, TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_PER = 2,
		STATKEY_INT = 1,
		STATKEY_SPD = 2,
	)
	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, 
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN, 
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/alchemy = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/sewing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/traps = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/mercenary/anthrax/assassin/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/shadowshirt/elflock
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/shadowrobe
	cloak = /obj/item/clothing/cloak/half/shadowcloak
	gloves = /obj/item/clothing/gloves/roguetown/fingerless/shadowgloves/elflock
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/shepherd/shadowmask/delf
	neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	beltr = /obj/item/quiver/poisonarrows
	beltl = /obj/item/rogueweapon/scabbard/sword
	r_hand = /obj/item/rogueweapon/sword/sabre/stalker

