class_name HitScanInput
extends Node

func _input(event) -> void:
	if Input.is_action_just_pressed(Input_Constants.to_String(Input_Constants.Actions.SHOOT)):
