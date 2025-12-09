extends Panel
@onready var bg: Sprite2D = $BG
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(item:InventoryItem):
	if not item:
		bg.frame = 0
		itemSprite.visible = false
	else:
		bg.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture
