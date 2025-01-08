extends CharacterBody2D

##Para iniciar algo antes del que juego inicie
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Player


var speed = 100

func _physics_process(delta: float):
	move()
	animCtrl()

func move():
	#Vector con los 4 mapas de entradas	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_slide()

func animCtrl():
	if velocity.x > 0:
		sprite.flip_h = false;
		anims.play("walkR")
	elif velocity.x < 0:
		sprite.flip_h = true;
		anims.play("walkR")
	elif velocity.y > 0:
		anims.play("walkD")	
	elif velocity.y < 0:
		anims.play("walkU")
	else:
		anims.play("idleD")
