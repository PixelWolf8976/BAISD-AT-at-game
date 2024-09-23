extends CanvasLayer

var elapsedTime := 0.0
var stopwatchRunning := true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stopwatchRunning:
		elapsedTime += delta
		var out := str(round(elapsedTime * 100.0) / 100.0)
		var splitStr = out.split(".")
		if splitStr.size() > 1:
			for i in range(2 - splitStr[1].length()):
				out += "0"
		$Label.text = out

func startStopwatch():
	stopwatchRunning = true

func stopStopwatch():
	stopwatchRunning = false

func finishRace(winner):
	if stopwatchRunning:
		stopStopwatch()
		$WinnerText.visible = true
		$TextureRect.visible = true
		$WinnerText.text = winner.type + " wins!"
		if winner.type == "Red":
			$WinnerText.label_settings.font_color = Color(255, 0, 0)
		else:
			$WinnerText.label_settings.font_color = Color(0, 0, 255)

func resetStopwatch():
	stopwatchRunning = false
	elapsedTime = 0.0
