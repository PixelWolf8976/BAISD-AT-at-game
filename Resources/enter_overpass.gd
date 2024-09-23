extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.collision_mask = 1 << 3 | 1 << 5 | 1 << 2
	body.z_index = 11
