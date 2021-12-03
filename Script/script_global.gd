extends Node

var site = "http://joguimfacu.freevar.com"
var url_login     = site + "/bd/dao/jogo_autenticar.php?"
var url_ranking   = site + "/bd/dao/jogo_ranking.php?"
var url_atualizar = site + "/bd/dao/jogo_atualizar.php?"

var personagem : KinematicBody2D
var mapa_da_fase : TileMap

var periodo = "Dia"
var qtd_vidas = 3
var qtd_inimigos = 0
var qtd_pontos = 0
var valor_ponto = 100
var tempo_jogo = 0
var vida_boss = 3
var valor_ponto_boss= 300

var id_usuario = 0
var usuario = ""
var melhor_pontuacao = 0




