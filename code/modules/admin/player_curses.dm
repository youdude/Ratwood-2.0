/proc/now_days()
	return round((world.realtime / 10) / 86400)


// =========================================================
//  JSON LOAD / SAVE
// =========================================================

/proc/get_player_curses(key)
	if(!key) return

	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/curses.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")

	var/list/json = json_decode(file2text(json_file))
	if(!json) json = list()

	return json


/proc/has_player_curse(key, curse)
	if(!key || !curse) return FALSE

	var/list/json = get_player_curses(key)
	if(!json || !json[curse]) return FALSE

	var/list/C = json[curse]

	if(C["expires"] <= now_days())
		remove_player_curse(key, curse)
		return FALSE

	return TRUE


/proc/apply_player_curse(
	key,
	curse,
	duration_days = 1,
	cooldown_seconds = 0,
	chance_percent = 100,
	trigger = null,
	effect_proc = null,
	list/effect_args = null,
	admin_name = "unknown",
	reason = "No reason supplied."
)
	if(!key || !curse) return FALSE

	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/curses.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")

	var/list/json = json_decode(file2text(json_file))
	if(!json) json = list()

	if(json[curse]) return FALSE

	json[curse] = list(
		"expires"      = now_days() + duration_days,
		"chance"       = chance_percent,
		"cooldown"     = cooldown_seconds,
		"last_trigger" = 0,
		"trigger"      = trigger,
		"effect"       = effect_proc,
		"effect_args"  = effect_args,
		"admin"        = admin_name,
		"reason"       = reason
	)

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))
	return TRUE


/proc/remove_player_curse(key, curse)
	if(!key || !curse) return FALSE

	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/curses.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")

	var/list/json = json_decode(file2text(json_file))
	if(!json) return FALSE

	json[curse] = null

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))
	return TRUE



// =========================================================
//  CURSE CREATION POPUP
// =========================================================

/client/proc/curse_player_popup(mob/target)
	if(!target || !target.ckey)
		usr << "Invalid target."
		return

	var/key = target.ckey

	// ---- Trigger Selection ----
	var/list/trigger_list = list(
		"on spawn",
		"on death",
		"on sleep",
		"on attack",
		"on cast spell",
		"on receive damage",
		"on spell/miracle target",
		"on crit status",
		"on behead",
		"on break wall/door/window",
		"on cut tree",
		"on craft",
		"on sex",
		"on orgasm",
		"on bite",
		"on jump",
		"on climb",
		"on swim",
		"on run",
		"on walk"
		"on midnight"
		"on noon"
		"on dusk"
		"on dawn"
	)

	var/trigger = input(
		src,
		"Choose a trigger event for this curse:",
		"Trigger Selection"
	) as null|anything in trigger_list

	if(!trigger) return

	// ---- Chance ----
	var/chance = input(
		src,
		"Percent chance (1 to 100):",
		"Chance",
		100
	) as null|num

	if(isnull(chance)) return
	chance = clamp(chance, 1, 100)

	// ---- Effect Selection ----
	var/list/effect_list = list(
		"buff or debuff",
		"remove trait",
		"add trait",
		"add 2u reagent",
		"max devotion",
		"zero devotion",
		"max arousal",
		"shrink sex organs",
		"enlarge sex organs",
		"nauseate",
		"clothesplosion",
		"slip",
		"jail in arcyne walls",
		"make deadite",
		"make vampire",
		"make werewolf",
		"shock",
		"add stack of fire",
		"easy ambush",
		"difficult ambush",
		"explode",
		"nugget",
		"gib and spawn player controlled mob",
		"gib and reset body",
		"gib",
		"gib and explode"
	)

	var/effect_proc = input(
		src,
		"Choose the effect this curse will apply:",
		"Effect Selection"
	) as null|anything in effect_list

	if(!effect_proc) return

	var/list/effect_args = null

	// ---- Trait selection ----
	if(effect_proc == "add trait" || effect_proc == "remove trait")
		var/list/trait_choices = GLOB.roguetraits.Copy()

		var/action = (effect_proc == "add trait" ? "add" : "remove")

		var/trait_id = input(
			src,
			"Select the trait to [action]:",
			"Trait Selection"
		) as null|anything in trait_choices

		if(!trait_id) return

		effect_args = list("trait" = trait_id)

	// ---- Buff / Debuff selection ----
	if(effect_proc == "buff or debuff")
		var/debuff_id = input(
			src,
			"Select the effect to apply:",
			"Effect Selection"
		) as null|anything in subtypesof(/datum/status_effect/debuff)

		if(!debuff_id) return

		effect_args = list(
			"debuff_id"  = debuff_id
		)

	if(effect_proc == "add 2u reagent")
		var/reagent_name = input(
			src,
			"Enter the reagent to add (exact name):",
			"Reagent Selection"
		) as null|anything in subtypesof(/datum/reagent)

		if(!reagent_name) return

		effect_args = list(
			"reagent_name" = reagent_name,
		)

	// ---- Mob-spawning effects ----
	if(effect_proc in list("gib and spawn player controlled mob", "easy ambush", "difficult ambush"))
		var/mob_name = input(
			src,
			"Select the mob to spawn/give:",
			"Mob Selection"
		) as null|anything in subtypesof(/mob/living/simple_animal)

		if(!mob_name) return

		effect_args = list(
			"mob_name" = mob_name,
		)

	// ---- Duration ----
	var/duration = input(
		src,
		"Duration (REAL WORLD DAYS):",
		"Duration",
		1
	) as null|num

	if(!duration || duration <= 0) return

	// ---- Cooldown ----
	var/cooldown = input(
		src,
		"Cooldown between activations (seconds):",
		"Cooldown",
		45
	) as null|num

	if(cooldown < 0) cooldown = 0

	// ---- Reason ----
	var/reason = input(
		src,
		"Reason for curse (admin note):",
		"Reason",
		"None"
	) as null|text

	// ---- Generate name ----
	var/cname_safe_effect = replacetext(effect_proc, " ", "_")
	var/cname_safe_trigger = replacetext(trigger, " ", "_")
	var/curse_name = "[chance]pct_[cname_safe_effect]_[cname_safe_trigger]_[rand(1000,9999)]"

	// ---- Apply ----
	var/success = apply_player_curse(
		key,
		curse_name,
		duration,
		cooldown,
		chance,
		trigger,
		effect_proc,
		effect_args,
		usr.ckey,
		reason
	)

	if(success)
		src << "<span class='notice'>Applied curse <b>[curse_name]</b> to [target].</span>"
		target << "<span class='warning'>A strange curse settles upon you…</span>"
	else
		src << "<span class='warning'>Failed to apply curse.</span>"
