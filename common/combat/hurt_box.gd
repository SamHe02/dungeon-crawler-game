extends Area3D
class_name Hurtbox

signal hit(damage)

@export var health_component: Health

func receive_hit(damage):
	if health_component:
		health_component.damage(damage)
