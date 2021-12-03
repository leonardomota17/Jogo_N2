extends Node2D


var tempo = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$ParallaxBackground/Sprite/vida.max_value = ScriptGlobal.qtd_vidas


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ParallaxBackground/tempo.text = "%02d" % tempo
	ScriptGlobal.tempo_jogo = int($ParallaxBackground/tempo.text)
	$ParallaxBackground/pontos.text = str(ScriptGlobal.qtd_pontos)
	$ParallaxBackground/Sprite/vida.value = ScriptGlobal.qtd_vidas

func incrementar_tempo():
	tempo += 1
