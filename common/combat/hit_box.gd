extends Area3D
class_name Hitbox

@export var damage: int = 10

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Hurtbox:
			child.receive_hit(damage)
