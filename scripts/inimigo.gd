extends Area2D

var vel = 300
const PRE_EXPLOSAO = preload("res://scenes/explosao.tscn")
var vida = 1

func _ready():
	pass
func _process(delta):
	position.y += vel * delta
	
	if position.y > 850:
		queue_free()
		
	if vida < 1:
		explosao()
		get_parent().get_node("passar_fase").visible = true
		queue_free()


func _on_inimigo_area_entered(area):
	if area.is_in_group("laser") or area.is_in_group("especial"):
		vida -= 1
		#explosao()
		#queue_free()
		area.queue_free()
		
func explosao():
	var e = PRE_EXPLOSAO.instance()
	e.position = position
	get_parent().add_child(e)


func _on_inimigo_body_entered(body):
	body.global_position = body.pos_inicial
	body.controlar_player = false
	body.especial = false
	queue_free()
