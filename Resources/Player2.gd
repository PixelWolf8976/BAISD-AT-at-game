extends CharacterBody2D
class_name player2

@export var defaultMaxSpeed = 1250.0 * Global.speedMultiplier
@export var corneringMaxSpeed = 1000.0 * Global.speedMultiplier
@export var acceleration = 400.0 * Global.speedMultiplier

var rotationSpeed = 2.5

var currentMaxSpeed = defaultMaxSpeed
var currentTopSpeed = currentMaxSpeed
var speed = 0.0
var reachedCheckpoint := false

var type := "Blue"

func _ready():
	if Global.playerCount == 1:
		get_parent().get_parent().get_parent().get_node("Viewport2").queue_free()
		queue_free()

func _physics_process(delta):
	if speed < currentTopSpeed:
		speed += acceleration * delta
		if speed > currentTopSpeed:
			speed = currentTopSpeed
	
	if speed > currentTopSpeed:
		speed -= acceleration * 2.0 * delta
		if speed < currentTopSpeed:
			speed = currentTopSpeed
	
	velocity = Vector2(speed, 0).rotated(rotation)
	
	# code for left & right turns
	if Input.is_action_pressed("turn_left_2"):
		currentMaxSpeed = corneringMaxSpeed
		rotation -= rotationSpeed * delta
	elif Input.is_action_pressed("turn_right_2"):
		currentMaxSpeed = corneringMaxSpeed
		rotation += rotationSpeed * delta
	else:
		currentMaxSpeed = defaultMaxSpeed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	move_and_slide()
	
	$AudioStreamPlayer.pitch_scale = lerp(0.5, 1.5, velocity.length() / defaultMaxSpeed)
	$AudioStreamPlayer.volume_db = -10 + randf_range(-1.5, 1.5)
	
	currentTopSpeed = currentMaxSpeed * getSlowdown()

func getSlowdown():
	var averageAngle = 0.0
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		var angle = normal.angle()
		averageAngle += angle
	
	if get_slide_collision_count() != 0:
		averageAngle /= get_slide_collision_count()
	
	if averageAngle != 0:
		var angleInDeg = averageAngle * 180.0 / PI
		var rotInDeg = rotation * 180.0 / PI
		var angleOffZero = angleInDeg - rotInDeg
		angleOffZero = getAbsVal(angleOffZero)
		angleOffZero -= 180.0 # Makes angle == 0 hitting the wall directly
		angleOffZero = getAbsVal(angleOffZero)
		angleOffZero -= 90.0 # Makes 90 degrees hitting the wall directly (for percentage reasons)
		angleOffZero = getAbsVal(angleOffZero)
		var percentSlowdown = angleOffZero / 90.0
		percentSlowdown -= 1;
		percentSlowdown = getAbsVal(percentSlowdown)
		return percentSlowdown
	
	return 1

func getAbsVal(value):
	if value < 0:
		value *= -1
	return value


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
