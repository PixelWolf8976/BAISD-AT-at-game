extends Area2D

@export var defaultMaxSpeed := 1250.0 * Global.speedMultiplier
@export var corneringMaxSpeed := 1000.0 * Global.speedMultiplier
@export var acceleration := 400.0 * Global.speedMultiplier
@export var speedBoost := 10.0

var active := true

func _ready() -> void:
	#speedBoost = round(0.0023 * pow(randi_range(0, 100), 2) + 2)
	$AnimatedSprite2D.speed_scale = round(speedBoost)
	$AnimatedSprite2D.play()

func _on_body_entered(body: Node2D) -> void:
	if (body is player1 || body is player2) && active:
		body.defaultMaxSpeed = defaultMaxSpeed * speedBoost
		body.corneringMaxSpeed = corneringMaxSpeed * speedBoost
		body.acceleration = acceleration * speedBoost

func _on_body_exited(body: Node2D) -> void:
	if body is player1 || body is player2:
		body.defaultMaxSpeed = defaultMaxSpeed
		body.corneringMaxSpeed = corneringMaxSpeed
		body.acceleration = acceleration
