extends Node2D

var baseTile = preload("res://floorMaker/baseTile.tscn")
var size := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	size = Main.tileSize * Main.mapSize
	
	for column in Main.mapSize.x:
		for row in Main.mapSize.y:
			var tile = baseTile.instance()
			add_child(tile)
			tile.position = global_position + (Vector2(column, row) * Main.tileSize)
