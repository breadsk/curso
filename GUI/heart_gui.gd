extends Panel
@onready var sprite: Sprite2D = $Heart

func update(whole:bool):
	if whole:
		#true
		sprite.frame = 0
	else:
		#false
		sprite.frame = 4
