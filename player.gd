extends Area2D

signal pickup
signal hurt

@export var speed:int

var velocity = Vector2()
var screensize = Vector2(480, 720)

func _ready():
	pass


func _process(delta):
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite2D.animation = "idle"


func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)


func _on_area_entered(area):
	print("area_entered")
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("powerups"):
		# signal.emit() and emit_signal() can be used interchangeably here
		area.pickup()
		emit_signal("pickup", "powerup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
