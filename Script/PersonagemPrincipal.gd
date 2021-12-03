extends KinematicBody2D

const alto = Vector2(0, -1)
const gravidade = 20
const velocidade = 150
const forca_pulo = -500
var movimentacao = Vector2()
var direcao = 1

func _ready():
	get_node("AnimatedSprite").play("Parado")
		
func _physics_process(delta):

	movimentacao.y += gravidade

	if Input.is_action_pressed("ui_right"):
		
		movimentacao.x = velocidade
		$AnimatedSprite.flip_h = false
		direcao = 1
	elif Input.is_action_pressed("ui_left"):
		get_node("AnimatedSprite").play("Correndo")
		movimentacao.x = - velocidade
		$AnimatedSprite.flip_h = true
		direcao = -1
	else:
		movimentacao.x = 0
		get_node("AnimatedSprite").play("Parado")
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
				get_node("AnimatedSprite").play("Pulando")
				movimentacao.y = forca_pulo
	
	movimentacao = move_and_slide(movimentacao, alto)
	
	#Atirar
	if (Input.is_action_just_pressed("tiro")):
		var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
		var objeto_tiro = cena_tiro.instance()
		objeto_tiro.global_position = $Position2D.global_position
		objeto_tiro.direcao = direcao
		get_tree().root.add_child(objeto_tiro)
