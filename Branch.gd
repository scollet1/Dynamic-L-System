extends Bone2D

func create_branch(start, end, angle):
	var branch = Line2D.new()
	branch.default_color = Color(0.60, 0.20, 0.16)
	branch.add_point(end)
	branch.add_point(start)
	branch.set_width(1.5)
	add_child(branch)

func on_timeout():
	apply_rest()

func on_area_entered(area):
	if area.name == "Collider":
		rotate(to_global(position).angle_to(to_global(area.position)))
		get_node("ResetTimer").start(1.2)

func _ready():
	rest = transform
	get_node("Area2D").connect("area_entered", self, "on_area_entered")
	get_node("ResetTimer").connect("timeout", self, "on_timeout")

#func _input(event):
#	if event is InputEventMouseMotion:
#		print_debug(to_global(position))
#		print_debug(to_local(event.position))
#		print(rotation)
#		rotate(to_global(position).angle_to(to_local(event.position)))
#		print(rotation)

#func _process(delta):
#	pass