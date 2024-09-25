extends CanvasLayer

var menuOpen := false

func _ready():
	$TextureRect.modulate = Color(1, 1, 1, 0.5)

func _process(delta):
	if Input.is_action_just_pressed("turn_left_1") || Input.is_action_just_pressed("turn_left_2"):
		if menuOpen:
			_on_resume_pressed()
	
	if Input.is_action_just_pressed("turn_right_1") || Input.is_action_just_pressed("turn_right_2"):
		if menuOpen:
			_on_exit_pressed()

func _on_button_pressed() -> void:
	openMenu()

func openMenu():
	menuOpen = true
	$TextureRect.visible = true
	$Resume.visible = true
	$Exit.visible = true
	if get_node("/root/Node") && !get_node("/root/Node").timerDone:
		get_parent().timerDone = true
	get_parent().get_tree().paused = true

func closeMenu():
	menuOpen = false
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
