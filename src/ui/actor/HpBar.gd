class_name HpBar
extends Node2D

signal animation_finished

const _CHANGE_PER_SECOND := 0.1
const _CHANGE_DELAY := 0.25

var max_hp := 20 setget _set_max_hp, _get_max_hp
var modifier := 0.0 setget _set_modifier

var _current_value: float

onready var _hp_front := $Background/HpFront as Range
onready var _hp_back := $Background/HpBack as Range
onready var _modifier_text := $ModifierTextPos/ModifierText as Label

onready var _tween := $Tween as Tween


func reset() -> void:
	_current_value = float(_get_max_hp())
	_hp_front.value = _current_value


func animate_change(delta: float) -> void:
	_set_modifier(0)

	var old_hp := _current_value
	_current_value = clamp(_current_value + delta,
			_hp_front.min_value, _hp_front.max_value)

	if delta < 0:
		_hp_front.value = _current_value
		_animate_bar(_hp_back, old_hp, _current_value)
	else:
		_hp_back.value = _current_value
		_animate_bar(_hp_front, old_hp, _current_value)


func _animate_bar(bar: Range, old_value: float, new_value: float) -> void:
	bar.value = old_value

	# warning-ignore:return_value_discarded
	_tween.interpolate_property(
			bar, "value", old_value, new_value,
			abs(new_value - old_value) * _CHANGE_PER_SECOND,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, _CHANGE_DELAY)
	# warning-ignore:return_value_discarded
	_tween.start()


func _on_Tween_tween_all_completed() -> void:
	yield(get_tree().create_timer(_CHANGE_DELAY), "timeout")
	emit_signal("animation_finished")


func _set_max_hp(new_value: int) -> void:
	_hp_front.max_value = new_value
	_hp_back.max_value = new_value


func _get_max_hp() -> int:
	return int(_hp_front.max_value)


func _set_modifier(new_value: float) -> void:
	modifier = new_value

	_hp_front.value = _current_value
	_hp_back.value = _current_value

	if modifier > 0:
		_hp_back.value += modifier
	elif modifier < 0:
		_hp_front.value += modifier

	_modifier_text.text = str(new_value)
	_modifier_text.visible = modifier != 0
