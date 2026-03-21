extends Control

class_name CrossHair
var cross_hair: ColorRect
# Called when the node enters the scene tree for the first time.

func spawn_crosshair():
	var crosshair = ColorRect.new()
	crosshair.color = Color.WHITE

	# Center on screen
	crosshair.anchor_left = 0.5
	crosshair.anchor_top = 0.5
	crosshair.anchor_right = 0.5
	crosshair.anchor_bottom = 0.5

	# Size
	var size = 16
	crosshair.custom_minimum_size = Vector2(size, size)

	# Offset
	var offset = [0, 0]
	crosshair.position = Vector2(offset[0], offset[1])

	# Color
	var c = [1, 1, 1, 1]
	crosshair.modulate = Color(c[0], c[1], c[2], c[3])

	return crosshair
func _ready() -> void:
	# Center on screen
	cross_hair = spawn_crosshair()
	add_child(cross_hair)
	print("children", get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
