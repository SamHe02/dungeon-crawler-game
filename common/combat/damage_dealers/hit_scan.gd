class_name HitScan
extends Node3D

@export var camera: Camera3D = null;
@export var ray_length: float = 0;
@export var is_visible: bool = false;

func _physics_process(delta: float) -> void:
	if(ray_length > 0 && is_visible):
		var space_state = get_world_3d().direct_space_state
		var mouse_pos = get_viewport().get_mouse_position()

		var origin = camera.project_ray_origin(mouse_pos)
		var end = origin + camera.project_ray_normal(mouse_pos) * ray_length
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		print(query);
