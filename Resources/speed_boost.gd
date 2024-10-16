extends Area2D

@export var defaultMaxSpeed := 1250.0 * Global.speedMultiplier
@export var corneringMaxSpeed := 1000.0 * Global.speedMultiplier
@export var acceleration := 400.0 * Global.speedMultiplier
@export var speedBoost := 10.0

func _ready() -> void:
	$AnimatedSprite2D.speed_scale = round(speedBoost)
	$AnimatedSprite2D.play()

func _on_body_entered(body: Node2D) -> void:
	body.defaultMaxSpeed = defaultMaxSpeed * speedBoost
	body.corneringMaxSpeed = corneringMaxSpeed * speedBoost
	body.acceleration = acceleration * speedBoost

func _on_body_exited(body: Node2D) -> void:
	body.defaultMaxSpeed = defaultMaxSpeed
	body.corneringMaxSpeed = corneringMaxSpeed
	body.acceleration = acceleration
