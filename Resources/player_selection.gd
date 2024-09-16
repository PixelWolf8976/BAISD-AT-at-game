extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level Select.tscn")
	Global.playerCount = 2

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level Select 2 Player.tscn")
	Global.playerCount = 1
