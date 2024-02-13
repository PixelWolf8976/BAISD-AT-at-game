extends Node

func _ready():
	var viewport1 = $HBoxContainer/Viewport1/SubViewport1
	var viewport2 = $HBoxContainer/Viewport2/SubViewport2
	var camera1 = $HBoxContainer/Viewport1/SubViewport1/Camera2D
	var camera2 = $HBoxContainer/Viewport2/SubViewport2/Camera2D
	var world = $HBoxContsainer/Viewport1/SubViewport1/base_test_scene
	viewport2.world_2d = viewport1.world_2d
