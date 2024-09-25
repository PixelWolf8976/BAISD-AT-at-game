extends CanvasLayer

var elapsedTime := 0.0
var stopwatchRunning := true

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

## For once race is finished, look for input to go back to menu
func _input(event: InputEvent):
	if !stopwatchRunning && event is InputEventKey && event.is_pressed():
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func startStopwatch():
	stopwatchRunning = true

func stopStopwatch():
	stopwatchRunning = false

func finishRace(winner):
	if stopwatchRunning:
		get_tree().paused = true
		stopStopwatch()
		$WinnerText.visible = true
		$PressKeyToExit.visible = true
		$TextureRect.visible = true
		$WinnerText.text = winner.type + " wins!"
		if winner.type == "Red":
			$WinnerText.label_settings.font_color = Color(255, 0, 0)
		else:
			$WinnerText.label_settings.font_color = Color(0, 0, 255)

func resetStopwatch():
	stopwatchRunning = false
	elapsedTime = 0.0
