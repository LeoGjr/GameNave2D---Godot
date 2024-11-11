extends Area2D

var vel = 100


func _ready():
	pass
func _process(delta):
	position.y += vel * delta
	if position.y > 850:
		queue_free()


func _on_powerup_body_entered(body):
	body.habilitar_especial()
	body.sound_pw()
	queue_free()
