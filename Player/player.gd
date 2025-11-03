extends CharacterBody2D

signal healthChange

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var effects: AnimationPlayer = $Effects
@onready var sprite: Sprite2D = $Player
@onready var hurtTimer: Timer = $HurtTimer


var speed = 60
var lastDir = "D"
var attackDir = ""
var maxHealth = 5
var currentHealth = maxHealth
var knockBackPower = 500
var isHurting = false
var isAttacking = false
var enemyCollisions = []
var isDead = false

func _ready():
	$HitBox/CollisionShape2D.disabled = true

func _physics_process(_delta: float) -> void:
	if isDead:	return
	move(_delta)
	animCtrl()
	attack()
	if not isHurting:
		for enemyArea in enemyCollisions:
			hurt(enemyArea)

func _process(delta: float) -> void:
	if currentHealth <= 0 and not isDead:
		die()

func move(delta):
	#Vector con los 4 mapas de entradas	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_collide(velocity * delta)

func animCtrl():
	##La primera animación es la predefinida
	if isAttacking: return
	if velocity.x > 0:
		sprite.flip_h = false;#El sprite se queda como esta en su dirección, solo se anima.
		anims.play("walkR")
		lastDir = "R"
		attackDir = "R"
	elif velocity.x < 0:
		sprite.flip_h = true;#Aqui es cuando esta yendo hacia la izquierda
		anims.play("walkR")
		lastDir = "R"
		attackDir = "L"
	elif velocity.y > 0:
		anims.play("walkD")	
		lastDir = "D"
		attackDir = "D"
	elif velocity.y < 0:
		anims.play("walkU")
		lastDir = "U"
		attackDir = "U"
	else:
		anims.play("idle"+lastDir)#Lo concatena
		
func attack():
	if Input.is_action_just_pressed("attack"):
		isAttacking = true
		if attackDir == "D":
			anims.play("attackD")
		elif attackDir == "R":
			anims.play("attackR")
		elif attackDir == "L":
			anims.play("attackL")
		elif attackDir == "U":
			anims.play("attackU")
		await anims.animation_finished
		isAttacking = false

func hurt(area):
	
	currentHealth -= 1
	healthChange.emit(currentHealth)
	isHurting = true
	effects.play("hurts")
	hurtTimer.start()
	knockBack(area.get_parent().velocity)#Estamos obteniendo el padre del area y la velocidad
	print(maxHealth)
	await hurtTimer.timeout
	#await effects.animation_finished
	effects.play("RESET")
	isHurting = false

func die():
	if currentHealth <= 0:
		isDead = true
		anims.play("die")
		await anims.animation_finished

func knockBack(enemyVelocity: Vector2):#Almacena la velocidad aqui
	var knockBackDir = (enemyVelocity).normalized() * knockBackPower
	velocity = knockBackDir
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D):
	if area.is_in_group("Enemies"):
		enemyCollisions.append(area)


func _on_hurt_box_area_exited(area: Area2D) -> void:
	enemyCollisions.erase(area)
