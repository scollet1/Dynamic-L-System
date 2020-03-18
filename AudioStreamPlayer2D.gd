extends AudioStreamPlayer2D

func on_area_entered():
	print_debug("aight")
	play()

func _ready():
	get_parent().connect("on_area_entered", self, "on_area_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
