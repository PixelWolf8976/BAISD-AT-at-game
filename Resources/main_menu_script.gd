extends Control

func _process(delta):
	if Input.is_action_just_pressed("turn_left_1") || Input.is_action_just_pressed("turn_left_2"):
		_on_button_pressed()
	
	if Input.is_action_just_pressed("turn_right_1") || Input.is_action_just_pressed("turn_right_2"):
		_on_button_2_pressed()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/player_selection.tscn")

func _on_button_2_pressed():
	get_tree().quit(0)
