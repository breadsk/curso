extends CharacterBody2D

var speed = 100

func _physics_process(delta: float):
	move()

func move():
	#Vector con los 4 mapas de entradas	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_slide()
