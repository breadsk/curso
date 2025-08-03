extends CharacterBody2D

##Para iniciar algo antes del que juego inicie
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var effects: AnimationPlayer = $Effects
@onready var sprite: Sprite2D = $Player
@onready var hurtTimer: Timer = $HurtTimer


var speed = 50
var lastDir = "D"
var life = 5
var knockBackPower = 400
var isHurting = false

func _physics_process(_delta: float):
	move(_delta)
	animCtrl()

func move(delta):
	#Vector con los 4 mapas de entradas	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_collide(velocity * delta)

func animCtrl():
	##La primera animación es la predefinida
	if velocity.x > 0:
		sprite.flip_h = false;#El sprite se queda como esta en su dirección, solo se anima.
		anims.play("walkR")
		lastDir = "R"
	elif velocity.x < 0:
		sprite.flip_h = true;#Aqui es cuando esta yendo hacia la izquierda
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

func hurt(area):
	if isHurting: return
	life -= 1
	isHurting = true
	effects.play("hurts")
	hurtTimer.start()
	knockBack(area.get_parent().velocity)#Estamos obteniendo el padre del area y la velocidad
	print(life)
	await hurtTimer.timeout
	#await effects.animation_finished
	effects.play("RESET")
	isHurting = false

func knockBack(enemyVelocity: Vector2):#Almacena la velocidad aqui
	var knockBackDir = (enemyVelocity).normalized() * knockBackPower
	velocity = knockBackDir
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D):
	if area.is_in_group("Enemies"):
		hurt(area)
