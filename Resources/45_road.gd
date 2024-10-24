extends Node2D

@export var boostersActive := true

@onready var leftBoost = $SpeedBoost
@onready var rightBoost = $"Speed boost"

# Called when the node enters the scene tree for the first time.
func _ready():
	if !boostersActive:
		leftBoost.visible = false
		leftBoost.active = false
		rightBoost.visible = false
		rightBoost.active = false
	else:
		if randi_range(0, 100) < Global.chanceOfBooster * 100:
			Global.chanceOfBooster = Global.originalChanceOfBooster
			var nextRand := randi_range(0, 100)
			if nextRand < 45:
				leftBoost.visible = false
				leftBoost.active = false
			elif nextRand < 90:
				rightBoost.visible = false
				rightBoost.active = false
		else:
			Global.chanceOfBooster *= 1.25
			leftBoost.visible = false 
			leftBoost.active = false
			rightBoost.visible = false
			rightBoost.active = false
