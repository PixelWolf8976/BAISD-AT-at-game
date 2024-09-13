extends Node2D

@export var colLay := 1

@onready var bar1 := $StaticBody2D
@onready var bar2 := $StaticBody2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	bar1.collision_layer = 1 << colLay | 1 << 0
	bar2.collision_layer = 1 << colLay | 1 << 0
