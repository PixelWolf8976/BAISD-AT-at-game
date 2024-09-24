extends CanvasLayer

func _ready():
	$TextureRect.modulate = Color(1, 1, 1, 0.25)

func _on_pressed() -> void:
	openMenu()
	get_tree().paused = true

func openMenu():
	pass
