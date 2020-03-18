extends PathFollow2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func on_area_entered():
	get_node("Particles2D").emitting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Collider").connect("area_entered", self, "on_area_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += delta * 100