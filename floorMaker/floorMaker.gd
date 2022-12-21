extends Node2D

export var grassTiles := {
	0 : {"texture": preload("res://textures/floorTiles/grassFloor1.png"), "weight": 2},
	1 : {"texture": preload("res://textures/floorTiles/grassFloor2.png"), "weight": 7},
	2 : {"texture": preload("res://textures/floorTiles/grassFloor3.png"), "weight": 1}
}
var rng := RandomNumberGenerator.new()
var size := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	
	size = Main.tileSize * Main.mapSize
	var weight = grassTiles[0].weight + grassTiles[1].weight + grassTiles[2].weight
	
	for column in Main.mapSize.x:
		for row in Main.mapSize.y:
			rng.randomize()
			var tileType := rng.randi_range(0, weight)
			var tileTexture = null
			for i in grassTiles:
				if tileType > grassTiles[i].weight:
					tileType -= grassTiles[i].weight
				else:
					tileTexture = grassTiles[i].texture
					break
			var tile = Sprite.new()
			tile.centered = false
			tile.texture = tileTexture
			add_child(tile)
			tile.position = global_position + (Vector2(column, row) * Main.tileSize)
