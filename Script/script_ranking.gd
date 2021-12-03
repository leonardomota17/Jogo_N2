extends Node2D


func _input(event):
	if event.is_action_pressed("atualizar"):
		get_tree().reload_current_scene()

func _ready():
	pass
	$usuario.text = ScriptGlobal.usuario
	atualizar_ranking()

func atualizar_ranking():
	var url_requisicao = ScriptGlobal.url_ranking
	var dados_envio = "";
	var cabecalho   = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$HTTPRequest.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())

	for i in range(json.result.size()):
		var posicao = i+1
		var id_usuario = str(json.result[i]["id"])
		var pontos  = str(json.result[i]["melhor_pontuacao"])
		var usuario = str(json.result[i]["usuario"])

		
		$ItemList.add_item(str("%03s" % posicao) + str("%25s" % pontos) + str("%25s" % usuario))
		if (ScriptGlobal.id_usuario != id_usuario):
			$ItemList.set_item_custom_fg_color(i, Color( 1, 1, 1, 1 ))
		else:
			$ItemList.set_item_custom_fg_color(i, Color( 1, 0, 0, 1 ))

func _process(delta):
	if (Input.is_action_just_pressed("enter")):
		get_tree().change_scene("res://Cenas/cena_mundo.tscn")

func voltar_menu():
	get_tree().change_scene("res://Cenas/cena_menu.tscn")
