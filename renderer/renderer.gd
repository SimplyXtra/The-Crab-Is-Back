extends Node2D

onready var camera := $Camera2D
onready var tileset := $floorMaker
onready var player := $player

onready var food := load("res://resources/food/food.tscn")
onready var rock := load("res://resources/rock/rock.tscn")

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	camera.position = tileset.size / 2
	camera.zoom = Vector2.ONE / Main.tileScale
	place_rock(Vector2(2, 1))
	place_rock(Vector2(2, 2))
	place_rock(Vector2(2, 3))
	place_food()
	place_food()

func place_rock(rockTilePosition : Vector2) -> void:
	var rockInstance = rock.instance()
	
	var world = get_tree().current_scene
	world.add_child(rockInstance)
	rockInstance.position = rockTilePosition * Main.tileSize
	Main.tile_set_item(rockTilePosition, Main.resources["rock"])

func place_food() -> void:
	var foodItem = food.instance()
	var foodTilePosition := Vector2.ZERO
	while true:
		rng.randomize()
		foodTilePosition.x = rng.randi_range(0, Main.mapSize.x - 1)
		foodTilePosition.y = rng.randi_range(0, Main.mapSize.y - 1)
		if foodTilePosition != player.playerTilePosition and Main.get_tile_item(foodTilePosition) == null:
			break
	
	var world = get_tree().current_scene
	world.add_child(foodItem)
	foodItem.position = foodTilePosition * Main.tileSize
	foodItem.tilePosition = foodTilePosition
	foodItem.connect("deleted", self, "place_food")
	
	Main.tile_set_item(foodTilePosition, Main.items["food"])

