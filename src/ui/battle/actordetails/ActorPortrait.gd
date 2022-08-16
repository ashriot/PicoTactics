tool
class_name ActorPortrait
extends MarginContainer

export var portrait: Texture = null setget set_portrait

onready var _sprite := $Sprite as Sprite


func _ready() -> void:
	set_portrait(portrait)


func set_portrait(value: Texture) -> void:
	portrait = value
	if _sprite:
		_sprite.texture = portrait
