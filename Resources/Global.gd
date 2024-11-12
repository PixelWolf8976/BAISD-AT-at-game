extends Node

var level := -1
var playerCount := 0
var speedMultiplier := 1.5
var originalChanceOfBooster := 0.1 # Percent from 0 to 1
var chanceOfBooster := originalChanceOfBooster
var encryptionKey := 127

func saveScoreToFile(name: String, time: float) -> void:
	var filePath := ""
	
	if level == 1:
		filePath = "res://Scoreboards/Level1.txt"
	elif level == 2:
		filePath = "res://Scoreboards/Level2.txt"
	elif level == 3:
		filePath = "res://Scoreboards/Level3.txt"
	
	var content := getFileContent(filePath)
	
	var splitContent := content.split("\n", false)
	
	var names: PackedStringArray
	var times: PackedFloat64Array
	
	names.append(name)
	times.append(time)
	
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
		times.append(float(thisTime))
	
	var sorted = sortTimes(names, times)
	
	names = sorted[0]
	times = sorted[1]
	
	writeFileContent(filePath, names, times)

func sortTimes(oldNames: PackedStringArray, oldTimes: PackedFloat64Array):
	var newNames: PackedStringArray
	var newTimes: PackedFloat64Array
	
	while oldNames.size() > 0:
		var positionOfLowestTime := -1
		var lowestTime := -1.0
		
		for i in range(oldNames.size()):
			if lowestTime == -1 || oldTimes[i] < lowestTime:
				lowestTime = oldTimes[i]
				positionOfLowestTime = i
		
		newNames.append(oldNames[positionOfLowestTime])
		newTimes.append(oldTimes[positionOfLowestTime])
		
		oldNames.remove_at(positionOfLowestTime)
		oldTimes.remove_at(positionOfLowestTime)
	
	return [newNames, newTimes]

func getFileContent(path: String) -> String:
	var file := FileAccess.open(path, FileAccess.READ)
	var fileContent := file.get_as_text(true)
	file.close()
	return fileContent

func writeFileContent(path: String, names: PackedStringArray, times: PackedFloat64Array):
	var stringToStore := ""
	
	for i in range(names.size()):
		stringToStore += names[i] + ":" + String.num(times[i], 2) + "\n"
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(stringToStore)
	file.close()

func encypt(toEncrypt: String) -> String:
	var charInt := toEncrypt.to_ascii_buffer()[0]
	
	for i in range(encryptionKey):
		charInt += 1
		if charInt > 126:
			charInt = 32
	
	return char(charInt)

func decrypt(toDecrypt: String) -> String:
	var charInt := toDecrypt.to_ascii_buffer()[0]
	
	for i in range(encryptionKey):
		charInt -= 1
		if charInt < 32:
			charInt = 126
	
	return char(charInt)

func setLevel(lev):
	level = lev

func getLevel():
	return level
