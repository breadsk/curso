extends Node2D

@onready var heartsContainer: HBoxContainer = $CanvasLayer/HeartsContainer
@onready var player: CharacterBody2D = $TileMap/Player

# Called when the node enters the scene tree for the first time.
func _ready():	
	heartsContainer.maxHearts(player.maxHealth)#recibe 5
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChange.connect(heartsContainer.updateHearts)


func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
	


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false
