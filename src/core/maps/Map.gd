tool
class_name Map, "res://assets/editor/map.png"
extends Node2D

signal actor_dying(actor)
signal actor_removed(actor)

enum Decal { BLOOD_SPATTER = 0 }

const MOVE_COST_CLEAR := 1
const MOVE_COST_ROUGH := 2

#const _COVER_EFFECT := preload("res://resources/data/conditions/Cover.tres")

const _COVER_STAT_MOD_DEF := preload(
		"res://resources/data/statmodifiers/cover.tres")

var _COVER_STAT_MOD := StatModifier.new(_COVER_STAT_MOD_DEF)

onready var _ground := $Ground as TileMap
onready var _decals := $Decals as TileMap
onready var _effects := $Effects as Node
