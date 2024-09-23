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
	stopStopwatch()
	

func resetStopwatch():
	stopwatchRunning = false
	elapsedTime = 0.0
