extends CharacterBody2D

@export var defaultMaxSpeed = 500.0
@export var corneringMaxSpeed = 475.0
@export var wallMaxSpeed = 400.0
@export var acceleration = 200.0

@export var rotationMaxSpeed = 5
@export var rotationAcceleration = 5

var currentMaxSpeed = defaultMaxSpeed
var speed = 0.0
var rotationSpeed = 0.0
var isOnWall = false

func _physics_process(delta):
	
	if speed < currentMaxSpeed:
		speed += acceleration * delta
	
	velocity = Vector2(speed, 0).rotated(rotation)
	
	# code for left & right turns
	
	if Input.is_action_pressed("turn_left_2"):
		if rotationSpeed > 0:
			rotationSpeed -= rotationAcceleration * delta
		if rotationSpeed > -rotationMaxSpeed:
			rotationSpeed -= rotationAcceleration * delta
	elif Input.is_action_pressed("turn_right_2"):
		if rotationSpeed < 0:
			rotationSpeed += rotationAcceleration * delta
		if rotationSpeed < rotationMaxSpeed:
			rotationSpeed += rotationAcceleration * delta
	else:
		if rotationSpeed < 0:
			if isOnWall:
				currentMaxSpeed = wallMaxSpeed
			else:
				currentMaxSpeed = corneringMaxSpeed
			rotationSpeed += rotationAcceleration * 2 * delta
			if rotationSpeed > 0:
				rotationSpeed = 0
			if isOnWall:
				currentMaxSpeed = wallMaxSpeed
			else:
				currentMaxSpeed = defaultMaxSpeed
		elif rotationSpeed > 0:
			if isOnWall:
				currentMaxSpeed = wallMaxSpeed
			else:
				currentMaxSpeed = corneringMaxSpeed
			rotationSpeed -= rotationAcceleration * 2 * delta
			if rotationSpeed < 0:
				rotationSpeed = 0
			if isOnWall:
				currentMaxSpeed = wallMaxSpeed
			else:
				currentMaxSpeed = defaultMaxSpeed
		else:
			if isOnWall:
				currentMaxSpeed = wallMaxSpeed
			else:
				currentMaxSpeed = defaultMaxSpeed
	
	rotation += rotationSpeed * delta
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if move_and_slide():
		isOnWall = true
	else:
		isOnWall = false
