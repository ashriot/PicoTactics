class_name ActorDetailsPanel
extends PopupPanel

onready var _portrait := $Main/Header/ActorPortrait as ActorPortrait
onready var _name := $Main/Header/HeaderInfoMargin/VBoxContainer/Name as Label

onready var _hp_info := $Main/Header/HeaderInfoMargin/VBoxContainer/ \
		HBoxContainer/HP as Control
onready var _hp := _hp_info.get_node("HP") \
		as Label

onready var _stats := $Main/StatsPanel/MarginContainer/Stats as Control
onready var _attack := _stats.get_node("ParryInfo") as ActorStatDetails
onready var _move := _stats.get_node("EvasionInfo") as ActorStatDetails
onready var _speed := _stats.get_node("ResistInfo") as ActorStatDetails

#onready var _skills := $Main/SkillsContainer/Skills as ActorSkillsDetails
#onready var _conditions := $Main/ConditionsContainer/Conditions \
#		as ActorStatusEffectDetails


func set_actor(actor: Actor) -> void:
	clear()

	_portrait.texture = actor.portrait
	_name.text = actor.character_name

	_hp.text = str(actor.stats.hp) + "/" + str(actor.stats.max_hp)

	_set_stat_info(actor.stats)

#	_skills.set_skills(actor.skills)
#	_conditions.set_conditions(actor)


func clear() -> void:
	_portrait.texture = null
#	_skills.clear()
#	_conditions.clear()


func _set_stat_info(stats: Stats) -> void:
	_attack.set_stat_values(stats, StatType.Type.ATTACK)
	_move.set_stat_values(stats, StatType.Type.MOVE)
	_speed.set_stat_values(stats, StatType.Type.SPEED)


func _on_TabContainer_tab_changed(_tab: int) -> void:
	StandardSounds.play_select()


func _on_Close_pressed() -> void:
	visible = false
