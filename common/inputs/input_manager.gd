extends Node
class_name InputManager
# Called when the node enters the scene tree for the first time.
func move_vector() -> Vector2:
	return Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward",
	)

func jump_pressed() -> bool:
	return Input.is_action_just_pressed("jump")
