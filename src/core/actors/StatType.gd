class_name StatType

enum Type {
	MAX_HP,
	MAX_AP,
	ATTACK,
	STRENGTH,
	AGILITY,
	INTELLECT,
	DEFENSE,
	PARRY,
	EVASION,
	RESIST,
	CRIT_CHANCE,
	CRIT_POWER,
	MOVE,
	DASH
}

const _MOD_ONLY_STATS := {
	Type.DEFENSE: true
}

static func is_mod_only(stat_type: int) -> bool:
	return _MOD_ONLY_STATS.has(stat_type)
