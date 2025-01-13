extends CharacterBody2D

##Para iniciar algo antes del que juego inicie
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Player


var speed = 70
var lastDir = "D"

func _physics_process(_delta: float):
	move()
	animCtrl()

func move():
	#Vector con los 4 mapas de entradas	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_slide()

func animCtrl():
	##La primera animación es la predefinida
	if velocity.x > 0:
		sprite.flip_h = false;
		anims.play("walkR")
		lastDir = "R"
	elif velocity.x < 0:
		sprite.flip_h = true;
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
