extends Node2D

var flip = true
var posicao_inicial
var posicao_final
var vivo = true
var velocidade = 0.5


func _ready():
 posicao_inicial = $".".position.x
 posicao_final = posicao_inicial + 100


func _process(delta):
	if(posicao_inicial <= posicao_final and flip):
		$".".position.x += velocidade
		$Area2D/Sprite.flip_h = true
		if($".".position.x >= posicao_final):
			flip = false
			
	if($".".position.x >= posicao_inicial and !flip):
		$".".position.x -= velocidade 
		$Area2D/Sprite.flip_h = false
		if($".".position.x < posicao_inicial):
			flip = true

func dano_monstro():
	$".".queue_free()

func dano_tiro(area):
	if (area.name == "Tiro" and vivo):
		vivo = false
		queue_free()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		var cena_ponto = preload("res://Cenas/cena_ponto.tscn")
		var objeto_ponto = cena_ponto.instance()
		objeto_ponto.global_position = global_position
		get_tree().root.add_child(objeto_ponto)
	
func colisao_com_corpo(body):
	ScriptGlobal.qtd_vidas -= 1
	if (ScriptGlobal.qtd_vidas<=0):
		get_tree().change_scene("res://Cenas/cena_morte.tscn")
	
