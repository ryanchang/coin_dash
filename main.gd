extends Node

@export var Coin:PackedScene
@export var Powerup:PackedScene
@export var playtime:int

var level
var score
var time_left
var screensize
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()


func _process(_delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
		$PowerupTimer.wait_time = randi_range(5, 10)
		$PowerupTimer.start()
	if not playing and Input.is_action_pressed("ui_accept"):
		new_game()


func new_game():
	$HUD/BottomMarginContainer/StartButton.hide()
	$HUD/MessageLabel.hide()
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)


func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instantiate()
		c.screensize = screensize
		var x = randi_range(0, screensize.x)
		var y = randi_range(0, screensize.y)
		c.position = Vector2(x, y)
		$CoinContainer.add_child(c)
	$LevelSound.play()


func game_over():
	$EndSound.play()
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()


func _on_game_timer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_player_pickup(type):
	match type:
		"coin":
			$CoinSound.play()
			score += 1
			$HUD.update_score(score)
		"powerup":
			time_left += 5
			$PowerupSound.play()
			$HUD.update_timer(time_left)


func _on_player_hurt():
	game_over()


func _on_powerup_timer_timeout():
	var p = Powerup.instantiate()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(randi_range(0, screensize.x),
		randi_range(0, screensize.y))
