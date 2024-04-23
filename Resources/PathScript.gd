extends Node2D

@export var colLay := 1

@onready var bar1 := $StaticBody2D
@onready var bar2 := $StaticBody2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	bar1.set_collision_layer(colLay)
	bar2.set_collision_layer(colLay)
