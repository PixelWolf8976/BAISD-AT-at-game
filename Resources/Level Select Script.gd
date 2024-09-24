extends Control

@onready var lev1Button := $Level1Button
@onready var lev2Button := $Level2Button
@onready var lev3Button := $Level3Button

var levelOn := 1

func _process(delta):
	if Input.is_action_just_pressed("turn_left_1") || Input.is_action_just_pressed("turn_left_2"):
		if levelOn == 1:
			_on_level_1_button_pressed()
		elif levelOn == 2:
			_on_level_2_button_pressed()
		elif levelOn == 3:
			_on_level_3_button_pressed()
	
	if Input.is_action_just_pressed("turn_right_1") || Input.is_action_just_pressed("turn_right_2"):
		_on_button_pressed()

func _on_button_pressed():
	levelOn += 1
	if levelOn > 3:
		levelOn = 1
	
	if levelOn == 1:
		lev1Button.visible = true
	else:
		lev1Button.visible = false
	
	if levelOn == 2:
		lev2Button.visible = true
	else:
		lev2Button.visible = false
	
	if levelOn == 3:
		lev3Button.visible = true
	else:
		lev3Button.visible = false


func _on_level_1_button_pressed():
	Global.setLevel(1)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")


func _on_level_2_button_pressed():
	Global.setLevel(2)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")


func _on_level_3_button_pressed():
	Global.setLevel(3)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")
