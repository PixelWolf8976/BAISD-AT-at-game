extends Camera2D

@export var target_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = target_node.position
	rotation = target_node.rotation + 1.5708
	pass
