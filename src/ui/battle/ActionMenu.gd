class_name ActionMenu
extends Node2D

signal skill_selected(skill_index)
signal wait_selected

const _ANIM_TIME := 0.15
const _BUTTON_WIDTH := 68
const _BUTTON_HEIGHT := 15
const _BUTTON_MARGIN := 4

var is_open: bool setget , get_is_open

onready var _skills := $Skills as Node2D

var _is_open := false
var _have_attack := false


func _ready() -> void:
	_skills.visible = false


func set_actions(skills: Array) \
		-> void:
	_set_skills(skills)


func get_is_open() -> bool:
	return _is_open


func open() -> void:
	_is_open = true
	StandardSounds.play_select()

	_skills.visible = true


func close(with_sound: bool) -> void:
	_is_open = false
	if with_sound:
		StandardSounds.play_cancel()

	_skills.visible = false


func clear_skills() -> void:
	for s in _skills.get_children():
		var skill_button_pos := s as Node
		_skills.remove_child(skill_button_pos)
		skill_button_pos.queue_free()


func _set_skills(skills: Array) -> void:
	clear_skills()

	for i in range(skills.size()):
		var index := i as int
		var skill := skills[index] as Skill

		var button := SoundButton.new()

		# warning-ignore:return_value_discarded
		button.connect("pressed", self, "_on_Skill_pressed", [index])

		var icon := TextureRect.new()
		icon.texture = skill.icon
		button.add_child(icon) # If button is disabled, avoid icon tinting
		icon.margin_left = _BUTTON_MARGIN
		icon.margin_top = _BUTTON_MARGIN
		icon.margin_right = -_BUTTON_MARGIN
		icon.margin_bottom = -_BUTTON_MARGIN

		button.disabled = skill.current_cooldown > 0
		if button.disabled:
			var label := Label.new()

			label.text = str(skill.current_cooldown)
			label.align = Label.ALIGN_RIGHT
			button.add_child(label)

			label.rect_size = Vector2.ZERO
			label.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
			label.margin_left = -label.rect_size.x
			label.margin_top = -label.rect_size.y
			label.margin_right = 0
			label.margin_bottom = 0

		var skill_button_pos := Node2D.new()
		skill_button_pos.add_child(button)

		# warning-ignore:integer_division
		button.margin_left = -_BUTTON_WIDTH / 2
		# warning-ignore:integer_division
		button.margin_top = -_BUTTON_WIDTH / 2
		# warning-ignore:integer_division
		button.margin_right = _BUTTON_WIDTH / 2
		# warning-ignore:integer_division
		button.margin_bottom = _BUTTON_WIDTH / 2

		_skills.add_child(skill_button_pos)


func _on_Skill_pressed(index: int) -> void:
	emit_signal("skill_selected", index)


func _on_Wait_pressed() -> void:
	emit_signal("wait_selected")
