extends Node2D

const PRE_INIMIGO = preload("res://scenes/inimigo.tscn")
const PRE_POWERUP = preload("res://scenes/powerup.tscn")
var tempo = 0
var tempo_max = 1
var tempo_pw = 0
var tempo_max_pw = 8
var tempo_restante = 50
var tempo_passar_fase = 0
func _ready():
	randomize()
	pass

func _process(delta):
	if $passar_fase.visible:
		tempo_passar_fase += delta 
		if tempo_passar_fase > 2:
			get_tree().change_scene("res://scenes/fase2.tscn")
	$tempo.text = str(int(tempo_restante))
	tempo_restante -= delta
	if tempo_restante < 1:
		tempo_restante = 0
		$tempo.visible = false
	if tempo_restante > 0: 
		tempo += delta
		if tempo > tempo_max:
			spawn_enemy()
			tempo_max = rand_range(1, 3)
			tempo = 0
		
	tempo_pw += delta
	if tempo_pw > tempo_max_pw:
		powerup()
		tempo_pw = 0
		tempo_max_pw = int(rand_range(7, 9))
	
	
func spawn_enemy():
	var inimigo = PRE_INIMIGO.instance()
	inimigo.position = Vector2(rand_range(50, 480), -100)
	add_child(inimigo)
	pass
func powerup():
	var pw = PRE_POWERUP.instance()
	pw.position = Vector2(rand_range(50, 480), -100)
	add_child(pw)
