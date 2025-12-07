extends Control

var isOpen = false


func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
