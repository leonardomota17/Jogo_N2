extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func voltar_menu():
	get_tree().change_scene("res://Cenas/cena_menu.tscn")



func mutar(button_pressed):
	AudioServer.set_bus_mute(1, !button_pressed)

func tamanho_volume(value):
	AudioServer.set_bus_volume_db(0, value)
