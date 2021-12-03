extends Node2D

var passo = 600
var mov = Vector2(-2,0)
var direcao = 1

func _process(delta):
	mov.x = passo * delta * direcao
	position += mov
	
func _on_Tiro_body_entered(body):
		if (body.name != "personagem_novo"):
			queue_free()


func _on_Tiro_area_entered(area):
	if (area.name != "personagem_novo"):
			queue_free()
