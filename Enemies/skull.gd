extends CharacterBody2D

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var skull: Sprite2D = $Skull

@export var endPoint: Marker2D

var speed = 60
var startPosition
var endPosition
var limit = 0.5
var lastDir = "R"

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func _physics_process(delta: float):
	move()
	animCtrl()
	
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func move():
	var moveDirection = (endPosition - position)
	anims.play("waklR")
	
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized() * speed
	move_and_slide()
	
func animCtrl():
	#La primera animación es la predefinida
	if velocity.x > 0:		
		skull.flip_h = false
		anims.play("walkR")
		lastDir = "R"
	elif velocity.x < 0:
		skull.flip_h = true
		anims.play("walkR")
		lastDir = "R"
	elif velocity.y > 0:
		anims.play("walkD")
		lastDir = "D"
		
	elif velocity.y < 0:
		anims.play("walkU")
		lastDir = "U"
	else:
		anims.play("idle"+lastDir)#Lo concatena
	
	
	
	
