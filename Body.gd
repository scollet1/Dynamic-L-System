extends KinematicBody2D
#
#onready var branch = preload("res://Branch.tscn")
#
#const PLANT_B = {
#	'rules': {
#		'F': 'FF-[-F+F+F+[+F-F-F'
#	},
#	'axiom': 'F',
#	'+': 20,
#	'-': -20,
#	'dist': 0.25,
#	'scale': 0.5,
#	'heading': 270
#}
#
#const PLANT_A = {
#	'rules': {
#		'F': 'F[+FF[-F[F'
#	},
#	'axiom': 'F',
#	'+': -20,
#	'-': 20,
#	'dist': 0.40,
#	'scale': 0.5,
#	'heading': 270
#}
#
#func create_branch(start, end, i):
#	var branch = Line2D.new()
#	branch.default_color = Color(randf(), randf(), randf())
#	branch.add_point(end)
#	branch.add_point(start)
#	branch.set_width(2 / (i + 1))
#	add_child(branch)
#	return branch
#
#func grow_tree(plant, iterations=3):
#	var stack = []
#	var start = Vector2()
#	var angle = plant.heading
#	for i in range(iterations):
#		for step in plant.axiom:
#			for rule in plant.rules[step]:
#				if rule == "F":
#					var branch = Bone2D.new()
#					var end = Vector2(
#						start.x + (plant.dist * 300 * cos(deg2rad(angle))) + rand_range(-20, 20),
#						start.y + (plant.dist * 150 * sin(deg2rad(angle))) + rand_range(-20, 20)
#					)
#					create_branch(start, end, i)
#					start = end
#				elif rule == '[':
#					stack.push_back({
#						'start': start,
#						'angle': angle
#					})
#				elif rule == ']':
#					var memory = stack.pop_back()
#					start = memory.start
#					angle = memory.angle
#				elif rule == '+' or rule == '-':
#					angle += plant[rule]
#

func _ready():
	set_physics_process(true)

func __physics_process(delta):
	pass