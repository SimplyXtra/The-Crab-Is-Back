extends Sprite

signal deleted

func _ready():
	Main.connect("tile_changed", self, "delete")

func delete(oldItem):
	if oldItem == "food":
		emit_signal("deleted")
		queue_free()
