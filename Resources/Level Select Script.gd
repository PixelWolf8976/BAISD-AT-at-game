extends Control

@onready var lev1Button := $Level1Button
@onready var lev2Button := $Level2Button
@onready var lev3Button := $Level3Button

@onready var lev1Score: Label = $Level1Scoreboard
@onready var lev2Score: Label = $Level2Scoreboard
@onready var lev3Score: Label = $Level3Scoreboard

var levelOn := 1

func _ready() -> void:
	for i in range(1, 4):
		var scoreboard := get_node("Level" + str(i) + "Scoreboard")
		var fileContent := Global.getFileContent("res://Scoreboards/Level" + str(i) + ".txt")
		
		var splitContent := fileContent.split("\n", false)
		
		var names: PackedStringArray
		var times: PackedStringArray
		
		for s in splitContent:
			var hasHitColon := false
			var thisName := ""
			var thisTime := ""
			for c in s:
				if hasHitColon:
					thisTime += c
				else:
					if c == ":":
						hasHitColon = true
					else:
						thisName += c
			
			names.append(thisName)
			times.append(thisTime)
		
		var nextLabelText := "Leaderboard\n\n1. "
		
		if names.size() >= 1:
			nextLabelText += names[0] + " : " + times[0]
		else:
			nextLabelText += "---"
		nextLabelText += "\n2. "
		
		if names.size() >= 2:
			nextLabelText += names[1] + " : " + times[1]
		else:
			nextLabelText += "---"
		nextLabelText += "\n3. "
		
		if names.size() >= 3:
			nextLabelText += names[2] + " : " + times[2]
		else:
			nextLabelText += "---"
		
		scoreboard.text = nextLabelText

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
		lev1Score.visible = true
	else:
		lev1Button.visible = false
		lev1Score.visible = false
	
	if levelOn == 2:
		lev2Button.visible = true
		lev2Score.visible = true
	else:
		lev2Button.visible = false
		lev2Score.visible = false
	
	if levelOn == 3:
		lev3Button.visible = true
		lev3Score.visible = true
	else:
		lev3Button.visible = false
		lev3Score.visible = false

func _on_level_1_button_pressed():
	Global.setLevel(1)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")

func _on_level_2_button_pressed():
	Global.setLevel(2)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")

func _on_level_3_button_pressed():
	Global.setLevel(3)
	get_tree().change_scene_to_file("res://Scenes/splitscreen test.tscn")
