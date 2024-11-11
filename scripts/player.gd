extends KinematicBody2D

var speed = 400
const PRE_LASER = preload("res://scenes/laser.tscn")
const PRE_BRILHO = preload("res://scenes/brilho.tscn")
var especial = false
var tempo_especial = 3
var tempo_laser = 0 
var tempo_movimento = 0
var controlar_player = false
onready var pos_inicial = global_position
func _ready():
	pass
func _process(delta):
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
#	if Input.is_action_pressed("left"):
#		dir.x = -1
#	if Input.is_action_pressed("right"):
#		dir.x = 1
#	if Input.is_action_pressed("up"):
#		dir.y = -1
#	if Input.is_action_pressed("down"):
#		dir.y = 1
	if position.x <= 50:
		position.x = 50
	if position.x >= 470:
		position.x = 470 	
	if controlar_player:
		move_and_slide(dir * speed)
		if Input.is_action_just_pressed("shoot") and get_tree().get_nodes_in_group("laser").size() < 3:
			brilho($pos.global_position)
			laser(1)
	else:
		position.y -= speed * delta
		tempo_movimento += delta
		if tempo_movimento > 0.5:
			controlar_player = true
			tempo_movimento = 0
			visible = true
		
		
	if especial:
		tempo_especial -= delta
		tempo_laser += delta
		if tempo_laser > 0.2:
			laser(2)
			laser(3)
			brilho($pos_l.global_position)
			brilho($pos_r.global_position)
			tempo_laser = 0
		if tempo_especial <= 0:
			especial = false
			tempo_especial = 3
	
func laser(tipo):
	$sound_laser.play()
	var l = PRE_LASER.instance()
	if tipo == 1:
		l.position = get_node("pos").global_position
		l.add_to_group("laser")
	elif tipo == 2:
		l.position = get_node("pos_l").global_position
		l.add_to_group("especial")
		l.scale *= 0.5 
	else:
		l.position = get_node("pos_r").global_position
		l.add_to_group("especial")
		l.scale *= 0.5 
	get_parent().add_child(l)
	
	
	
func brilho(node_pos):
	var b = PRE_BRILHO.instance()
	b.position = node_pos
	get_parent().add_child(b)
func habilitar_especial():
	especial = true
func sound_pw():
	$sound_pw.play()
