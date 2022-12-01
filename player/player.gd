extends Node2D

var playerTilePosition := Vector2.ZERO

func _process(_delta):
	playerTilePosition = move()
	global_position = playerTilePosition * Main.tileSize

func move():
	#Set movement location
	var newTilePosition = playerTilePosition + get_tile_movement()
	newTilePosition = Vector2(clamp(newTilePosition.x, 0, Main.mapSize.x - 1), clamp(newTilePosition.y, 0, Main.mapSize.y - 1))
	
	#Check movement location
	var tileItem = Main.get_tile_item(newTilePosition)
	if tileItem == "food":
		Main.tile_clear(newTilePosition)
		print("yum")
	elif tileItem == "rock":
		return playerTilePosition
	return newTilePosition

func get_tile_movement():
	var movement := Vector2(0, 0)
	if Input.is_action_just_pressed("ui_up"):
		movement.y -= 1
	if Input.is_action_just_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_just_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_just_pressed("ui_right"):
		movement.x += 1
	return movement
