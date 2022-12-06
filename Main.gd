extends Node2D

var tileScale := 3.0
var tileSize := 32
var mapSize := Vector2(5, 5)

var map = []
signal tile_changed(oldItem, tilePosition)
#List of things: food, rock

func _ready():
	map = create_map()

func create_map():
	var newMap = []
	for y in mapSize.y:
		newMap.append([])
		for x in mapSize.x:
			newMap[y].append(null)
	return newMap

func get_tile_item(tile):
	return map[tile.y][tile.x]

func tile_swap(tile1, tile2):
	var i = map[tile1.y][tile1.x]
	map[tile1.y][tile1.x] = map[tile2.y][tile2.x]
	map[tile2.y][tile2.x] = i

func tile_set_item(tile, item):
	var oldItem = map[tile.y][tile.x]
	map[tile.y][tile.x] = item
	emit_signal("tile_changed", oldItem, tile)

func tile_clear(tile):
	var oldItem = map[tile.y][tile.x]
	map[tile.y][tile.x] = null
	emit_signal("tile_changed", oldItem, tile)

