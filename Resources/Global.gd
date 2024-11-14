extends Node

var level := -1
var playerCount := 0
var speedMultiplier := 1.5
var originalChanceOfBooster := 0.1 # Percent from 0 to 1
var chanceOfBooster := originalChanceOfBooster
var encryptionKey := 120

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
	
	for i in range(splitContent.size()):
		splitContent[i] = decrypt(splitContent[i])
	
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
	
	if names.size() > 5: # Saves two extra just in case
		names.resize(5)
		times.resize(5)
	
	var seen: PackedStringArray
	var seenPos: PackedInt64Array
	
	for i in range(names.size()):
		var previouslySeen := false
		
		for s in seen:
			if names[i] == s:
				previouslySeen = true
				break
		
		if previouslySeen:
			seenPos.append(i)
		else:
			seen.append(names[i])
	
	seenPos.reverse()
	
	for sPos in seenPos:
		names.remove_at(sPos)
		times.remove_at(sPos)
	
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
		stringToStore += encypt(names[i] + ":" + String.num(times[i], 2)) + "\n"
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(stringToStore)
	file.close()

func encypt(toEncrypt: String) -> String:
	var output := ""
	
	for c in toEncrypt:
		var charInt := c.to_ascii_buffer()[0]
		
		for i in range(encryptionKey):
			charInt += 1
			if charInt > 126:
				charInt = 32
		
		output += char(charInt)
	
	return output

func decrypt(toDecrypt: String) -> String:
	var output := ""
	
	for c in toDecrypt:
		var charInt := c.to_ascii_buffer()[0]
		
		for i in range(encryptionKey):
			charInt -= 1
			if charInt < 32:
				charInt = 126
		
		output += char(charInt)
	
	return output

func setLevel(lev):
	level = lev

func getLevel():
	return level
