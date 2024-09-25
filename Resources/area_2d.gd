extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.reachedCheckpoint == true:
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node("StopwatchUI").finishRace(body)
		get_node("/root/Node/HBoxContainer/Viewport1/SubViewport1/Player1/AudioStreamPlayer").playing = false
