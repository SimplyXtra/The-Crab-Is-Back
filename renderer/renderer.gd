extends Node2D

var spriteMap = []

onready var camera = $Camera2D
onready var tileset = $floorMaker
onready var player = $player

onready var food = load("res://resources/food/food.tscn")
onready var rock = load("res://resources/rock/rock.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	camera.position = tileset.size / 2
	camera.zoom = Vector2.ONE / Main.tileScale
	place_rock(Vector2(2, 1))
	place_rock(Vector2(2, 2))
	place_rock(Vector2(2, 3))
	place_food()

func place_rock(rockPosition):
	var rockInstance = rock.instance()
	
	var world = get_tree().current_scene
	world.add_child(rockInstance)
	rockInstance.position = rockPosition * Main.tileSize
	Main.tile_set_item(rockPosition, "rock")

func place_food():
	var salad = food.instance()
	var foodPosition := Vector2.ZERO
	while true:
		rng.randomize()
		foodPosition.x = rng.randi_range(0, Main.mapSize.x - 1)
		foodPosition.y = rng.randi_range(0, Main.mapSize.y - 1)
		if foodPosition != player.playerTilePosition and Main.get_tile_item(foodPosition) == null:
			break
	
	var world = get_tree().current_scene
	world.add_child(salad)
	salad.position = foodPosition * Main.tileSize
	salad.connect("deleted", self, "place_food")
	
	Main.tile_set_item(foodPosition, "food")

