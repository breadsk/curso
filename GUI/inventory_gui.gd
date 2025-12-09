extends Control

signal opened
signal closed

@onready var inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var isOpen = false

func _ready() -> void:
	update()

func update():
	for i in range(min(inventory.items.size(),slots.size())):
		slots[i].update(inventory.items[i])


func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()
