extends Node

var elapsedCountdownTime := 0.0
var timerDone := false

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
		map.process_mode = Node.PROCESS_MODE_PAUSABLE
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
	elif level == 2:
		var map = preload("res://Scenes/Track 2.tscn").instantiate()
		map.process_mode = Node.PROCESS_MODE_PAUSABLE
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
	elif level == 3:
		var map = preload("res://Scenes/Track 3.tscn").instantiate()
		map.process_mode = Node.PROCESS_MODE_PAUSABLE
		$HBoxContainer/Viewport1/SubViewport1.add_child(map)
	
	$HBoxContainer/Viewport1/SubViewport1/Camera2D.position = get_node("%Player1").position
	
	get_tree().paused = true

func _process(delta: float) -> void:
	if !timerDone:
		$Label.visible = true
		$Label.text = str(3 - round(elapsedCountdownTime))
		if $Label.text == "0":
			$Label.text = "GO!"
		
		if $Label.text == "0" || $Label.text == "GO!":
			$Label.label_settings.font_color = Color(0, 1, 0)
		elif $Label.text == "1":
			$Label.label_settings.font_color = Color(1, 0.75, 0)
		elif $Label.text == "2":
			$Label.label_settings.font_color = Color(1, 0.5, 0)
		elif$Label.text == "3":
			$Label.label_settings.font_color = Color(1, 0, 0)
		
		elapsedCountdownTime += delta
		if elapsedCountdownTime >= 3:
			timerDone = true
			get_tree().paused = false
	else:
		elapsedCountdownTime = 0.0
		$Label.visible = false
