extends CanvasLayer
@onready var inventory: Control = $InventoryGui


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("inventoryOpen"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
