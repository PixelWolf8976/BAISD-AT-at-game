extends Camera2D

var target_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	target_node = get_node("%Player 1")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if target_node:
		position = target_node.position
		rotation = target_node.rotation + 1.5708
	pass
