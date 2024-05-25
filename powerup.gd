extends Area2D

var screensize = Vector2()

func _ready():
	#$Tween.interpolate_property($AnimatedSprite2D,
	#'scale',
	#$AnimatedSprite2D.scale,
	#$AnimatedSprite2D.scale * 3, 0.3,
	#Tween.TRANS_QUAD,
	#Tween.EASE_IN_OUT)
	pass


func pickup():
	set_deferred("monitoring", false)
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D,
		'scale',
		$AnimatedSprite2D.scale * 3,
		0.3)
	tween.tween_property($AnimatedSprite2D,
		'modulate',
		Color(1,1,1,0),
		0.3)
	tween.set_trans(tween.TRANS_QUAD)
	tween.set_ease(tween.EASE_IN_OUT)	
	tween.connect("finished", on_tween_finished)


func on_tween_finished():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, screensize.x),
			randi_range(0, screensize.y))

func on_timer_timeout():
	queue_free()
