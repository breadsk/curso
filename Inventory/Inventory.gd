class_name Inventory
extends Resource

signal updated

@export var items:Array[InventoryItem]


func insert(item:InventoryItem):
	for i in range(items.size()):
		if not items[i]:
			items[i] = item
			break
	updated.emit()
	
