extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("enter")):
		enviar_requisicao()

func fechar_jogo():
	get_tree().quit()
	
func enviar_requisicao():
	var url_requisicao = ScriptGlobal.url_login
	var dados_envio = "email="+$ColorRect/email.text+"&senha="+$ColorRect/senha.text
	print(url_requisicao+dados_envio)
	var cabecalho   = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$HTTPRequest.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if (json.result.size()>0):
		ScriptGlobal.id_usuario = json.result["id"]
		ScriptGlobal.usuario = json.result["usuario"]
		ScriptGlobal.melhor_pontuacao =  json.result["melhor_pontuacao"]
		get_tree().change_scene("res://Cenas/cena_menu.tscn")
	else:
		OS.alert('E-mail ou senha incorretos', 'Falha no login')
	
func teste():
	OS.alert('This is your message', 'Message Title')






