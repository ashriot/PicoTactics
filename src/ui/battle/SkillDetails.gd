class_name SkillDetails
extends PopupPanel

onready var _description := $MarginContainer/ScrollContainer/ \
		Description as Label


func show_skill(skill: Skill) -> void:
	clear()
	_description.text = skill.description
	popup()


func clear() -> void:
	_description.text = ""
