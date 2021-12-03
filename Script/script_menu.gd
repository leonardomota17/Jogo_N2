extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("enter")):
		chamar_ranking()
	
	
func teste():
	OS.alert('This is your message', 'Message Title')

func chamar_ranking():
	get_tree().change_scene("res://Cenas/cena_ranking.tscn")


func start_jogo():
	get_tree().change_scene("res://Cenas/cena_mundo.tscn")


func chamar_configsom():
	get_tree().change_scene("res://Cenas/cena_som.tscn")
