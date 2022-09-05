tool
class_name ActorPortrait
extends MarginContainer

export var texture: Texture = null setget set_texture

onready var _sprite := $Sprite as Sprite


func _ready() -> void:
	set_texture(texture)


func set_texture(value: Texture) -> void:
	texture = value
	if _sprite:
		_sprite.texture = texture
