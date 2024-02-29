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
	
	if Input.is_action_pressed("turn_left_1"):
		if rotationSpeed > 0:
			rotationSpeed -= rotationAcceleration * delta
		if rotationSpeed > -rotationMaxSpeed:
			rotationSpeed -= rotationAcceleration * delta
	elif Input.is_action_pressed("turn_right_1"):
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
	
	move_and_slide()
	
	var collNorm = getAverageCollisionNormal()
	if collNorm != Vector2.ZERO:
		var collAngle = velocity.angle_to(collNorm) * 180 / PI
		var rotInDeg = rotation * 180 / PI
		
		var rotDiff = collAngle - rotInDeg
		if rotDiff < 0:
			rotDiff *= -1
		
		print(rotDiff)
		var slowDownPercent = 100 - ((rotDiff / 90) * 100)
		print(slowDownPercent)
		print("%")

func getAverageCollisionNormal():
	var normal = Vector2.ZERO
	var normalCount = 0
	for i in range(get_slide_collision_count()):
		var slide = get_slide_collision(i)
		if slide.get_collider():
			normal += slide.get_normal()
			normalCount += 1
	
	if normalCount > 0:
		return normal / normalCount
	else:
		return Vector2.ZERO
