extends Area2D

var speed = 600

func _ready():
	pass
func _process(delta):
	position.y -= speed * delta
	
	if position.y < -50:
		queue_free()
