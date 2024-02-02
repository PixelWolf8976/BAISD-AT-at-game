extends Area2D

@export var defaultMaxSpeed = 600.0
@export var corneringMaxSpeed = 500.0
@export var acceleration = 200.0

@export var rotationMaxSpeed = 20
@export var rotationAcceleration = 10

var currentMaxSpeed
var speed = 0.0
var rotationSpeed = 0.0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # player movement vector
	
	if Input.is_action_pressed("drive_forward"):
		if speed < currentMaxSpeed:
			speed += acceleration * delta
	else:
		if speed > 0:
			speed -= acceleration * delta
	
	velocity = Vector2(speed, 0).rotated(rotation)
	
	if Input.is_action_pressed("turn_left"):
		if rotationSpeed > -rotationMaxSpeed:
			rotationSpeed -= rotationAcceleration * delta
	elif Input.is_action_pressed("turn_right"):
		if rotationSpeed < rotationMaxSpeed:
			rotationSpeed += rotationAcceleration * delta
	else:
		if rotationSpeed < 0:
			currentMaxSpeed = corneringMaxSpeed
			rotationSpeed += rotationAcceleration * 1.5 * delta
			if rotationSpeed > 0:
				rotationSpeed = 0
				currentMaxSpeed = defaultMaxSpeed
		elif rotationSpeed > 0:
			currentMaxSpeed = corneringMaxSpeed
			rotationSpeed -= rotationAcceleration * 1.5 * delta
			if rotationSpeed < 0:
				rotationSpeed = 0
				currentMaxSpeed = defaultMaxSpeed
		else:
			currentMaxSpeed = defaultMaxSpeed
	
	rotation += rotationSpeed * delta
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	pass
