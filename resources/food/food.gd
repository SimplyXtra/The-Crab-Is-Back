extends Sprite

var tilePosition := Vector2.ZERO
signal deleted

func _ready():
	Main.connect("tile_changed", self, "delete")

func delete(oldItem, itemTilePosition):
	if oldItem == "food_i" and itemTilePosition == tilePosition:
		emit_signal("deleted")
		queue_free()
