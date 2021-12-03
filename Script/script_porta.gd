extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var nova_pontuacao = ScriptGlobal.qtd_pontos
	print("pontuacao --", nova_pontuacao)

func fim_jogo(body):
	var nova_pontuacao = ScriptGlobal.qtd_pontos - ScriptGlobal.tempo_jogo
	print(nova_pontuacao)
	
	if (int(ScriptGlobal.melhor_pontuacao) < nova_pontuacao):
		print("pontuacao --", nova_pontuacao)
		atualizar_pontos(nova_pontuacao)
		ScriptGlobal.qtd_pontos = 0
	else:
		get_tree().change_scene("res://Cenas/cena_vitoria.tscn")
		ScriptGlobal.qtd_pontos = 0

func ativar_porta(body):
	$fim/porta.play("abrindoporta")
	
func atualizar_pontos(nova_pontuacao):
	var url = ScriptGlobal.url_atualizar
	var dados_envio = "id="+str(ScriptGlobal.id_usuario) +"&nova_pontuacao="+str(nova_pontuacao)
	#var cabecalho   = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	#$HTTPRequest.request(url, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST
	var cabecalho   = ["Content-Type: application/json"] #para GET usamos application/json
	$HTTPRequest.request(url + dados_envio, cabecalho, false)# requisicao para GET
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if (json.result["msg"]=="ok"):
		print("Sucesso")
		get_tree().change_scene("res://Cenas/cena_vitoria.tscn")
	else:
		print("Falha")


func _on_area2d_ativar_body_exited(body):
	$fim/porta.play("fecharporta")
