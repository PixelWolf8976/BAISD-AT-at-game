extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.collision_mask = 1 << 1 | 1 << 2
	body.z_index = 1
