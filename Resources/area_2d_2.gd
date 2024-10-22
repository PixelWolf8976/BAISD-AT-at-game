extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is player1 || body is player2:
		body.reachedCheckpoint = true
