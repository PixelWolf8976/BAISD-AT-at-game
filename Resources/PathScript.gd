extends Node2D

@export var colLay := 1
@export var isOverpass := false 
@export var isPartOfOverpass := false
@export var boostersActive := true

@onready var leftBoost = $SpeedBoost
@onready var rightBoost = $"Speed boost"

@onready var bar1 := $StaticBody2D
@onready var bar2 := $StaticBody2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	if isPartOfOverpass || !boostersActive:
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
			Global.chanceOfBooster *= 1.5
			leftBoost.visible = false
			leftBoost.active = false
			rightBoost.visible = false
			rightBoost.active = false
	
	bar1.collision_layer = 1 << colLay | 1 << 0
	bar2.collision_layer = 1 << colLay | 1 << 0
	
	if isPartOfOverpass:
		$Bush.visible = false
		$Bush2.visible = false
	else:
		$Bush.rotation_degrees = 360 - rotation_degrees
		$Bush2.rotation_degrees = 360 - rotation_degrees
	
	if isOverpass:
		$StaticBody2D/Sprite2D.visible = false
		$StaticBody2D2/Sprite2D.visible = false
		$Sprite2D.texture = preload("res://Resources/Overpass Road.png")
