extends HBoxContainer

#Hacemos un preload
const HEART_GUI = preload("res://GUI/heart_gui.tscn")

func maxHearts(max:int) -> void:
	for i in range(max):
		var hearth = HEART_GUI.instantiate()
		add_child(hearth)#añade los corazones como sus hijos

func updateHearts(currentHealth):	
	var hearts = get_children()
		
	for i in range(currentHealth):
		hearts[i].update(false)# Aqui lo llena

	for i in range(currentHealth,hearts.size()):
		hearts[i].update(true)
