extends Area2D

func _on_body_entered(body: Node2D) -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("StopwatchUI").stopStopwatch()
