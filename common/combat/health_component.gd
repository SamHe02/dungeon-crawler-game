extends Node

class_name Health

# signal for death
signal died
# signal for when health changes
signal health_changed(current, max)

@export var max_health: int = 100
var health: int

func _ready():
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(amount: int):
	health -= amount
	health = max(health, 0)
	health_changed.emit(health, max_health)
	
	if health <= 0:
		died.emit()
		
func heal(amount: int):
	health = min(health + amount, max_health)
	health_changed.emit(health, max_health)
