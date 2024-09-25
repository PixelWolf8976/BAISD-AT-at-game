extends CanvasLayer

func _ready():
	$TextureRect.modulate = Color(1, 1, 1, 0.5)

func _on_button_pressed() -> void:
	openMenu()

func openMenu():
	$TextureRect.visible = true
	$Resume.visible = true
	$Exit.visible = true
	if get_node("/root/Node") && !get_node("/root/Node").timerDone:
		get_parent().timerDone = true
	get_parent().get_tree().paused = true

func closeMenu():
	$TextureRect.visible = false
	$Resume.visible = false
	$Exit.visible = false
	if get_node("/root/Node") && get_node("/root/Node").timerDone:
		get_node("/root/Node").timerDone = false
	else:
		get_tree().paused = false

func _on_resume_pressed() -> void:
	closeMenu()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
