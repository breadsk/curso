extends CharacterBody2D

@export var endPoint : Marker2D
@onready var slime: Sprite2D = $Slime
@onready var anims: AnimationPlayer = $AnimationPlayer


var speed = 40
var startPosition: Vector2
var endPosition: Vector2
var limit = 0.5
var lastDir = "D"
var slimeLife = 3
var isDied = false
var isHurting = false

func _ready():	
	startPosition = position
	endPosition = endPoint.global_position
	
func _physics_process(delta: float) -> void:
	if not isDied:
		move(delta)
		animCtrl()
	else:
		#Si esta muerto no hace nada mas
		return

func _process(delta: float) -> void:
	#Solo verifica muerte, no manejar animaciones aqui
	#var fps_actuales = 1.0 / delta
	#print("Ejecuciones por segundo: "  , fps_actuales)
	if slimeLife <= 0 and not isDied:
		die()

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
	if isDied: #No animar si está muerto
		return 
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

func hurt():
	if isDied:	return
	
	isHurting = true
	
	anims.stop()
	
	$Effects.play("hurts")
	await $Effects.animation_finished
	
	slimeLife -= 1	
	isHurting = false
			
	if slimeLife <= 0:
		$Effects.play("RESET")
		die()
	else:
		$Effects.play("RESET")
		

func die():
	if slimeLife <= 0 and not isDied:
		isDied = true
		anims.play("die")
		await anims.animation_finished
		queue_free()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		hurt()
