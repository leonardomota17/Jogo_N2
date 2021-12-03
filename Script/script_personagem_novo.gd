extends KinematicBody2D

var velocidade = Vector2()
var direcao = 1
const forca_pulo = -400

var estado := 4
enum {ANDAR, ATAQUE, PULAR, CAIR,PARADO}

var enter_estado := true

func _physics_process(delta):
	_verificar_chao_mapa()
	match estado:
		ANDAR:
			_andar(delta)
		ATAQUE:
			_ataque(delta)
		PULAR:
			_pular(delta)
		CAIR:
			_cair(delta)
		PARADO:
			_parado(delta)

#Estados Functions
func _andar(_delta):
	$AnimationPlayer.play("correndo")
	_mover()
	_gravidade(_delta)
	_move_and_slide()
	_setar_estado(_checar_andar())
	
func _ataque(_delta):
	$AnimationPlayer.play("ataque")
	$tiro.play()
	_gravidade(_delta)
	_move_and_slide()
	
func _pular(_delta):
	if enter_estado:
		$AnimationPlayer.play("pulando")
		velocidade.y = forca_pulo
		enter_estado = false
	_gravidade(_delta)
	_mover()
	_move_and_slide()
	_setar_estado(_checar_pular())

func _cair(_delta):
	$AnimationPlayer.play("cair")
	_gravidade(_delta)
	_move_and_slide()
	_setar_estado(_checar_cair())

func _parado(_delta):
	$AnimationPlayer.play("parado")
	_gravidade(_delta)
	velocidade.x = 0
	_move_and_slide()
	_setar_estado(_checar_parado())

func _soltar_poder():
	var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
	var objeto_tiro = cena_tiro.instance()
	objeto_tiro.global_position = $Position2D.global_position
	objeto_tiro.direcao = direcao
	get_tree().root.add_child(objeto_tiro)
	
#AJUDANTES
func _gravidade(_delta):
	velocidade.y += 800 * _delta

func _move_and_slide():
	velocidade = move_and_slide(velocidade, Vector2.UP)

func _mover():
	if Input.is_action_pressed("ui_left"):
		velocidade.x = -150
		$Sprite.flip_h = true
		direcao = -1
	if Input.is_action_pressed("ui_right"):
		velocidade.x = 150
		$Sprite.flip_h = false
		direcao = 1

func _setar_estado(novo_estado):
	if novo_estado != estado:
		enter_estado = true
	estado = novo_estado

#checar funções
func _checar_parado():
	var novo_estado = estado
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		novo_estado = ANDAR
	if Input.is_action_pressed("ui_up"):
		novo_estado = PULAR
	elif Input.is_action_pressed("tiro"):
		novo_estado = ATAQUE
		var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
		var objeto_tiro = cena_tiro.instance()
		objeto_tiro.global_position = $Position2D.global_position
		objeto_tiro.direcao = direcao
		get_tree().root.add_child(objeto_tiro)
	return novo_estado

func _checar_andar():
	var novo_estado = estado
	if (not Input.is_action_pressed("ui_left")) and (not Input.is_action_pressed("ui_right")):
		novo_estado = PARADO
	elif Input.is_action_just_pressed("tiro"):
		novo_estado = ATAQUE
		var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
		var objeto_tiro = cena_tiro.instance()
		objeto_tiro.global_position = $Position2D.global_position
		objeto_tiro.direcao = direcao
		get_tree().root.add_child(objeto_tiro)
	elif Input.is_action_pressed("ui_up"):
		novo_estado = PULAR
	return novo_estado

func _checar_pular():
	var novo_estado = estado
	if velocidade.y >= 0:
		novo_estado = CAIR
	if Input.is_action_just_pressed("tiro"):
		novo_estado = ATAQUE
		var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
		var objeto_tiro = cena_tiro.instance()
		objeto_tiro.global_position = $Position2D.global_position
		objeto_tiro.direcao = direcao
		get_tree().root.add_child(objeto_tiro)
	return novo_estado

func _checar_cair():
	var novo_estado = estado
	if is_on_floor():
		novo_estado = PARADO
	elif Input.is_action_just_pressed("tiro"):
		novo_estado = ATAQUE
		var cena_tiro = preload("res://Cenas/cena_tiro.tscn")
		var objeto_tiro = cena_tiro.instance()
		objeto_tiro.global_position = $Position2D.global_position
		objeto_tiro.direcao = direcao
		get_tree().root.add_child(objeto_tiro)
	return novo_estado

func fim_animacao(anim_name):
		print($AnimationPlayer.current_animation)
		_setar_estado(PARADO)
		
func _verificar_chao_mapa():
	if global_position.y > get_viewport().size.y+300:
		$morte.play()
		get_tree().change_scene("res://Cenas/cena_morte.tscn")
		ScriptGlobal.qtd_pontos = 0
