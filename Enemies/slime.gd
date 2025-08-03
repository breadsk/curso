extends CharacterBody2D

@export var endPoint : Marker2D
@onready var slime: Sprite2D = $Slime
@onready var anims: AnimationPlayer = $AnimationPlayer


var speed = 40
var startPosition: Vector2
var endPosition: Vector2
var limit = 0.5
var lastDir = "D"

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func _physics_process(delta: float):
	move(delta)
	animCtrl()
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func move(delta: float):
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed
	move_and_collide(velocity * delta)

func animCtrl():
	##La primera animación es la predefinida
	if velocity.x > 0:
		slime.flip_h = false;
		anims.play("walkR")
		lastDir = "R"
	elif velocity.x < 0:
		slime.flip_h = true;
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


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		queue_free()
