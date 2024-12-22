extends CharacterBody2D

var speed = 100

func _physics_process(delta: float):
	move()

func move():
	#Vector con los 4 mapas de entradas
	#var direction = Input.get_vector("left","right","up","down").normalized()
	#velocity = direction * speed
	velocity = Input.get_vector("left","right","up","down")
	move_and_slide()
