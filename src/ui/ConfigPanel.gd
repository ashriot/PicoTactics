extends PopupPanel

onready var _sound_options := $VBoxContainer/SoundOptions/MarginContainer/VBoxContainer/ as Node

onready var _sound_volume := _sound_options.get_node("SoundVolume") as Slider
onready var _music_volume := _sound_options.get_node("MusicVolume") as Slider
onready var _ui_volume := _sound_options.get_node("UIVolume") as Slider

onready var _sound_test := $SoundTest as AudioStreamPlayer


func _ready() -> void:
	rect_size = Vector2.ZERO

	_sound_volume.value = Config.sound_volume
	_music_volume.value = Config.music_volume
	_ui_volume.value = Config.ui_volume


func _on_SoundVolume_value_changed(value: float) -> void:
	Config.sound_volume = value
	if visible:
		_sound_test.play()
		StandardSounds.play_select()


func _on_MusicVolume_value_changed(value: float) -> void:
	Config.music_volume = value


func _on_UIVolume_value_changed(value: float) -> void:
	Config.ui_volume = value
	if visible:
		StandardSounds.play_select()


func _on_OK_pressed() -> void:
	visible = false
