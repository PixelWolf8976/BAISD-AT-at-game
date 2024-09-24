extends Node

func _ready():
	var viewport1 := $HBoxContainer/Viewport1/SubViewport1
	var viewport2 := $HBoxContainer/Viewport2/SubViewport2
	var camera1 := $HBoxContainer/Viewport1/SubViewport1/Camera2D
	var camera2 := $HBoxContainer/Viewport2/SubViewport2/Camera2D
	var world := $HBoxContainer/Viewport1/SubViewport1/Level
	viewport2.world_2d = viewport1.world_2d
	var level = Global.getLevel()
	if level == -1:
		print("OH NO")
	elif level == 1:
		var map = preload("res://Scenes/Track 1.tscn").instantiate()
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
	elif level == 2:
		var map = preload("res://Scenes/Track 2.tscn").instantiate()
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
	elif level == 3:
		var map = preload("res://Scenes/Track 3.tscn").instantiate()
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
		
func _process(delta: float) -> void:
	pass
