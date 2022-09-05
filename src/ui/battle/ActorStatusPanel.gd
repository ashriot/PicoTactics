class_name ActorStatusPanel
extends Control

signal portrait_pressed

onready var _portrait_button := $PortraitButton as Button
onready var _portrait := _portrait_button.get_node("ActorPortrait") as ActorPortrait

onready var _name := $Banner/Name as Label

onready var _hp_bar := $PanelContainer/MarginContainer/VBoxContainer/ \
		HBoxContainer/HP/HPBar as Range
onready var _current_hp := $PanelContainer/MarginContainer/VBoxContainer/ \
		HBoxContainer/HP/CurrentHP as RichTextLabel

onready var _ap_bar := $PanelContainer/MarginContainer/VBoxContainer/ \
		AP/APBar as Range
onready var _current_ap := $PanelContainer/MarginContainer/VBoxContainer/ \
		AP/CurrentAP as RichTextLabel


func set_actor(actor: Actor, portrait_clickable: bool) -> void:
	clear()
	_portrait_button.disabled = not portrait_clickable
	_portrait.texture = actor.portrait

	_name.text = actor.character_name

	_hp_bar.value = actor.stats.hp * 5.0 / actor.stats.max_hp
	_ap_bar.value = actor.stats.ap * 5.0 / actor.stats.max_ap

	_current_hp.bbcode_text = str(actor.stats.hp)
	_current_ap.bbcode_text = str(actor.stats.ap)


func clear() -> void:
	_portrait_button.disabled = true
	_portrait.texture = null
	_name.text = ""

	_hp_bar.value = 0
	_current_hp.bbcode_text = ""

	_ap_bar.value = 0
	_current_ap.bbcode_text = ""


func _on_PortraitButton_pressed() -> void:
	print("Clicked!")
	emit_signal("portrait_pressed")
