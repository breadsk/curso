extends CharacterBody2D

@export var endPoint : Marker2D

var speed = 70
var startPosition: Vector2
var endPosition: Vector2
var limit = 0.5

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func _physics_process(delta: float):
	move(delta)
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func move(delta: float):
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed
	move_and_slide()
