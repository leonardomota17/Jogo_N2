extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func ponto(body):
	ScriptGlobal.qtd_pontos += ScriptGlobal.valor_ponto_boss
	queue_free()
	$coin.play()
