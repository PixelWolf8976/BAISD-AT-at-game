extends Area2D

signal hitWall

@export var defaultMaxSpeed = 500.0
@export var corneringMaxSpeed = 475.0
@export var acceleration = 200.0

@export var rotationMaxSpeed = 5
@export var rotationAcceleration = 5

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
		if speed < 0:
			speed = 0
	print (speed)
	velocity = Vector2(speed, 0).rotated(rotation)
	
	if Input.is_action_pressed("turn_left"):
		if rotationSpeed > 0:
			rotationSpeed -= rotationAcceleration * delta
		if rotationSpeed > -rotationMaxSpeed:
			rotationSpeed -= rotationAcceleration * delta
	elif Input.is_action_pressed("turn_right"):
		if rotationSpeed < 0:
			rotationSpeed += rotationAcceleration * delta
		if rotationSpeed < rotationMaxSpeed:
			rotationSpeed += rotationAcceleration * delta
	else:
		if rotationSpeed < 0:
			currentMaxSpeed = corneringMaxSpeed
			rotationSpeed += rotationAcceleration * 2 * delta
			if rotationSpeed > 0:
				rotationSpeed = 0
				currentMaxSpeed = defaultMaxSpeed
		elif rotationSpeed > 0:
			currentMaxSpeed = corneringMaxSpeed
			rotationSpeed -= rotationAcceleration * 2 * delta
			if rotationSpeed < 0:
				rotationSpeed = 0
				currentMaxSpeed = defaultMaxSpeed
		else:
			currentMaxSpeed = defaultMaxSpeed
	
	rotation += rotationSpeed * delta
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	pass


func _on_body_entered(body):
	
	pass # Replace with function body.
