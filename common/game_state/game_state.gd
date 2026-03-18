extends Node

signal pause_changed(is_paused)
var _is_paused: bool = false
var is_paused: bool = false:
	get:
		return _is_paused
	set(value):
		set_paused(value)
# Called when the node enters the scene tree for the first time.
func set_paused(value: bool):
	if _is_paused == value:
		return
	_is_paused = value
	get_tree().paused = _is_paused
	emit_signal(pause_changed.get_name(), _is_paused)
