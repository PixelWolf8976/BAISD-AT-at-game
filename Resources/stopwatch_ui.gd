extends CanvasLayer

var elapsedTime := 0.0
var stopwatchRunning := true
var endElapsedTime := 0.0
var finishRaceWaitTime := 1.0
var textFocused := false
var winnerType := ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !get_tree().paused:
		if stopwatchRunning:
			elapsedTime += delta
			var out := str(round(elapsedTime * 100.0) / 100.0)
			var splitStr = out.split(".")
			if splitStr.size() > 1:
				for i in range(2 - splitStr[1].length()):
					out += "0"
			$Label.text = out
	elif $WinnerText.visible:
		endElapsedTime += delta
		if endElapsedTime > finishRaceWaitTime:
			$PressKeyToExit.visible = true

## For once race is finished, look for input to go back to menu
func _input(event: InputEvent):
	if !textFocused && !stopwatchRunning && event is InputEventKey && event.is_pressed() && endElapsedTime > finishRaceWaitTime:
		var name: String = $LineEdit.text
		if name.is_empty():
			name = winnerType
		Global.saveScoreToFile(name, elapsedTime)
		
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	elif textFocused && !stopwatchRunning && event is InputEventKey && event.is_pressed() && event.is_action_pressed("Enter"):
		$LineEdit.release_focus()

func startStopwatch():
	stopwatchRunning = true

func stopStopwatch():
	stopwatchRunning = false

func finishRace(winner):
	if stopwatchRunning:
		get_tree().paused = true
		stopStopwatch()
		$WinnerText.visible = true
		$TextureRect.visible = true
		$LineEdit.visible = true
		$LineEdit.grab_focus()
		$WinnerText.text = winner.type + " wins!"
		winnerType = winner.type
		if winner.type == "Red":
			$WinnerText.label_settings.font_color = Color(255, 0, 0)
		else:
			$WinnerText.label_settings.font_color = Color(0, 0, 255)

func resetStopwatch():
	stopwatchRunning = false
	elapsedTime = 0.0

func _on_line_edit_focus_entered() -> void:
	textFocused = true

func _on_line_edit_focus_exited() -> void:
	textFocused = false
