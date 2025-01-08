extends CharacterBody2D

##Para iniciar algo antes del que juego inicie
@onready var anims: AnimationPlayer = $AnimationPlayer


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
			anims.play("walkR")

	
