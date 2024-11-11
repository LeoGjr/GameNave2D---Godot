extends AnimatedSprite

func _ready():
	play("explosao")
	pass


func _on_explosao_animation_finished():
	queue_free()
